/**
 * Scrollbar
 * ---------------------
 * VERSION: 2.0
 * DATE: 5/04/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.freeactionscript.Scrollbar;
	
	public class Main extends MovieClip
	{
		// assets on stage
		public var content:MovieClip;
		public var contentMask:MovieClip;
		public var track:MovieClip;
		public var slider:MovieClip;
		
		// vars
		private var _scrollbar:Scrollbar;
		
		/**
		 * Constructor
		 */
		public function Main() 
		{
			_scrollbar = new Scrollbar();
			_scrollbar.init(content, contentMask, track, slider);
		}
	}
	
}