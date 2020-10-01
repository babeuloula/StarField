/**
 * Enemy AI - Random movement
 * ---------------------
 * VERSION: 1.0
 * DATE: 1/25/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip
	{
		// player settings		
		private var _moveSpeedMax:Number = 1000;
		private var _rotateSpeedMax:Number = 15;
		private var _decay:Number = .98;
		private var _destinationX:int = 150;
		private var _destinationY:int = 150;
		
		private var _minX:Number = 0;
		private var _minY:Number = 0;
		private var _maxX:Number = 550;
		private var _maxY:Number = 400;
		
		// player
		private var _player:MovieClip;
		
		// global		
		private var _dx:Number = 0;
		private var _dy:Number = 0;
		
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		
		private var _trueRotation:Number = 0;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			// create player object
			createPlayer();
			
			// add listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * Creates player
		 */
		private function createPlayer():void
		{			
			_player = new Player();
			_player.x = stage.stageWidth / 2;
			_player.y = stage.stageHeight / 2;
			stage.addChild(_player);
		}
		
		/**
		 * EnterFrame Handlers
		 */
		private function enterFrameHandler(event:Event):void
		{
			updateCollision();
			updatePosition();
			updateRotation();
		}
		
		/**
		 * Calculate Rotation
		 */
		private function updateRotation():void
		{
			// calculate rotation
			_dx = _player.x - _destinationX;
			_dy = _player.y - _destinationY;
			
			// which way to rotate
			var rotateTo:Number = getDegrees(getRadians(_dx, _dy));	
			
			// keep rotation positive, between 0 and 360 degrees
			if (rotateTo > _player.rotation + 180) rotateTo -= 360;
			if (rotateTo < _player.rotation - 180) rotateTo += 360;
			
			// ease rotation
			_trueRotation = (rotateTo - _player.rotation) / _rotateSpeedMax;
			
			// update rotation
			_player.rotation += _trueRotation;			
		}
		
		/**
		 * Calculate Position
		 */
		private function updatePosition():void
		{
			// update velocity
			_vx += (_destinationX - _player.x) / _moveSpeedMax;
			_vy += (_destinationY - _player.y) / _moveSpeedMax;
			
			// if close to target
			if (getDistance(_dx, _dy) < 50)
			{
				getRandomDestination();
			}
			
			// apply decay (drag)
			_vx *= _decay;
			_vy *= _decay;
			
			// update position
			_player.x += _vx;
			_player.y += _vy;
		}
		
		/**
		 * updateCollision
		 */
		protected function updateCollision():void
		{
			// Check X
			// Check if hit top
			if (((_player.x - _player.width / 2) < _minX) && (_vx < 0))
			{
			  _vx = -_vx;
			}
			// Check if hit bottom
			if ((_player.x + _player.width / 2) > _maxX && (_vx > 0))
			{
			  _vx = -_vx;
			}
			
			// Check Y
			// Check if hit left side
			if (((_player.y - _player.height / 2) < _minY) && (_vy < 0))
			{
			  _vy = -_vy
			}
			// Check if hit right side
			if (((_player.y + _player.height / 2) > _maxY) && (_vy > 0))
			{
			  _vy = -_vy;
			}
		}
		
		/**
		 * Calculates a random destination based on stage size
		 */
		private function getRandomDestination():void
		{
			_destinationX = Math.random() * (_maxX - _player.width) + _player.width / 2;
			_destinationY = Math.random() * (_maxY - _player.height) + _player.height / 2;
		}
		
		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
	}
	
}