﻿/**
 * Dynamic Mouse Trailer
 * ---------------------
 * VERSION: 1.0
 * DATE: 3/13/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MouseTrailer extends Sprite
	{
		// Vars
		private var particleArray:Array;
		
		// Settings
		private var particleMaxSpeed:Number = 1.5;
		private var particleFadeSpeed:Number = .05;
		private var particleTotal:Number = 3;
		private var particleRange:Number = 25;
		private var particleCurrentAmount:Number = 0;
		
		public function MouseTrailer() 
		{
			
		}
		
		public function init():void
		{
			particleArray = [];
			
			addEventListener(Event.ENTER_FRAME, onEnterFrameLoop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function onEnterFrameLoop(event:Event):void
		{
			updateParticle();
		}
		
		private function mouseMoveHandler(event:Event):void
		{
			createParticle(stage.mouseX, stage.mouseY);
		}
		
		/**
		 * createParticle(target X position, target Y position)
		 */
		function createParticle(targetX:Number, targetY:Number):void
		{
			//run for loop based on particleTotal
			for (var i:Number = 0; i < particleTotal; i++) 
			{
				var particle_mc:MovieClip = new Particle();
				
				//set position & rotation, alpha
				particle_mc.x = targetX
				particle_mc.y = targetY
				particle_mc.rotation = Math.random() * 360;
				particle_mc.alpha = Math.random() * .5 + .5;
				
				//set particle boundry            
				particle_mc.boundyLeft = targetX - particleRange;
				particle_mc.boundyTop = targetY - particleRange;
				particle_mc.boundyRight = targetX + particleRange;
				particle_mc.boundyBottom = targetY + particleRange;
				
				//set speed/direction of fragment
				particle_mc.speedX = Math.random() * particleMaxSpeed - Math.random() * particleMaxSpeed;
				particle_mc.speedY = Math.random() * particleMaxSpeed - Math.random() * particleMaxSpeed;
				particle_mc.speedX *= particleMaxSpeed
				particle_mc.speedY *= particleMaxSpeed
				
				//set fade out speed
				particle_mc.fadeSpeed = Math.random()*particleFadeSpeed;
				
				//just a visual particle counter
				particleCurrentAmount++;
				
				// add to array
				particleArray.push(particle_mc);
				
				// add to display list
				addChild(particle_mc);
			}
		}
		
		private function updateParticle():void
		{
			for (var i = 0; i < particleArray.length; i++)
			{
				var tempParticle:MovieClip = particleArray[i];
				
				//update alpha, x, y
				tempParticle.alpha -= tempParticle.fadeSpeed;
				tempParticle.x += tempParticle.speedX;
				tempParticle.y += tempParticle.speedY;
				
				// if fragment is invisible remove it				
				if (tempParticle.alpha <= 0)
				{
					destroyParticle(tempParticle);
				}
				// if fragment is out of bounds, increase fade out speed
				else if (tempParticle.x < tempParticle.boundyLeft || 
						tempParticle.x > tempParticle.boundyRight || 
						tempParticle.y < tempParticle.boundyTop || 
						tempParticle.y > tempParticle.boundyBottom)
				{
					tempParticle.fadeSpeed += .05;
				}
			}
		}
		
		private function destroyParticle(particle:MovieClip):void
		{
			for (var i = 0; i < particleArray.length; i++)
			{
				var tempParticle:MovieClip = particleArray[i];
				if (tempParticle == particle)
				{
					particleCurrentAmount--;
					particleArray.splice(i,1);
					removeChild(tempParticle);
				}
			}
		}
		
	}
	
}