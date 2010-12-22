package  {
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Door {
		
		public var x			:int = 0;
		public var y			:int = 0;
		public var direction	:int = 0;
		public var parentRoom1	:Room;
		public var parentRoom2	:Room;
		
		public function Door(edge:Edge) {
			var center:Point = edge.getCenter();
			x = center.x;
			y = center.y;
			
			direction = edge.direction;
			
			parentRoom1 = edge.room1.parent || edge.room1;
			parentRoom2 = edge.room2.parent || edge.room2;
			
			if (parentRoom1.index > parentRoom2.index) {
				var tmpRoom:Room = parentRoom1;
				parentRoom1 = parentRoom2;
				parentRoom2 = tmpRoom;
			}
		}
		
		public function linkRooms():void {
			parentRoom1.addDoorToRoom(parentRoom2);
			parentRoom2.addDoorToRoom(parentRoom1);
		}
		
		public function unlinkRooms():void {
			parentRoom1.removeDoorToRoom(parentRoom2);
			parentRoom2.removeDoorToRoom(parentRoom1);
		}

	}

}