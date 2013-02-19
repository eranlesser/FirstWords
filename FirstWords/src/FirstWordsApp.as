package
{
	import com.controller.ScreenCreator;
	import com.view.WhereIsScreen;
	
	import flash.display.Bitmap;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class FirstWordsApp extends Sprite
	{
		
		public function FirstWordsApp()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			
			var screen:WhereIsScreen = addChild(new WhereIsScreen()) as WhereIsScreen;
			new ScreenCreator(null,screen);
		}
		
		
	}
}