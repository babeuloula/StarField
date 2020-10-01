package {
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	public class Joueur extends MovieClip {
		public var vx:Number;
		public var vy:Number;
		public var id:Number;
		
		public function bouger() {
			this.x=this.x+this.vx;
			this.y=this.y+this.vy;
			this.vx=this.vx*0.9;
			this.vy=this.vy*0.9;
		}
		
     	public function Souris(e:MouseEvent) {
			this.x = this.parent.mouseX;
			this.y = this.parent.mouseY;
     	}
	}
}