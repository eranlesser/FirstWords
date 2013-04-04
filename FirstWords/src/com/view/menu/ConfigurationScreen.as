package com.view.menu
{
	import com.Assets;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class ConfigurationScreen extends Sprite
	{
		[Embed(source="../../../assets/home/homeBtn.png")]
		private var homeBt : 			Class;
		
		[Embed(source="../../../assets/menu/bg.png")]
		private var bg : 			Class;
		[Embed(source="../../../assets/menu/screens.png")]
		private var screens : 			Class;
		[Embed(source="../../../assets/menu/about.png")]
		private var about : 			Class;
		[Embed(source="../../../assets/menu/share.png")]
		private var share : 			Class;
		
		public var gotoSignal:Signal = new Signal();
		public var goHome:Signal = new Signal();
		private var _navText:TextField;
		private var _aboutText:TextField;
		private var _shareText:TextField;
		
		private var _displayLayer:Sprite;
		
		private var _menu:Sprite;
		
		public function ConfigurationScreen(screensModel:ScreensModel)
		{
			init();
			initMenu(screensModel);
			_displayLayer = new Sprite();
			addChild(_displayLayer);
			setState("nav");
		}
		
		private function init():void{
			addChild(new Image(Texture.fromBitmap(new bg())));
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			addChild(homeBut);
			homeBut.x=4;
			homeBut.y=4;
			homeBut.addEventListener(Event.TRIGGERED, function():void{
				goHome.dispatch()
			});
			
			var navButton:Button = new Button( Texture.fromBitmap(new screens()) );
			var aboutButton:Button = new Button( Texture.fromBitmap(new about()));
			var shareButton:Button = new Button( Texture.fromBitmap(new share()) );
			
			addChild(navButton);
			navButton.addEventListener(Event.TRIGGERED,function():void{setState("nav")});
			addChild(aboutButton);
			aboutButton.addEventListener(Event.TRIGGERED,function():void{setState("about")});
			addChild(shareButton);
			shareButton.addEventListener(Event.TRIGGERED,function():void{setState("share")});
			navButton.x=200;
			navButton.y=8;
			aboutButton.x=450;
			aboutButton.y=8;
			shareButton.x=700;
			shareButton.y=8;
			
			_navText = new TextField(navButton.width,40,"תוכן","Verdana",24);
			_navText.hAlign = "center";
			addChild(_navText);
			_navText.touchable=false;
			_navText.x = navButton.x;
			_navText.y=navButton.y + navButton.height - 60;
			_aboutText = new TextField(aboutButton.width,40,"מידע כללי","Verdana",24);
			_aboutText.hAlign = "center";
			addChild(_aboutText);
			_aboutText.touchable = false;
			_aboutText.x = aboutButton.x;
			_aboutText.y=aboutButton.y + aboutButton.height - 60;
			_shareText = new TextField(shareButton.width,40,"שתף","Verdana",24);
			_shareText.hAlign = "center";
			addChild(_shareText);
			_shareText.x = shareButton.x;
			_shareText.y=shareButton.y + shareButton.height - 60;
			_shareText.touchable=false;
		}
		
		private function setState(stt:String):void{
			_displayLayer.removeChildren();
			_navText.color = 0x111111;
			_aboutText.color = 0x111111;
			_shareText.color = 0x111111;
			switch(stt){
				case "nav":
						_navText.color = 0x999999;
						_displayLayer.addChild(_menu);
					break;
				case "about":
						_aboutText.color = 0x999999;
					
					break;
				case "share":
						_shareText.color = 0x999999;
					
					break;
			}
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
			_menu.x=400;
			_menu.y=350;
		}//function
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
