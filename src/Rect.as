package  {
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class Rect {
		
		public var x		:int = 0;
		public var y		:int = 0;
		public var width	:int = 0;
		public var height	:int = 0;
		
		public function Rect(x:int, y:int, width:int, height:int) {
			this.x 		= x;
			this.y		= y;
			this.width 	= width;
			this.height = height;
		}
		
		public function get centerX():int { return x + width / 2; }
		public function get centerY():int { return y + height / 2; }
		
		public function get east():int { return x + width; }
		public function get west():int { return x; }
		
		public function get north():int { return y + height; }
		public function get south():int { return y;	}
		
		public function get area():int {
			return Math.sqrt(width * width + height * height);
		}
	}

}