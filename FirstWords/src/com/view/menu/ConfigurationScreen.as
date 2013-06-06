package com.view.menu
{
	
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.Session;
	//import com.utils.InApper;
	import com.utils.Texter;
	import com.view.components.ScreensMenu;
	
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
		[Embed(source="../../../assets/menu/ogm.png")]
		private var ogm : 			Class;
		[Embed(source="../../../assets/menu/screens.png")]
		private var screens : 			Class;
		[Embed(source="../../../assets/menu/about.png")]
		private var about : 			Class;
		[Embed(source="../../../assets/about.png")]
		private var aboutPng : Class;
		
		public var goHome:Signal = new Signal();
		private var _navText:TextField;
		private var _aboutText:TextField;
		private var _displayLayer:Sprite;
		private var _about:Sprite;
		private var _menu:ScreensMenu;
		
		public function ConfigurationScreen(screensModel:ScreensModel)
		{
			//init();
			addChild(new Image(Texture.fromBitmap(new bg())));
			_menu = new ScreensMenu(screensModel);
			addChild(_menu);
			init();
		}
		
		public function get menu():ScreensMenu{
			return _menu;
		}
		
		
		
		private function init():void{
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			addChild(homeBut);
			homeBut.x=8;
			homeBut.y=8;
			homeBut.addEventListener(starling.events.Event.TRIGGERED, function():void{
				goHome.dispatch()
			});
			
			//return;
			var navButton:Button = new Button( Texture.fromBitmap(new screens()) );
			var aboutButton:Button = new Button( Texture.fromBitmap(new about()));
			
			addChild(navButton);
			navButton.addEventListener(starling.events.Event.TRIGGERED,function():void{setState("nav")});
			addChild(aboutButton);
			aboutButton.addEventListener(starling.events.Event.TRIGGERED,function():void{setState("about")});
			navButton.x=Dimentions.WIDTH/2+20;
			navButton.y=18;
			aboutButton.x=Dimentions.WIDTH/2-navButton.width-20;
			aboutButton.y=18;
			_navText = new TextField(navButton.width,40,Texter.flip("תפריט"),"Verdana",21,0x003B94);
			_navText.hAlign = "center";
			addChild(_navText);
			_navText.touchable=false;
			_navText.x = navButton.x;
			_navText.y=navButton.y + navButton.height - 42;
			_aboutText = new TextField(aboutButton.width,40,Texter.flip("מידע כללי"),"Verdana",21,0x002661);
			_aboutText.hAlign = "center";
			addChild(_aboutText);
			_aboutText.touchable = false;
			_aboutText.x = aboutButton.x;
			_aboutText.y=_navText.y;
			setState("nav");
		}
		
		private function setState(stt:String):void{
			_navText.color = 0x003B94;
			_aboutText.color = 0x003B94;
			switch(stt){
				case "nav":
						_navText.color = 0x002661;
						_navText.bold=true;
						_aboutText.bold=false;
						_menu.visible = true;
						if(_about)
							_about.visible=false;
					break;
				case "about":
					if(!_about){
						_about = new Sprite();
						_about.addChild(new Image(Texture.fromBitmap(new aboutPng())));
						//_about.addChild(title);
						//tField.x=20;
						//tField.y=200;
						
						//title.x=20;
						_about.y=120;
						addChild(_about);
					}
						_aboutText.color = 0x002661;
						_menu.visible = false;
						_about.visible=true;
						_navText.bold=false;
						_aboutText.bold=true;
					break;
			
			}
		}
		
		
	
	}
}

