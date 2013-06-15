package
{
	import com.Dimentions;
	import com.controller.Progressor;
	import com.model.Session;
	import com.sticksports.nativeExtensions.flurry.Flurry;
	
	import flash.system.Capabilities;
	
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
			resize();
			_logo = addChild(new Image(Texture.fromBitmap(new logo()))) as Image;
			Starling.juggler.delayCall(start,4);
			_logo.x= (Dimentions.WIDTH-_logo.width)/2;
			_logo.y= (Dimentions.HEIGHT-_logo.height)/2;
			Session.rationChanged.add(resize);
			Flurry.startSession("FGJG54WS4ZBX3DYR8T8Q");
			
		}
		
		private function resize():void{
			//this.scaleX=Session.ratio;
			//this.scaleY=Session.ratio;
			Flurry.logEvent("Resize",{ width : Capabilities.screenResolutionX, height : Capabilities.screenResolutionY, dpi : Capabilities.screenDPI });
		} 
		

		
		private function start():void{
			removeChild(_logo);
			var progressor:Progressor = new Progressor(this);
			progressor.goHome();
			resize();
			//progressor.goPlay();
		}
		
		
	}
}