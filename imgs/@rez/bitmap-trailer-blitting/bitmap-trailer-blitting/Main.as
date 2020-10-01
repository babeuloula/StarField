/**
 * Bitmap Trailer
 * ---------------------
 * VERSION: 1.0.0
 * DATE: 10/01/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Main extends Sprite
	{
		// canvas bitmap data var
		private var canvasBitmapData:BitmapData;
		
		// canvas bitmap - this will be added to the display list
		private var canvas:Bitmap;
		
		// canvas rectangle - used to save canvas size
		private var canvasRect:Rectangle;
		
		// circle (trailer) bitmap data
		private var circleBitmapData:BitmapData;
		
		// circle rectangle - used to save canvas size
		private var circleRect:Rectangle;
		
		// color transformer - used to make cavas transparent
		private var colorTransform:ColorTransform;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			init();
		}
		
		//////////////////////////////////////
		// Public API 
		//////////////////////////////////////
		
		public function init():void
		{
			// add event listeners
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			
			// create main canvas bitmap data
			canvasBitmapData = new BitmapData(550, 400, true, 0x333333);
			canvas = new Bitmap(canvasBitmapData);
			addChild(canvas);
			canvasRect = canvasBitmapData.rect;
			
			// create circle trailer bitmap data
			circleBitmapData = new BitmapData(10, 10, true, 0xFFFFFF);
			
			// draw CircleTrailer movieclip, linked from library, inside circle bitmap data
			circleBitmapData.draw(new CircleTrailer());
			
			// save circle rectangle size
			circleRect = canvasBitmapData.rect;
			
			// create ColorTransformer to modify alpha of bitmap
			colorTransform = new ColorTransform();
			
			// (make it 99% transparent)
			colorTransform.alphaMultiplier = .99;
		}
		
		//////////////////////////////////////
		// Private Methods
		//////////////////////////////////////
		
		/**
		 * This method draws everything on to the canvas bitmap
		 */
		private function render():void
		{
			// lock bitmap data to prevent display from updating while we modify it
			canvasBitmapData.lock();
			
			// change alpha
			canvasBitmapData.colorTransform(canvasRect, colorTransform);
			
			// draw circle
			canvasBitmapData.copyPixels(circleBitmapData, circleRect, new Point(mouseX - 5, mouseY - 5), null, null, true);
			
			// apply blur filter
			canvasBitmapData.applyFilter(canvasBitmapData, canvasBitmapData.rect, new Point(0, 0), new BlurFilter(3, 3));
			
			// unlock bitmap data
			canvasBitmapData.unlock();
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
			render();
		}
		
		/**
		 * Mouse Move handler
		 * @param	e	Uses MouseEvent
		 */
		private function onMouseMoveHandler(event:MouseEvent):void 
		{
			render();
		}
		
	}
}