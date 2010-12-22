package  {
	import com.grapefrukt.debug.TXT;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Main extends Sprite {
		
		private var _dungeon	:Dungeon;
		private var _gfx		:Sprite;
		private var _bitmap		:Bitmap;
		private var _debug		:TXT;
		
		public function Main() {
			_dungeon 	= new Dungeon;
			_bitmap 	= new Bitmap();
			_debug 		= new TXT(0x000000)
			
			addChild(_bitmap)
			addChild(_debug);
			
			_bitmap.x = 150;
			_bitmap.scaleX = 4;
			_bitmap.scaleY = 4;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleKeyDown);
			
			handleKeyDown(null);
		}
		
		protected function handleKeyDown(e:Event):void {
			generate();
		}
		
		protected function generate():void {
			var t:Number = getTimer();
			_dungeon.reset();
			_bitmap.bitmapData = DungeonRenderer.render(_dungeon);			
			
			t = getTimer() - t;
			
			_debug.setText(_dungeon.roomCount + " accessible rooms");
			_debug.appendText("took " + int(t) + "ms");
		}
		
	}

}