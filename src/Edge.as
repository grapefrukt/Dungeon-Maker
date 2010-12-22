package  {
	import flash.geom.Point;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Edge {
		
		public var x		:int = 0;
		public var y		:int = 0;
		public var length	:int = 0;
		public var direction:int = Room.HORIZONTAL;
		
		public var room1	:Room;
		public var room2	:Room;
		
		public function Edge(room1:Room, room2:Room) {
			if (room1.index < room2.index) {
				this.room1 = room1;
				this.room2 = room2;
			} else {
				this.room1 = room2;
				this.room2 = room1;
			}
		}
		
		public function getCenter():Point {
			if (direction == Room.HORIZONTAL) {
				return new Point(x + length / 2, y);
			}
			
			return new Point(x, y + length / 2);
		}
	}

}