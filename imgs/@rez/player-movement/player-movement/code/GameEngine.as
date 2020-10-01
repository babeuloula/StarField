/**
* Multiple Key Detection, 8 way diagonal movement, Arrow key player movement, onEnterFrame in AS3 
*
* Version: 1.0
* Author: Philip Radvan
* URL: http://www.freeactionscript.com
*/


// think of packages as a "holder" folder for your code
// if you look at the attached files, there is a folder named "code"
// that has our class "GameEngine.as"
// you don't have to use packages, but it's good form to use them.
// we'll keep our packages simple for now
//
package code
{
	// now we're going to import build-in classes that we are going to use in the program
	import flash.display.MovieClip;
	// event classes are needed to use stuff like KEY_DOWN and onEnterFrame
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	//umm...
	import flash.ui.Keyboard;
	
	// this is out main class, GameEngine
	// we specify it in the Fla file Properties window, in the Document class field.
	// if you look in the file, you'll see that that field says "code.GameEngine"
	// to starts with "code." because our package name is "code".
	// it ends with "GameEngine", which is our main class name
	public class GameEngine extends MovieClip
	{
		// we set the below variables(parameters) in the main class, but outside the functions(methods)
		// so that these variables will be available for all the functions(methods) in this class
		//
		// Boolean flags used to detect direction
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var left:Boolean = false;
		public var right:Boolean = false;
		
		// Animation
		public var speed:Number = 5;
		
		// Constructor
		// this is the first function the swf file will use when you open it
		public function GameEngine()
		{
			// think of "stage" as "_root" in AS2
			// we're adding a listener to stage to listent for keyboard presses(events)
			// when the event listener hears a key down or key up, 
			// it will use the "myOnPress" function or the "myOnRelease" function to react to the key presses
			// you can call you functions whatever you like
			// 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, myOnPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, myOnRelease);
			
			// add a listener for onEnterFrame
			// this listener "listens" for the swf file to play frames,
			// each frame that is played, 
			stage.addEventListener(Event.ENTER_FRAME, myOnEnterFrame);
		}
		
		//this is a function the Event.ENTER_FRAME listener uses
		public function myOnEnterFrame(event:Event):void
		{
			// Move up, down, left, or right
			// if(left is true and right is not true)
			if ( left && !right ) {
				//update the x position and the rotation
				//note that in AS3 there is no more _ infront of _x and _rotation
				beetle.x -= speed;
				beetle.rotation = 270;
			}
			// if(right is true and left is not true)
			if( right && !left ) {
				beetle.x += speed;
				beetle.rotation = 90;
			}
			// if(up is true and down is not true)
			if( up && !down ) {
				beetle.y -= speed;
				beetle.rotation = 0;
			}
			// if(down is true and up is not true)
			if( down && !up ) {
				beetle.y += speed;
				beetle.rotation = 180;
			}
			
			// Move diagonally
			if( left && up && !right && !down ) {
				beetle.rotation = 315;
			}
			if( right && up && !left && !down ) {
				beetle.rotation = 45;
			}
			if( left && down && !right && !up ) {
				beetle.rotation = 225;
			}
			if( right && down && !left && !up ) {
				beetle.rotation = 135;
			}
			
			// Loop to opposite side of the map 
			// when player travels off-screen
			if( beetle.y < map.y ){
				beetle.y = map.height;
			}
			if( beetle.y > map.height ){
				beetle.y = map.y;
			}
			if( beetle.x < map.x ){
				beetle.x = map.width;
			}
			if( beetle.x > map.width ){
				beetle.x = map.x;
			}
		}
		
		//this is the function the KeyboardEvent.KEY_DOWN listener uses
		public function myOnPress(event:KeyboardEvent):void
		{
			// a "switch" statement is just like  "if"/"else"
			// people use it instead of if/else because it's easier to read, among other benefits
			switch( event.keyCode )
			{
				case Keyboard.UP:
					up = true;
					break;
					
				case Keyboard.DOWN:
					down = true;
					break;
					
				case Keyboard.LEFT:
					left = true;
					break;
					
				case Keyboard.RIGHT:
					right = true;
					break;
			}
			//if the above code was  "if"/"else", it would look like this:			
			/*
			if (event.keyCode == Keyboard.UP)
			{
				up = true;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				down = true;
			}
			else if (event.keyCode == Keyboard.LEFT)
			{
				left = true;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				right = true;
			}
			*/
		}
		
		//this is the function the KeyboardEvent.KEY_UP listener uses
		public function myOnRelease(event:KeyboardEvent):void
		{
			switch( event.keyCode )
			{
				case Keyboard.UP:
					up = false;
					break;
					
				case Keyboard.DOWN:
					down = false;
					break;
					
				case Keyboard.LEFT:
					left = false;
					break;
					
				case Keyboard.RIGHT:
					right = false;
					break;
			}
		}
		
	}
}
//the end