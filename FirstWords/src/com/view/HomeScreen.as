package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreensModel;
	import com.model.Session;
	import com.model.rawData.Texts;
	import com.utils.filters.GlowFilter;
	import com.view.components.Clouds;
	import com.view.components.FlagsMenu;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class HomeScreen extends AbstractScreen
	{
		
		public var gotoSignal:Signal = new Signal();
		[Embed(source="../../assets/home/plybtn.png")]
		private var playBt : Class;
		[Embed(source="../../assets/home/home.png")]
		private var home : Class;
		[Embed(source="../../assets/confBut.png")]
		private var wBird : 			Class;
		[Embed(source="assets/title_heb.png")]
		public static const title_heb:Class;
		//private var _clouds:Clouds;
		private var _flags:FlagsMenu;
		private var _menuText:TextField;
		private var _titleText:TextField;
		private var _titleHeb:Image;
		private var _texts:Texts;
		public function HomeScreen(screens:ScreensModel)
		{
			Assets.load();
			_texts = new Texts();
			var homeBg:Image = new Image(Texture.fromBitmap(new home()))
			_screenLayer.addChild(homeBg);
			_flags = new FlagsMenu();
			//_flags.visible=false;
			_flags.y=16;
			_flags.x=Dimentions.WIDTH-_flags.width-8;
			_screenLayer.addChild(_flags);
			var whereBird:Button = new Button(Texture.fromBitmap(new wBird()));
			_screenLayer.addChild(whereBird);
			whereBird.x=8;
			whereBird.y=8;
			whereBird.addEventListener(Event.TRIGGERED,openMenu);
			_menuText = new TextField(whereBird.width,40,_texts.getText("menu"),"Verdana",_texts.getMenuTextSize(),0x002661);
			addChild(_menuText);
			_menuText.x=whereBird.x;
			_menuText.y=whereBird.y+whereBird.height-9;
			_titleText = new TextField(450,100,_texts.getText("title"),"Verdana",52,0x002661);
			addChild(_titleText);
			_titleText.x=Dimentions.WIDTH-_titleText.width//+20;
			_titleText.y=300;
			_titleText.filter = new GlowFilter(0xFFFFFF);
			_titleHeb = new Image(Texture.fromBitmap(new title_heb()));
			addChild(_titleHeb);
			_titleHeb.x=Dimentions.WIDTH-_titleText.width;
			_titleHeb.y = 300;
			
			if(Session.lang=="israel"){
				_titleHeb.visible=true;
				_titleText.visible=false;
				_menuText.visible=false;
			}else{
				_menuText.visible=true;
				_titleHeb.visible=false;
				_titleText.visible=true;
			}
			
			
			Session.langChanged.add(
				function onLangChanged():void{
					_menuText.text = _texts.getText("menu");
					_titleText.text = _texts.getText("title");
					_menuText.fontSize = _texts.getMenuTextSize();
					if(Session.lang=="israel"){
						_titleHeb.visible=true;
						_titleText.visible=false;
						_menuText.visible=false;
					}else{
						_menuText.visible=true;
						_titleHeb.visible=false;
						_titleText.visible=true;
					}
				}
			);
			var playBut:Button = new Button( Texture.fromBitmap(new playBt()) );
			addChild(playBut);
			playBut.x=110//(Dimentions.WIDTH-playBut.width)/3;
			playBut.y=168;
			playBut.addEventListener(Event.TRIGGERED,function():void{gotoSignal.dispatch(Session.currentScreen)});
			this.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(t:TouchEvent):void{
			if(t.getTouch(stage)&&(t.getTouch(stage).phase == TouchPhase.BEGAN)){
				if(t.getTouch(stage).target is Image && ((t.getTouch(stage).target as Image).width == 130||(t.getTouch(stage).target as Image).width == 200)){
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

