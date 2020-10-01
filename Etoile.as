package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Etoile extends MovieClip {
		public var xmin:Number;
		public var ymin:Number;
		public var xmax:Number;
		public var ymax:Number;
		public var vx:Number;
		public var vy:Number;
		public var id:Number;
		
		public function definirLimites (x:Number, y:Number, l:Number, h:Number) {
			var r = this.getRect(null);
	
			this.xmin = x - r.x - r.width;
			this.ymin = y - r.y;
			this.xmax = x + l - (r.width + r.x);
			this.ymax = y + h - (r.height + r.y);
		}
	
		public function bouger () {
			this.x = this.x + this.vx;
			this.y = this.y + this.vy;
	
			if (this.y <= this.ymin) {
				this.vy = -this.vy;
				this.y = this.ymin;
			}
	
			if (this.x <= this.xmin) {
				this.parent.removeChild(this);
				clearInterval(this.id);
			}
	
			if (this.y >= this.ymax) {
				this.vy = -this.vy;
				this.y = this.ymax;
			}
	
			if (this.x >= this.xmax) {
				this.vx = -this.vx;
				this.x = this.xmax;
			}
		}
	}
}