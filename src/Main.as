package {
	
	import com.grapefrukt.debug.TXT;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
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