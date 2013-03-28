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
		private var _menu:Sprite;
		private var _playBut:Button;
		public var gotoSignal:Signal = new Signal();
		[Embed(source="../../assets/home/playBtn.png")]
		private var playBt : Class;
		[Embed(source="../../assets/home/tweets.png")]
		private var tweets : Class;
		[Embed(source="../../assets/bg/birdsBg-01.png")]
		private var fence : Class;
		[Embed(source="../../assets/bg/btrflies.png")]
		private var btrflies : Class;
		
		private var _clouds:Clouds;
		public function HomeScreen(screens:ScreensModel)
		{
			Assets.load();
			
			_clouds = new Clouds();
			_screenLayer.addChild(_clouds);
			var bg:Image = new Image(Texture.fromBitmap(new Assets.BackgroundImage()))
			//_screenLayer.addChild(bg);
			var fence:Image = new Image(Texture.fromBitmap(new fence()))
			var btrflies:Image = new Image(Texture.fromBitmap(new btrflies()))
			_screenLayer.addChild(fence);
			var tweetsText:Image = new Image(Texture.fromBitmap(new tweets()));
			tweetsText.x=600;
			tweetsText.y=200;
			_screenLayer.addChild(tweetsText);
			//_screenLayer.addChild(btrflies);
			btrflies.x=800;
			btrflies.y=400;
			initMenu(screens);
			
		}
		
		override protected function addNavigation():void{
			
		}
		
		private function initMenu(screens:ScreensModel):void
		{
			_menu = new Sprite();
			
			var i:int=0;
			var n:int=0;
			var wdt:uint=55;
			var gap:uint=10;
			for each(var screen:ScreenModel in screens.screens){
				if(screen.thumbNail!=""){
					var menuThmb:ThumbNail = new ThumbNail(Assets.getAtlas(screen.groupName).getTexture(screen.thumbNail),i);
					menuThmb.x = (n%3)*wdt + (n%3)*gap;
					menuThmb.y = Math.floor(n/3)*(wdt+gap);
					menuThmb.width = wdt;
					menuThmb.height = wdt;
					var frame:Image = new Image(Texture.fromBitmap(new Assets.Frame))
					
					//_menu.addChild(frame);
					frame.width = wdt+4;
					frame.height = wdt+4;
					frame.x = menuThmb.x-2;
					frame.y = menuThmb.y-2;
					_menu.addChild(menuThmb);
					menuThmb.addEventListener(Event.TRIGGERED,function onTriggered(e:Event):void{
						gotoSignal.dispatch(ThumbNail(e.target).index);
					});
					n++;
				}//if
					i++;
			}//for
			//_screenLayer.addChild(_menu);
			_menu.x=700;
			_menu.y=350;
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			_screenLayer.addChild(playBut);
			playBut.x=238//(Dimentions.WIDTH-playBut.width)/3;
			playBut.y=160;
			playBut.scaleX=0.75;
			playBut.scaleY=0.75;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(Session.currentScreen)});
		}//function
		
		override public function destroy():void{
			_clouds.stop();
		}
	}
}
import com.Assets;
import com.Dimentions;

import starling.display.Button;
import starling.display.Image;
import starling.textures.Texture;

class ThumbNail extends Button{
	public var index:int;
	function ThumbNail(asset:Texture,indx:int){
		
		super(asset);
		index=indx;
		
	}
}

