package
{
	import com.Dimentions;
	import com.controller.Progressor;
	import com.model.Session;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class FirstWordsApp extends Sprite
	{
		[Embed(source="assets/logo.png")]
		private var logo : Class;
		private var _logo:Image;
		public function FirstWordsApp()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			this.scaleX=Session.ratio;
			this.scaleY=Session.ratio;
			_logo = addChild(new Image(Texture.fromBitmap(new logo()))) as Image;
			Starling.juggler.delayCall(start,4);
			_logo.x= (Dimentions.WIDTH-_logo.width)/2;
			_logo.y= (Dimentions.HEIGHT-_logo.height)/2;
		}
		
		private function start():void{
			removeChild(_logo);
			var progressor:Progressor = new Progressor(this);
			progressor.goHome();
			//progressor.goPlay();
		}
		
		
	}
}