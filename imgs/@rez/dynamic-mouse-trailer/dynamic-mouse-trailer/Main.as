/**
 * Dynamic Mouse Trailer
 * ---------------------
 * VERSION: 1.0
 * DATE: 3/13/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package  
{
	import com.freeactionscript.MouseTrailer;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Main extends Sprite
	{
		private var mouseTrailer:MouseTrailer;
		
		public function Main() 
		{
			mouseTrailer = new MouseTrailer();
			addChild(mouseTrailer);
			
			mouseTrailer.init();
		}
		
	}
	
}