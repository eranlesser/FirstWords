package com.view.components
{
	import com.model.Session;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class FlagsMenu extends Sprite
	{
		[Embed(source="assets/flags/flags.xml", mimeType="application/octet-stream")]
		private const flags_xml:Class;
		
		[Embed(source="assets/flags/flags.png")]
		private  const flags:Class;
		private var _atlas:TextureAtlas;
		private var _selectedFlag:Flag;
		private var _container:Sprite;
		public function FlagsMenu()
		{
			var texture:Texture=  Texture.fromBitmap(new flags());
			_atlas = new TextureAtlas(texture,new XML(new flags_xml()) as XML);
			
			addFlags();
			setSelectedFlag("israel")
		}
		
		private function setSelectedFlag(lang:String):void{
			if(_selectedFlag){
				removeChild(_selectedFlag);
				_selectedFlag.clicked.remove(onOpen)
			}
			_selectedFlag = new Flag(_atlas.getTexture(lang),lang);
			addChild(_selectedFlag);
			_selectedFlag.clicked.add(onOpen)
			_selectedFlag.width=80;
			_selectedFlag.height=60;
			Session.setLanguage(lang);
			_container.visible=false;
			Session.lang = lang;
		}
		
		private function onOpen(lang:String):void
		{
			_container.visible=true;
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
			addFlag("russia");
			addFlag("uk");
			addFlag("brazil");
			addFlag("france");
			addFlag("holland");
		}
		private var _hgt:uint=0;
		private function addFlag(name:String):void{
			var flag:Flag = new Flag(_atlas.getTexture(name),name);
			_container.addChild(flag);
			flag.width=80;
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