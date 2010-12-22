package  {
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Dungeon {
		
		// these babies hold all the data
		private var _rooms:Vector.<Room>;
		private var _doors:Vector.<Door>;
		private var _edges:Vector.<Edge>;
		
		public function Dungeon() {
			// nothing happens here, we save all initialization for the reset method
			// there's no real reason for this, it's just convenient
		}
		
		public function reset():void {
			_rooms = new Vector.<Room>;
			_doors = new Vector.<Door>;
			_edges = new Vector.<Edge>;
			
			// iteratively split the rooms into smaller parts
			split();
			
			// shuffle their order
			shuffle();
			
			var room:Room;
			// for each room, find all adjacent rooms
			for each (room in _rooms) room.findAdjacent(_rooms);
			// randomly merge rooms with their neighbours
			for each (room in _rooms) room.randomMerge();
			// work out where the walls should be
			for each (room in _rooms) room.findEdges(_edges);
			
			removeDuplicateEdges();
			
			makeDoors();
			
			removeDuplicateDoors();
			
			for each (var door:Door in _doors) door.linkRooms();
			
			removeChildlessRooms();
			
			randomRemoveDoors();
			
			_rooms = purgeOrphanedRooms(_rooms[int( Math.random() * _rooms.length)]);
		}
		
		protected function split():void {
			// we start by creating a big room the same size as the dungeon
			_rooms.push(new Room(0, 0, Settings.GRID_W, Settings.GRID_H));
			
			// then we do a bunch of splitting sweeps on this
			for (var sweeps:int = 0; sweeps < Settings.SPLITTING_SWEEPS; sweeps++) {
				
				// for each sweep we split each room into two parts
				// we loop over the list in reverse, so any rooms that are added inside this loop
				// won't be split until the next sweep
				for (var i:int = _rooms.length - 1; i >= 0; i--) {
					
					// the split function splits the room in half and returns the new half.
					// each room needs a unique index, so we pass along the lenght of the room list to use for that
					var newRoom:Room = _rooms[i].split(_rooms.length + 1);
					_rooms.push(newRoom);
				}
			}
		}
		
		/**
		 * Shuffles the order of the rooms
		 */
		protected function shuffle():void {
			// we need two intermediary vars:
			var tmp:Room;
			var rnd:int;
			
			// loop over the entire list of rooms
			for (var i:int = _rooms.length - 1; i >= 0; --i) {
				// pick a random index in the room list
				rnd = Math.random() * _rooms.length;
				
				// stick the room the current index in the temp var
				tmp = _rooms[i];
				
				// set that index to the randomly chosen room
				_rooms[i] = _rooms[rnd];
				
				// and put the room from the index in the random rooms spot
				_rooms[rnd] = tmp;
			}
		}
		
		protected function removeDuplicateEdges():void {
			_edges.sort(_edge_sort);
			
			var index1:int = -1;
			var index2:int = -1;
			var edge:Edge;
			for (var i:int = _edges.length - 1; i >= 0; --i) {
				edge = _edges[i];
				
				if (index1 == edge.room1.index && index2 == edge.room2.index) {
					_edges.splice(i, 1);
				}
				
				index1 = edge.room1.index;
				index2 = edge.room2.index;
			}
		}
		
		private function _edge_sort(one:Edge, two:Edge):Number {
			if (one.room1.index > two.room1.index) return  1;
			if (one.room1.index < two.room1.index) return -1;
			if (one.room2.index > two.room2.index) return  1;
			if (one.room2.index < two.room2.index) return -1;
			
			return 0;
		}
		
		protected function removeDuplicateDoors():void{
			_doors.sort(_door_sort);
			
			var index1:int = -1;
			var index2:int = -1;
			var door:Door;
			for (var i:int = _doors.length - 1; i >= 0; --i) {
				door = _doors[i];
				
				if (index1 == door.parentRoom1.index && index2 == door.parentRoom2.index) {
					_doors.splice(i, 1);
				}
				
				index1 = door.parentRoom1.index;
				index2 = door.parentRoom2.index;
			}
		}
		
		private function _door_sort(one:Door, two:Door):Number {
			if (one.parentRoom1.index > two.parentRoom1.index) return  1;
			if (one.parentRoom1.index < two.parentRoom1.index) return -1;
			if (one.parentRoom2.index > two.parentRoom2.index) return  1;
			if (one.parentRoom2.index < two.parentRoom2.index) return -1;
			
			return 0;
		}
		
		protected function makeDoors():void {
			for each(var edge:Edge in _edges) {
				_doors.push(new Door(edge));
			}
		}
		
		protected function removeChildlessRooms():void{
			for (var i:int = _rooms.length - 1; i >= 0; --i) {
				if (!_rooms[i].hasMergedRooms) _rooms.splice(i, 1);
			}
		}
		
		protected function randomRemoveDoors():void{
			for (var i:int = _doors.length - 1; i >= 0; --i) {
				if (Math.random() < Settings.DOOR_REMOVAL_CHANCE) {
					_doors[i].unlinkRooms();
					_doors.splice(i, 1);
				}
			}
		}
		
		protected function purgeOrphanedRooms(startRoom:Room):Vector.<Room> {
			var completed	:Vector.<Room> = new Vector.<Room>;
			var queue		:Vector.<Room> = new Vector.<Room>;
			
			queue.push(startRoom);
			
			var room:Room;
			while (queue.length > 0) {
				room = queue[0];
				for each(var doorsToRoom:Room in room.doorsToRooms) queue.push(doorsToRoom);
				completed.push(room);
				
				//remove all waiting rooms that have already been checked
				for (var i:int = queue.length - 1; i >= 0; i--) {
					if (completed.indexOf(queue[i]) >= 0) queue.splice(i, 1);
				}
			}
			
			return completed;
		}
		
		public function get roomCount():int { return _rooms.length };
		public function get rooms():Vector.<Room> { return _rooms; }
		public function get doors():Vector.<Door> { return _doors; }
		public function get edges():Vector.<Edge> { return _edges; }
	
		public function get roomsHead():Room { return _rooms.length ? _rooms[0] : null; }
		public function get roomsTail():Room { return _rooms.length ? _rooms[_rooms.length - 1] : null; }
		
	}

}