package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
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
		[Embed(source="../../assets/bg/fence.png")]
		private var fence : Class;
		
		private var _clouds:Clouds;
		public function HomeScreen(screens:ScreensModel)
		{
			Assets.load();
			var bg:Image = new Image(Texture.fromBitmap(new Assets.BackgroundImage()))
			_screenLayer.addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			initMenu(screens);
			var fence:Image = new Image(Texture.fromBitmap(new fence()))
			_screenLayer.addChild(fence);
			fence.y = Dimentions.HEIGHT-fence.height;
			_clouds = new Clouds();
			_screenLayer.addChild(_clouds);
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
			_screenLayer.addChild(_menu);
			_menu.x=700;
			_menu.y=350;
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			_screenLayer.addChild(playBut);
			playBut.x=150;
			playBut.y=150;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(0)});
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

