/**
 * Weapon - Projectile Gun
 * ---------------------
 * VERSION: 1.0
 * DATE: 7/18/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	public class Main extends MovieClip
	{
		// player settings		
		private var _rotateSpeedMax:Number = 20;
		private var _gravity:Number = .68;
		
		// projectile gun settings
		private var _bulletSpeed:Number = 4;		
		private var _maxDistance:Number = 200;
		private var _reloadSpeed:Number = 250; //milliseconds
		private var _barrelLength:Number = 20;
		private var _bulletSpread:Number = 5;
		
		// gun stuff - do not edit
		private var _isLoaded:Boolean = true;		
		private var _isFiring:Boolean = false;
		private var _endX:Number;
		private var _endY:Number;
		private var _startX:Number;
		private var _startY:Number;
		private var _reloadTimer:Timer;
		private var _bullets:Array = [];
		
		// array that holds walls
		private var _solidObjects:Array = [];
		
		// global vars
		private var _player:MovieClip;
		private var _dx:Number;
		private var _dy:Number;
		private var _pcos:Number;
		private var _psin:Number;
		private var _trueRotation:Number;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			createPlayer();
			
			// add listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			
			// add movieclips to solidObjects array
			// will test for collisions with bullets
			//
			// *** movieclips are located on stage in the fla
			_solidObjects = [wall01, wall02, wall03, wall04];
		}
		
		//////////////////////////////////////
		// Player & Weapon Methods
		//////////////////////////////////////
		
		/**
		 * Creates player
		 * Uses "Player" movieclip linked in library
		 */
		private function createPlayer():void
		{
			// attach player movieclip from library
			_player = new Player();
			
			// position player in center
			_player.x = stage.stageWidth / 2;
			_player.y = stage.stageHeight / 2;
			
			// add to display list
			stage.addChild(_player);
		}
		
		/**
		 * Fire weapon
		 */
		private function fire():void
		{
			// check if firing
			if (!_isFiring) return;
			
			// check if reloaded
			if (!_isLoaded) return;
			
			// create bullet
			createBullet();
			
			// start reload timer
			_reloadTimer = new Timer(_reloadSpeed);
			_reloadTimer.addEventListener(TimerEvent.TIMER, reloadTimerHandler);
			_reloadTimer.start();
			
			// set reload flag to false
			_isLoaded = false;
		}
		
		/**
		 * Creates a bullet movieclip and sets it's properties
		 */
		private function createBullet():void
		{
			// precalculate the cos & sine
			_pcos = Math.cos(_player.rotation * Math.PI / 180);
			_psin = Math.sin(_player.rotation * Math.PI / 180);
			
			// start X & Y
			// calculate the tip of the barrel
			_startX = _player.x - _barrelLength * _pcos;
			_startY = _player.y - _barrelLength * _psin;
			
			// end X & Y
			// calculate where the bullet needs to go
			// aim 50 pixels in front of the gun
			_endX = _player.x - 50 * _pcos + Math.random() * _bulletSpread - _bulletSpread * .5;
			_endY = _player.y - 50 * _psin + Math.random() * _bulletSpread - _bulletSpread * .5;
			
			// attach bullet from library
			var tempBullet:MovieClip = new Bullet();
			
			// calculate velocity
			tempBullet.vx = (_endX - _startX) / _bulletSpeed;
			tempBullet.vy = (_endY - _startY) / _bulletSpeed;
			
			// set position
			tempBullet.x = _startX;
			tempBullet.y = _startY;
			
			// save starting location
			tempBullet.startX = _startX;
			tempBullet.startY = _startY;
			
			// set maximum allowed travel distance
			tempBullet.maxDistance = _maxDistance;
			
			// add bullet to bullets array
			_bullets.push(tempBullet);
			
			// add to display list
			stage.addChild(tempBullet);
		}
		
		/**
		 * Updates bullets
		 */
		private function updateBullets():void
		{
			var i:int;
			var tempBullet:MovieClip;
			
			// loop thru _bullets array
			for (i = 0; i < _bullets.length; i++)
			{
				// save a reference to current bullet
				tempBullet = _bullets[i];
				
				// check if gravity is enabled
				if (gravityCheckbox.selected)
				{
					// add gravity to Y velocity
					tempBullet.vy += _gravity;
				}
				
				// update bullet position
				tempBullet.x += tempBullet.vx;
				tempBullet.y += tempBullet.vy;
				
				// check if bullet went too far
				if (getDistance(tempBullet.startX - tempBullet.x, tempBullet.startY - tempBullet.y) > tempBullet.maxDistance + _barrelLength)
				{
					destroyBullet(tempBullet);
				}
				
				// check for collision with walls
				if (checkCollisions(tempBullet.x, tempBullet.y))
				{
					destroyBullet(tempBullet);
				}
			}
		}
		
		/**
		 * Destroys bullet
		 * @param	bullet	Takes bullet movieclip
		 */
		private function destroyBullet(bullet:MovieClip):void
		{
			var i:int;
			var tempBullet:MovieClip;
			
			// loop thru _bullets array
			for (i = 0; i < _bullets.length; i++)
			{
				// save a reference to current bullet
				tempBullet = _bullets[i];
				
				// if found bullet in array
				if (tempBullet == bullet)
				{
					// remove from array
					_bullets.splice(i, 1);
					
					// remove from display list
					bullet.parent.removeChild(bullet);
					
					// stop loop
					return;
				}
			}
		}
		
		/**
		 * Reload weapon
		 */
		private function reloadWeapon():void
		{
			_isLoaded = true;
		}
		
		/**
		 * Checks for collisions between points and objects in _solidObjects
		 * @return	Collision boolean
		 */
		private function checkCollisions(testX:Number, testY:Number):Boolean
		{
			var i:int;
			var tempWall:MovieClip;
			
			// loop thru _solidObjects array
			for (i = 0; i < _solidObjects.length; i++)
			{
				// save a reference to current object
				tempWall = _solidObjects[i];
				
				// do a hit test
				if (tempWall.hitTestPoint(testX, testY, true))
				{
					return true;
					
					// stop loop
					break;
				}
			}
			return false;
		}
		
		/**
		 * Calculate player rotation 
		 */
		private function updateRotation():void
		{
			// calculate rotation based on mouse X & Y
			_dx = _player.x - stage.mouseX;
			_dy = _player.y - stage.mouseY;
			
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
		
		//////////////////////////////////////
		// Event Handlers
		//////////////////////////////////////
		
		/**
		 * Enter Frame handler
		 * @param	event	Uses Event
		 */
		private function enterFrameHandler(event:Event):void
		{
			updateRotation();
			updateBullets();
			fire();
		}
		
		/**
		 * Mouse Up handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseUpHandler(event:MouseEvent):void 
		{
			_isFiring = false;
		}
		
		/**
		 * Mouse Down handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseDownHandler(event:MouseEvent):void 
		{
			_isFiring = true;
		}
		
		/**
		 * Reload timer
		 * @param	e	Takes TimerEvent
		 */
		private function reloadTimerHandler(e:TimerEvent):void 
		{
			// stop timer
			e.target.stop();
			
			// clear timer var
			_reloadTimer = null;
			
			reloadWeapon();
		}
		
		//////////////////////////////////////
		// Utilities
		//////////////////////////////////////
		
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
		 * @param	radians	Takes radians
		 * @return	Returns degrees
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
	}
}