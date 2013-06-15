package com.view
{
	import com.Assets;
	import com.model.ScreensModel;
	import com.model.Session;
	import com.view.components.Clouds;
	import com.view.components.FlagsMenu;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class HomeScreen extends AbstractScreen
	{
		
		public var gotoSignal:Signal = new Signal();
		[Embed(source="../../assets/home/plybtn.png")]
		private var playBt : Class;
		[Embed(source="../../assets/home/tweets.png")]
		private var tweets : Class;
		[Embed(source="../../assets/home/home.png")]
		private var home : Class;
		[Embed(source="../../assets/confBut.png")]
		private var wBird : 			Class;
		private var _clouds:Clouds;
		private var _flags:FlagsMenu;
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
			_flags = new FlagsMenu();
			_flags.x=400;
			_flags.y=325;
			//_screenLayer.addChild(_flags);
			//_screenLayer.addChild(tweetsText);
			//_screenLayer.addChild(btrflies);
			var whereBird:Button = new Button(Texture.fromBitmap(new wBird()));
			_screenLayer.addChild(whereBird);
			whereBird.x=8;
			whereBird.y=8;
			whereBird.addEventListener(Event.TRIGGERED,openMenu);
			
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			addChild(playBut);
			playBut.x=110//(Dimentions.WIDTH-playBut.width)/3;
			playBut.y=168;
			//playBut.scaleX=0.75;
			//playBut.scaleY=0.75;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(Session.currentScreen)});
			//initMenu(screens);
			this.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(t:TouchEvent):void{
			if(t.getTouch(stage)&&(t.getTouch(stage).phase == TouchPhase.BEGAN)){
				if(t.getTouch(stage).target is Image && (t.getTouch(stage).target as Image).width == 200){
					return;
				}
				_flags.close();
			}
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

