package com.grapefrukt.debug
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;

	public class TXT extends Sprite
	{

		private var txt_text:TextField;

		public function TXT(color:uint = 0xffffff) {
			
			var textformat:TextFormat = new TextFormat("Arial");
			
			txt_text = new TextField();
			txt_text.textColor = color;
			txt_text.selectable = false;
			txt_text.autoSize = TextFieldAutoSize.LEFT;
			txt_text.setTextFormat(textformat);
			txt_text.defaultTextFormat = textformat;
			addChild(txt_text);
			
		}

		public function setText(str:String):void	{			
			txt_text.text = str + "\n";
		}
		
		public function appendText(str:String):void	{	
			txt_text.appendText(str + "\n");
		}
		
	}
}