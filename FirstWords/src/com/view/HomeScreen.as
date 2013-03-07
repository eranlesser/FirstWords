package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class HomeScreen extends Sprite
	{
		private var _menu:Sprite;
		private var _playBut:Button;
		public var gotoSignal:Signal = new Signal();
		[Embed(source="../../assets/play.jpg")]
		private var playBt : Class;
		public function HomeScreen(screens:ScreensModel)
		{
			
			var bg:Image = new Image(Texture.fromBitmap(new Assets.BackgroundImage()))
			addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			initMenu(screens);
		}
		
		private function initMenu(screens:ScreensModel):void
		{
			_menu = new Sprite();
			var i:int=0;
			var wdt:uint=100;
			var gap:uint=10;
			for each(var screen:ScreenModel in screens.screens){
				var menuThmb:ThumbNail = new ThumbNail(Assets.getAtlas(screen.groupName).getTexture(screen.thumbNail),i);
				menuThmb.x = i*wdt + i*gap;
				menuThmb.y = Math.floor(i/3)*(40+gap);
				menuThmb.width = wdt;
				menuThmb.height = wdt;
				var frame:Image = new Image(Texture.fromBitmap(new Assets.Frame))
				_menu.addChild(frame);
				frame.width = wdt+4;
				frame.height = wdt+4;
				frame.x = menuThmb.x-2;
				frame.y = menuThmb.y-2;
				_menu.addChild(menuThmb);
				menuThmb.addEventListener(Event.TRIGGERED,function onTriggered(e:Event):void{
					gotoSignal.dispatch(ThumbNail(e.target).index);
				});
				i++;
			}
			addChild(_menu);
			_menu.x=600;
			_menu.y=250;
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			addChild(playBut);
			playBut.x=80;
			playBut.y=180;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(0)});
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

