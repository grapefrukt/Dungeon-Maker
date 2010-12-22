package {
	
	import flash.geom.Point;
	
	/**
	 * Licensed under the MIT License
	 * 
	 * Copyright (c) 2010 Martin Jonasson
	 * 
	 * Permission is hereby granted, free of charge, to any person obtaining a copy
	 * of this software and associated documentation files (the "Software"), to deal
	 * in the Software without restriction, including without limitation the rights
	 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the Software is
	 * furnished to do so, subject to the following conditions:
	 * 
	 * The above copyright notice and this permission notice shall be included in
	 * all copies or substantial portions of the Software.
	 * 
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 * THE SOFTWARE.
	 * 
	 * http://www.prototyprally.com/dungeonmaker/
	 * 
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