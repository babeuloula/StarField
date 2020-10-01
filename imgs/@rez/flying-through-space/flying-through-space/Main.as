/**
 * Flying Through Space
 * ---------------------
 * VERSION: 1.0
 * DATE: 8/03/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import com.freeactionscript.StarField;
	
	import flash.display.MovieClip;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard
	
	public class Main extends Sprite
	{
		private var starField:StarField;
		
		public function Main() 
		{
			// create container for our starfield effect
			var mainContainer:MovieClip = new MovieClip();
			addChild(mainContainer);
			
			// instantiate parallax class
			starField = new StarField();
			
			// createField(container, x, y, width, height, numberOfStars);
			starField.createField(mainContainer, 10, 10, 530, 380, 150);
			
		}
		
	}
	
}