package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.Session;
	import com.view.components.Clouds;
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class HomeScreen extends AbstractScreen
	{
		
		public var gotoSignal:Signal = new Signal();
		[Embed(source="../../assets/home/plybtn.png")]
		private var playBt : Class;
		[Embed(source="../../assets/home/tweets.png")]
		private var tweets : Class;
		[Embed(source="../../assets/home/home.png")]
		private var home : Class;
		[Embed(source="../../assets/bg/btrflies.png")]
		private var btrflies : Class;
		[Embed(source="../../assets/home/confBut.png")]
		private var wBird : 			Class;
		private var _clouds:Clouds;
		public function HomeScreen(screens:ScreensModel)
		{
			Assets.load();
			
			_clouds = new Clouds();
			var homeBg:Image = new Image(Texture.fromBitmap(new home()))
			_screenLayer.addChild(_clouds);
			_screenLayer.addChild(homeBg);
			var tweetsText:Image = new Image(Texture.fromBitmap(new tweets()));
			tweetsText.x=600;
			tweetsText.y=200;
			//_screenLayer.addChild(tweetsText);
			//_screenLayer.addChild(btrflies);
			var whereBird:Button = new Button(Texture.fromBitmap(new wBird()));
			_screenLayer.addChild(whereBird);
			whereBird.x=8;
			whereBird.y=8;
			whereBird.addEventListener(Event.TRIGGERED,openMenu);
			
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			addChild(playBut);
			playBut.x=186//(Dimentions.WIDTH-playBut.width)/3;
			playBut.y=168;
			//playBut.scaleX=0.75;
			//playBut.scaleY=0.75;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(Session.currentScreen)});
			//initMenu(screens);
			
		}
		
		private function openMenu():void{
			gotoSignal.dispatch(-1);
		}
		
		override protected function addNavigation():void{
			
		}
		
		
		
		override public function destroy():void{
			//_clouds.stop();
		}
	}
}

