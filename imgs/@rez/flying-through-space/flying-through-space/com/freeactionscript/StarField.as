/**
 * Flying Through Space
 * ---------------------
 * VERSION: 1.0
 * DATE: 8/03/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class StarField extends MovieClip
	{
		// settings
		private var speed:Number = 2;
		private var acceleration:Number = .25;
		private var scaleAcceleration:Number = .02;
		private var alphaAcceleration:Number = .02;
		
		// vars
		private var starsArray:Array = [];
		private var starArrayLength:int;		
		
		private var pathToContainer:MovieClip;
		
		private var starsTotal:int;
		private var starsCurrent:int;
		
		private var containerX:int;
		private var containerY:int;
		
		private var containerWidth:int;
		private var containerHeight:int;
		
		private var startX:Number;
		private var startY:Number;		
		
		private var isStarted:Boolean = false;
		
		
		/**
		 * Creates Star Field
		 * 
		 * @param	$container		The container that holds all our starfield assets. Must be created and added to stage before being used here.
		 * @param	$x				X position of container
		 * @param	$y				Y position of container
		 * @param	$width			Width of container
		 * @param	$height			Height of container
		 * @param	$numberOfStars	Number of stars to create
		 */
		public function createField($container:MovieClip, $x:int, $y:int, $width:int, $height:int, $numberOfStars:int):void
		{
			trace("createField");
			
			// save property references
			pathToContainer = $container;
			
			containerX = $x;
			containerY = $y;
			
			containerWidth = $width;
			containerHeight = $height;
			
			startX = containerWidth / 2 + containerX;
			startY = containerHeight / 2 + containerY;
			
			starsTotal = $numberOfStars;		
			
			pathToContainer.addEventListener(Event.ENTER_FRAME, addStars);
			
			// enable
			enable();
		}
		
		/**
		 * Adds new stars
		 */
		public function addStars(event:Event):void
		{
			// get class via string name
			var StarClassReference:Class = getDefinitionByName("StarSmall") as Class;
			
			// create class
			var tempStar:MovieClip = new StarClassReference();
			
			// set default new star properties
			setDefaultProperties(tempStar);
			
			// set alpha
			tempStar.alpha = 0;
			
			// set scale
			tempStar.scaleX = .5;
			tempStar.scaleY = .5;
			
			// set starting position
			tempStar.x = startX;
			tempStar.y = startY;
			
			// add new star to array that tracks all stars
			starsArray.push(tempStar);
			
			// add to display list
			pathToContainer.addChild(tempStar);
			
			// increase number of stars tracker
			starsCurrent++;
			
			// if all stars created, remove ENTER_FRAME addStars event
			if (starsCurrent == starsTotal)
			{
				pathToContainer.removeEventListener(Event.ENTER_FRAME, addStars);
				trace("\t Finished adding " + starsTotal + " new stars.");
			}
		}
		
		/**
		 * Activates effect
		 */
		public function enable():void
		{
			if (!isStarted)
			{
				trace("Starting effect...");
				isStarted = true;
				
				// add enter frame
				pathToContainer.addEventListener(Event.ENTER_FRAME, gameLoop);
			}
			else
			{
				trace("Effect already running.");
			}			
		}
		
		/**
		 * Disables effect
		 */
		public function disable():void
		{
			if (isStarted)
			{
				trace("Stopping effect...");
				isStarted = false;
				
				// remove enter frame
				pathToContainer.removeEventListener(Event.ENTER_FRAME, gameLoop);
			}
			else
			{
				trace("Effect is not running.");
			}			
		}
		
		/*************************************************************************/
		
		/**
		 * @private 
		 * This function sets all the star's default properties
		 */
		private function setDefaultProperties($target:MovieClip):void
		{
			$target.alpha = 0;
			$target.scaleX = .5;
			$target.scaleY = .5;
			
			var angle:Number = Math.round(Math.random() * 360);
			$target.angle = angle;
			$target.vx = Math.cos(angle) * speed;
			$target.vy = Math.sin(angle) * speed;
			$target.speed = speed;
		}
		
		/**
		 * Adds acceleration to speed of a star
		 * @param	$target
		 */
		private function addSpeed($target:MovieClip):void
		{
			$target.speed += acceleration;
			$target.vx = Math.cos($target.angle) * ($target.speed);
			$target.vy = Math.sin($target.angle) * ($target.speed);
		}
		
		/**
		 * Unused Method - sets random start position
		 * @param	$target
		 */
		private function setRandomStartPosition($target:MovieClip):void
		{			
			$target.x = (Math.random() * (containerWidth - $target.width)) + containerX;
			$target.y = (Math.random() * (containerHeight - $target.height)) + containerY;
		}
		
		/**
		 * @private 
		 * This function is executed every frame.
		 */
		private function gameLoop(event:Event):void
		{
			updateStars();
			
			// uncomment code below for a cool effect :P
			//onMoveMouse();
		}
		
		private function onMoveMouse():void 
		{
			startX = mouseX;
			startY = mouseY;
		}
		
		/**
		 * @private
		 * This function updates all the objects in the stars array
		 */
		private function updateStars():void
		{
			starArrayLength = starsArray.length;			
			var tempStar:MovieClip;			
			var i:int;
			
			// run for loop
			for(i = 0; i < starArrayLength; i++)
			{
				tempStar = starsArray[i];
				
				addSpeed(tempStar);
				
				tempStar.x += tempStar.vx;
				tempStar.y += tempStar.vy;
				
				// check alpha
				if (tempStar.alpha < 1)
				{
					tempStar.alpha += alphaAcceleration;
				}
				
				// check scale
				if (tempStar.scaleX < 1)
				{
					tempStar.scaleX += scaleAcceleration;
				}
				if (tempStar.scaleY < 1)
				{
					tempStar.scaleY += scaleAcceleration;
				}
				
				// Star container boundres
				// check X boudries
				if (tempStar.x >= containerWidth - tempStar.width + containerX) 
				{
					tempStar.x = startX;
					tempStar.y = startY;
					
					setDefaultProperties(tempStar);					
				}
				else if (tempStar.x <= containerX) 
				{
					tempStar.x = startX;
					tempStar.y = startY;
					
					setDefaultProperties(tempStar);
				}
				
				// check Y boudries
				if (tempStar.y >= containerHeight - tempStar.height + containerY)
				{
					tempStar.x = startX;
					tempStar.y = startY;
					
					setDefaultProperties(tempStar);
				}
				else if (tempStar.y <= containerY) 
				{
					tempStar.x = startX;
					tempStar.y = startY;
					
					setDefaultProperties(tempStar);
				}
			}
		}
		
	}
	
}