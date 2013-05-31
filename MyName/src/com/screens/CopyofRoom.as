package com.screens
{
	import com.Dimentions;
	import com.model.ItemModel;
	import com.utils.ItemsGlower;
	import com.utils.NameNarator;
	import com.view.ItemsMenu;
	import com.view.RoomItem;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class cpRoom extends Sprite
	{
		[Embed(source="assets/room.xml", mimeType="application/octet-stream")]
		private  const room_xml:Class;
		
		[Embed(source="assets/room.png")]
		private  const room:Class;
		
		
		private var _atlas:TextureAtlas;
		private var _menu:ItemsMenu;
		private var _window:Window;
		private var _items:Vector.<RoomItem>;
		private var _sipur:Sound = new Sound(new URLRequest("sounds/room/bacheder_sipur.mp3"));
		private var _song:Sound = new Sound(new URLRequest("sounds/room/bamamlach.mp3"));
		private var _narator:NameNarator;
		private var _itemsGlower:ItemsGlower;
		private var _lamp:Button;
		private var _timerText:TextField;
		public function Room(data:XML)
		{
			super();
			_narator = new NameNarator("sounds/names/emanuel.mp3");
			_items = new Vector.<RoomItem>();
			var texture:Texture=  Texture.fromBitmap(new room());
			_atlas = new TextureAtlas(texture,new XML(new room_xml()) as XML);
			_window = new Window(_atlas);
			addChild(_window);
			_window.x=58;
			_window.y=56;
			addChild(new Image(_atlas.getTexture("empty_room")));
			_lamp = new Button(_atlas.getTexture("lamp_on"));
			_lamp.x=463;
			_lamp.y=95;
			addChild(_lamp);
			_lamp.addEventListener(starling.events.Event.TRIGGERED,toggleLight);
			_menu = new ItemsMenu();
			addChild(_menu);
			_menu.y = Dimentions.HEIGHT - ItemsMenu.ITEM_WIDTH-10;
			parse(data);
			var v:Vector.<Number> = new Vector.<Number>();
			v.push(2.832)
			v.push(21.689)
			v.push(41.351)
			_narator.play(v);
			_itemsGlower = new ItemsGlower();
			placeItems();
			Starling.juggler.delayCall(playStory,2.432);
			_itemsGlower.start();
			_timerText = new TextField(100,40,"");
			addChild(_timerText);
			addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function playStory():void{
			var chnl:SoundChannel = _sipur.play();
			chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,dropItems);
			Starling.juggler.delayCall(toggleLight,17.192);
			Starling.juggler.delayCall(toggleLight,19);
			Starling.juggler.delayCall(_window.sunRise,48);
		}
		
		private function parse(xml:XML):void{
			var itemModel:ItemModel;
			var i:uint=0;
			for each(var item:XML in xml.item){
				if(item.@menuItem!="false"){
					itemModel = new ItemModel(item)
					itemModel.menuIndex = i;
					i++;
					var roomItem:RoomItem = new RoomItem(_atlas,itemModel);
					_menu.addItem(roomItem);
					_items.push(roomItem);
				}
			}
			
		}
		
		protected function onEnterFrame(event:starling.events.Event):void
		{
			// TODO Auto-generated method stub
			_timerText.text = getTimer().toString();
//			for each(var snd:ToPlaySound in _sounds){
//				var t:int =  getTimer();
//				trace(getTimer() ,">", snd.playTime)
//				if(getTimer() >= snd.playTime && snd.played==false){
//					snd.play();
//					snd.played=true;
//				}
//			}
		}
		
		
		private function placeItems():void{
			for each(var roomItem:RoomItem in _items){
				addChild(roomItem);
				roomItem.state = RoomItem.ON_STAGE_STATE;
				roomItem.x = roomItem.model.x;
				roomItem.y = roomItem.model.y;
				if(roomItem.model.glowTime>0)
					_itemsGlower.addItem(roomItem,roomItem.model.glowTime);
			}
		}
		
		private function dropItems(e:flash.events.Event):void{
			for each(var roomItem:RoomItem in _items){
				var tween:Tween = new Tween(roomItem,2);
				Starling.juggler.add(tween);
				tween.animate("y",Dimentions.HEIGHT);
				tween.delay = 1;
				roomItem.addEventListener(TouchEvent.TOUCH,onTouch);
			}
			Starling.juggler.delayCall(onBackToMenu,3.4);
			_song.play();
		}
		
		private function onBackToMenu():void{
			_menu.y=Dimentions.HEIGHT;
			for each(var roomItem:RoomItem in _items){
				roomItem.state = RoomItem.MENU_STATE;
				_menu.addItem(roomItem);
			}
			var tween:Tween = new Tween(_menu,1);
			Starling.juggler.add(tween);
			tween.animate("y",Dimentions.HEIGHT-ItemsMenu.ITEM_WIDTH);
			
		}
		
		private function toggleLight():void{
			if(_lamp.alpha==0){
				_lamp.alpha=1;
			}else{
				_lamp.alpha=0;
			}
		}
		
		private var _downX:Number;
		private var _downY:Number;
		private function onTouch(e:TouchEvent):void
		{
			var item:RoomItem = e.currentTarget as RoomItem;
			var touch:Touch = e.getTouch(this.stage); 
			if(touch.phase == TouchPhase.BEGAN){
				_downX = touch.globalX;
				_downY = touch.globalY;
			}
			if(touch.phase == TouchPhase.MOVED){	
				if(item.parent is ItemsMenu){
					(item.parent as ItemsMenu).removeItem(item);
					addChild(item);
				}
				if(touch.globalY>700){
					item.state = RoomItem.MENU_STATE;
					item.x = touch.globalX-ItemsMenu.ITEM_WIDTH/2;
					item.y = touch.globalY-ItemsMenu.ITEM_WIDTH/2;
				}else{
					item.state = RoomItem.ON_STAGE_STATE;
					item.x = touch.globalX-item.width/2;
					item.y = touch.globalY-item.height/2;
				}
			}
			if(touch.phase == TouchPhase.ENDED){
				if(touch.globalY>700){
					item.state = RoomItem.MENU_STATE;
					_menu.addItem(item);
				}
			}
		}
	}
}

import com.utils.filters.GlowFilter;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.TextureAtlas;

class Window extends Sprite{
private var sun:DisplayObject;
	function Window(atlas:TextureAtlas):void{
		addChild(new Image(atlas.getTexture("day_window")));
		sun = addChild(new Image(atlas.getTexture("sun")));
		sun.x=20;
		sun.y=34;
	}
	
	public function sunRise():void{
		var tween:Tween = new Tween(sun,2);
		tween.animate("y",30);
		tween.animate("x", 44);
		tween.onComplete = function():void{
			Starling.juggler.remove(tween);
			sun.filter = null;
			var tween2:Tween = new Tween(sun,2);
			tween2.animate("y",20);
			tween2.animate("x", 34);
			Starling.juggler.add(tween2);
		}
		//tween.animate("rotation", 4);
		Starling.juggler.add(tween);
		sun.filter = new GlowFilter(0xFFFF44,1,12,12);
	}
	
}