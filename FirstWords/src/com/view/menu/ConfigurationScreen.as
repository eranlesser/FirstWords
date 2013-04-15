package com.view.menu
{
	import assets.texts.heb.AboutText;
	
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.Session;
	
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
		[Embed(source="../../../assets/menu/share.png")]
		private var share : 			Class;
		
		public var gotoSignal:Signal = new Signal();
		public var goHome:Signal = new Signal();
		private var _navText:TextField;
		private var _aboutText:TextField;
		private var _shareText:TextField;
		
		private var _displayLayer:Sprite;
		
		private var _menu:Sprite;
		private var _about:Sprite;
		public function ConfigurationScreen(screensModel:ScreensModel)
		{
			//init();
			_displayLayer = new Sprite();
			addChild(_displayLayer);
			addChild(new Image(Texture.fromBitmap(new bg())));
			initMenu(screensModel);
			init();
		}
		
		private function init():void{
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			addChild(homeBut);
			homeBut.x=4;
			homeBut.y=4;
			homeBut.addEventListener(Event.TRIGGERED, function():void{
				goHome.dispatch()
			});
			_about = new Sprite();
			var tField:TextField = new TextField(900,600,AboutText.xml.toString(),"Verdena",19,0X03588C);
			var title:TextField = new TextField(900,80,AboutText.title,"Verdena",34,0X415A79);
			_about.addChild(tField);
			_about.addChild(title);
			tField.x=20;
			tField.y=200;
			
			title.x=20;
			title.y=120;
			addChild(_about);
			_about.visible=false;
			tField.hAlign = "right";
			title.hAlign = "right";
			//return;
			var navButton:Button = new Button( Texture.fromBitmap(new screens()) );
			var aboutButton:Button = new Button( Texture.fromBitmap(new about()));
			var shareButton:Button = new Button( Texture.fromBitmap(new share()) );
			
			addChild(navButton);
			navButton.addEventListener(Event.TRIGGERED,function():void{setState("nav")});
			addChild(aboutButton);
			aboutButton.addEventListener(Event.TRIGGERED,function():void{setState("about")});
			//addChild(shareButton);
			shareButton.addEventListener(Event.TRIGGERED,function():void{setState("share")});
			navButton.x=650;
			navButton.y=18;
			aboutButton.x=800;
			aboutButton.y=18;
			shareButton.x=700;
			shareButton.y=18;
			
			_navText = new TextField(navButton.width,40,"תפריט","Verdana",19,0x003B94);
			_navText.hAlign = "center";
			addChild(_navText);
			_navText.touchable=false;
			_navText.x = navButton.x;
			_navText.y=navButton.y + navButton.height - 42;
			_aboutText = new TextField(aboutButton.width,40,"מידע כללי","Verdana",19,0x002661);
			_aboutText.hAlign = "center";
			addChild(_aboutText);
			_aboutText.touchable = false;
			_aboutText.x = aboutButton.x;
			_aboutText.y=_navText.y;
		}
		
		private function setState(stt:String):void{
			return;
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
		
		public function setSelectedScreen():void{
			for(var i:uint = 0;i<_menu.numChildren;i++){
				if(i>3){
					(_menu.getChildAt(i) as ThumbNail).locked=true;
				}else{
					(_menu.getChildAt(i) as ThumbNail).locked=false;
				}
				if((_menu.getChildAt(i) as ThumbNail).index==Session.currentScreen){
					(_menu.getChildAt(i) as ThumbNail).selected = true;
				}else{
					(_menu.getChildAt(i) as ThumbNail).selected = false;
				}
			}
		}
		
		private function initMenu(screens:ScreensModel):void
		{
			_menu = new Sprite();
			
			var i:int=0;
			var n:int=0;
			var wdt:uint=170;
			var hgt:uint=136;
			var gap:uint=12;
			for each(var screen:ScreenModel in screens.screens){
				if(screen.thumbNail!=""){
					var menuThmb:ThumbNail = new ThumbNail(Assets.getAtlas("thumbs").getTexture(screen.thumbNail),i);
					
					//menuThmb.width = wdt;
					//menuThmb.height = hgt;
					
					menuThmb.x = (n%4)*wdt + (n%4)*gap;//menuThmb.x-5;
					menuThmb.y = Math.floor(n/4)*(hgt+gap);//menuThmb.y-5;
					_menu.addChild(menuThmb);
					menuThmb.addEventListener(Event.TRIGGERED,function onTriggered(e:Event):void{
						gotoSignal.dispatch(ThumbNail(Button(e.target).parent).index);
					});
					n++;
				}//if
				i++;
			}//for
			var playRoomThmb:ThumbNail = new ThumbNail(Assets.getAtlas("thumbs").getTexture("plane"),-2);
			_menu.addChild(playRoomThmb);
			playRoomThmb.addEventListener(Event.TRIGGERED,function onTriggered(e:Event):void{
				gotoSignal.dispatch(ThumbNail(Button(e.target).parent).index);
			});
			playRoomThmb.x=_menu.width-playRoomThmb.width-4;
			playRoomThmb.y=_menu.height-playRoomThmb.height-4;
			_menu.x=(Dimentions.WIDTH-_menu.width)/2;
			_menu.y=140;
			addChild(_menu);
		}//function
	}
}

import com.Assets;
import com.Dimentions;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

class ThumbNail extends Sprite{
	public var index:int;
	private var _btn:Button;
	private var _selectedFrame:Image;
	private var _lock:Image;
	function ThumbNail(asset:Texture,indx:int){
		var frame:Image = new Image(Texture.fromBitmap(new Assets.Frame))
		_selectedFrame = new Image(Texture.fromBitmap(new Assets.FrameSelected))
		
		var wdt:uint=170;
		var hgt:uint=136;
		addChild(frame);
		addChild(_selectedFrame);
		_selectedFrame.visible=false;
		frame.width = wdt;
		frame.height = hgt;
		_btn = new Button(asset);
		addChild(_btn)
		_btn.x=(frame.width-_btn.width)/2;
		_btn.y=(frame.height-_btn.height)/2;
		_lock = new Image(Texture.fromBitmap(new Assets.Lock));
		addChild(_lock);
		_lock.x=wdt-_lock.width-5;
		_lock.y=hgt-_lock.height-5;
		index=indx;
		
	}
	
	public function set selected(val:Boolean):void{
		_selectedFrame.visible=val;
	}
	
	public function set locked(val:Boolean):void{
		_lock.visible=val;
		this.touchable = !val;
	}
	
}
