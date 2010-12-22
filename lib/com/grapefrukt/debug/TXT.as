package com.grapefrukt.debug
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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

	public class TXT extends Sprite {
		
		private var _text:TextField;	
		
		public function TXT(color:uint = 0xffffff) {
			var textformat:TextFormat = new TextFormat("Arial");
			
			_text = new TextField();
			_text.textColor = color;
			_text.selectable = false;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.setTextFormat(textformat);
			_text.defaultTextFormat = textformat;
			addChild(_text);
		}
		
		public function setText(str:String):void	{			
			_text.text = str + "\n";
		}
		
		public function appendText(str:String):void	{	
			_text.appendText(str + "\n");
		}
		
	}
}