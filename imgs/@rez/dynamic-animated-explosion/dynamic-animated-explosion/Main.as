/**
 * Dynamic Animated Explosion
 * ---------------------
 * VERSION: 1.0
 * DATE: 8/22/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import com.freeactionscript.effects.explosion.LargeExplosion;
	import com.freeactionscript.effects.explosion.MediumExplosion;
	import com.freeactionscript.effects.explosion.SmallExplosion;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Main extends MovieClip
	{
		// vars
		private var _timer:Timer;
		private var _smallExplosion:SmallExplosion;
		private var _mediumExplosion:MediumExplosion;
		private var _largeExplosion:LargeExplosion;
		
		/**
		 * Document Class
		 */
		public function Main() 
		{
			// add basic listeners; enter frame, mouse down, mouse up
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			
			// create new effect instance: explosion
			_smallExplosion = new SmallExplosion(this);
			_mediumExplosion = new MediumExplosion(this);
			_largeExplosion = new LargeExplosion(this);
			
			// create a timer that will create a random explosion
			// every 500 milliseconds
			_timer = new Timer(500);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start(); 		
		}
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Enter Frame handler
		 * @param	event	Uses Event
		 */
		private function enterFrameHandler(event:Event):void
		{
			// update the explosion instance every frame
			_smallExplosion.update();
			_mediumExplosion.update();
			_largeExplosion.update();
		}
		
		/**
		 * Mouse Down handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseDownHandler(event:MouseEvent):void 
		{
			// create an explosion at mouse X & Y
			//_smallExplosion.create(stage.mouseX, stage.mouseY)
			_mediumExplosion.create(stage.mouseX, stage.mouseY)
			//_largeExplosion.create(stage.mouseX, stage.mouseY)
		}
		
		/**
		 * timer event handler
		 * @param	e
		 */
		private function timerHandler(e:Event):void 
		{
			// create random sized explosion
			var _randomNumber:Number = Math.round(Math.random() * 2)
			var _randomX:Number = Math.random() * 450 + 50;
			var _randomY:Number = Math.random() * 300 + 50;
			
			if (_randomNumber == 0)
			{
				// create an explosion at a random X & Y
				_smallExplosion.create(_randomX, _randomY);
			}
			else if (_randomNumber == 1)
			{
				// create an explosion at a random X & Y
				_mediumExplosion.create(_randomX, _randomY);
			}
			else if (_randomNumber == 2)
			{
				_largeExplosion.create(_randomX, _randomY);
			}
		}
		
	}
}