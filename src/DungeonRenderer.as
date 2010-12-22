package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class DungeonRenderer {
		
		public static function render(dungeon:Dungeon):BitmapData {
			var bitmap:BitmapData = new BitmapData(Settings.GRID_W + 2, Settings.GRID_H + 2, false, 0);
			
			for each(var room:Room in dungeon.rooms) {
				bitmap.fillRect(new Rectangle(room.x + 1, room.y + 1, room.width, room.height), Settings.COLOR_FLOOR);
				for each(var subroom:Room in room.mergedRooms) {
					bitmap.fillRect(new Rectangle(subroom.x + 1, subroom.y + 1, subroom.width, subroom.height), Settings.COLOR_FLOOR);
				}
			}
			
			for each(var edge:Edge in dungeon.edges) {
				if (edge.direction == Room.HORIZONTAL) {
					bitmap.fillRect(new Rectangle(edge.x + 1, edge.y + 1, edge.length + 1, 1), Settings.COLOR_WALL);
				} else {
					bitmap.fillRect(new Rectangle(edge.x + 1, edge.y + 1, 1, edge.length + 1), Settings.COLOR_WALL);
				}
			}
			
			bitmap.fillRect(new Rectangle(0, 0, 				bitmap.width, 1),  Settings.COLOR_WALL);
			bitmap.fillRect(new Rectangle(0, bitmap.height - 1, bitmap.width, 1),  Settings.COLOR_WALL);
			bitmap.fillRect(new Rectangle(0, 0, 				1, bitmap.height), Settings.COLOR_WALL);
			bitmap.fillRect(new Rectangle(bitmap.width - 1, 0, 	1, bitmap.height), Settings.COLOR_WALL);
			
			for each(var door:Door in dungeon.doors) {
				if (door.direction == Room.HORIZONTAL) {
					bitmap.fillRect(new Rectangle(door.x + 1, door.y + 1, 1, 1), Settings.COLOR_DOOR);
				} else {
					bitmap.fillRect(new Rectangle(door.x + 1, door.y + 1, 1, 1), Settings.COLOR_DOOR);
				}
			}
			
			bitmap.fillRect(new Rectangle(dungeon.roomsHead.centerX + 1, dungeon.roomsHead.centerY + 1, 1, 1), Settings.COLOR_ENTRANCE);
			bitmap.fillRect(new Rectangle(dungeon.roomsTail.centerX + 1, dungeon.roomsTail.centerY + 1, 1, 1), Settings.COLOR_EXIT);
			
			return bitmap;
		}
		
	}

}