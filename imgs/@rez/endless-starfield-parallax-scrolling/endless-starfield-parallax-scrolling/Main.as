/**
 * Endless Starfield - Parallax Scrolling
 * ---------------------
 * VERSION: 1.0
 * DATE: 6/22/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import com.freeactionscript.ParallaxField;
	import flash.display.MovieClip;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard
	
	public class Main extends Sprite
	{
		private var parallaxField:ParallaxField;
		
		public function Main() 
		{
			// create container for our parallax effect
			var mainContainer:MovieClip = new MovieClip();
			addChild(mainContainer);
			
			// instantiate parallax class
			parallaxField = new ParallaxField();
			
			// createField(container, x, y, width, height, numberOfStars, speedX, speedY);
			parallaxField.createField(mainContainer, 10, 10, 530, 380, 100, 1, 1.5);
			
			// add keyboard listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onMyKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onMyKeyUp);
		}
		
		/**
		 * Keyboard Handlers
		 */
		private function onMyKeyDown(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				case Keyboard.UP:
					parallaxField.upPressed = true;
					
				case Keyboard.DOWN:
					parallaxField.downPressed = true;
					break;
					
				case Keyboard.LEFT:
					parallaxField.leftPressed = true;
					break;
					
				case Keyboard.RIGHT:
					parallaxField.rightPressed = true;
					break;
			}
			
			event.updateAfterEvent();
		}
		
		private function onMyKeyUp(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				case Keyboard.UP:
					parallaxField.upPressed = false;
					
				case Keyboard.DOWN:
					parallaxField.downPressed = false;
					break;
					
				case Keyboard.LEFT:
					parallaxField.leftPressed = false;
					break;
					
				case Keyboard.RIGHT:
					parallaxField.rightPressed = false;
					break;
			}
		}
	}
	
}