package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Missile extends MovieClip {
		public var xmin:Number;
		public var ymin:Number;
		public var xmax:Number;
		public var ymax:Number;
		public var vx:Number;
		public var vy:Number;
		public var id:Number;
		public static var detruit:Number = 0;
	
		public function definirLimites (x:Number, y:Number, l:Number, h:Number) {
			var r = this.getRect(null);
	
			this.xmin = x - r.x - r.width;
			this.ymin = y - r.y;
			this.xmax = x + l - (r.width + r.x);
			this.ymax = y + h - (r.height + r.y);
		}
	
		public function lancer() {
			this.x = this.x + this.vx;
			this.y = this.y + this.vy;
		}
	}
}