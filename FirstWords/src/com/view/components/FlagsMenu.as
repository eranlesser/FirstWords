package com.view.components
{
	import com.model.Session;
	import com.sticksports.nativeExtensions.flurry.Flurry;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class FlagsMenu extends Sprite
	{
		[Embed(source="assets/flags/flags.xml", mimeType="application/octet-stream")]
		private const flags_xml:Class;
		
		[Embed(source="assets/flags/flags.png")]
		private  const flags:Class;
		[Embed(source="assets/flags/combo.png")]
		private  const bg:Class;
		
		private var _atlas:TextureAtlas;
		private var _selectedFlag:Flag;
		private var _container:Sprite;
		public static const FLAG_WIDTH:uint = 80;
		public function FlagsMenu()
		{
			var texture:Texture=  Texture.fromBitmap(new flags());
			_atlas = new TextureAtlas(texture,new XML(new flags_xml()) as XML);
			var btn:Button = addChild(new Button(Texture.fromBitmap(new bg()))) as Button;
			btn.addEventListener(Event.TRIGGERED,onOpen);
			btn.x=-16;
			btn.y=-6;
			btn.alpha=0.6;
			addFlags();
			setSelectedFlag("uk")
			visible=false;
		}
		
		private function setSelectedFlag(lang:String):void{
			if(_selectedFlag){
			//	removeChild(_selectedFlag);
			//	_selectedFlag.clicked.remove(onOpen)
			}
			_selectedFlag = new Flag(_atlas.getTexture(lang),lang);
			addChild(_selectedFlag);
			_selectedFlag.width=80;
			_selectedFlag.height=60;
			Session.setLanguage(lang);
			_container.visible=false;
			Session.lang = lang;
			_selectedFlag.touchable = false;
			Flurry.logEvent("language=",{language:lang});
		}
		
		private function onOpen(lang:String):void
		{
			_container.visible=!_container.visible;
			// TODO Auto Generated method stub
			
		}
		
		public function close():void{
			_container.visible=false;
		}
		
		private function addFlags():void{
			_container = new Sprite();
			addChild(_container);
			_container.y=62;
			addFlag("israel");
			//addFlag("russia");
			addFlag("uk");
			//addFlag("brazil");
			//addFlag("france");
			//addFlag("holland");
		}
		private var _hgt:uint=0;
		private function addFlag(name:String):void{
			var flag:Flag = new Flag(_atlas.getTexture(name),name);
			_container.addChild(flag);
			flag.width=FLAG_WIDTH;
			flag.height=60;
			flag.y=_hgt;
			flag.clicked.add(setSelectedFlag);
			_hgt = _hgt+62;
		}
		
	}
}
import org.osflash.signals.Signal;

import starling.display.Button;
import starling.events.Event;
import starling.textures.Texture;

class Flag extends Button{
	private var _lang:String;
	public var clicked:Signal = new Signal();
	public function Flag(upstate:Texture,lang:String){
		_lang = lang;
		super(upstate);
		addEventListener(Event.TRIGGERED,onClicked);
	}
	
	private function onClicked(e:Event):void{
		clicked.dispatch(_lang)
	}
	
	public function get lang():String{
		return _lang;
	}
}