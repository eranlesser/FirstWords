package com.view
{
	import com.model.Item;
	import com.view.components.ImageItem;
	import com.view.layouts.Layout;
	import com.view.layouts.ThreeLayout;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends Sprite{
		private var _whoIs:Item;
		private var _layout:Layout;
		private var _frame:Image;
		private var _whereSound:Sound;
		public var refresh:Signal = new Signal();
		public function WhereIsScreen()
		{
			_layout = new ThreeLayout();
			_whereSound = new Sound(new URLRequest("../assets/sounds/where.mp3"))
			
		}
		
		public function setDistractors(items:Vector.<Item>, atlas:TextureAtlas):void{
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			for each(var item:Item in items){
				var img:ImageItem = addDistractor(item.image,item.sound, atlas)
				images.push(img);
				img.addEventListener(TouchEvent.TOUCH,onDistractorTouch);
			}
			_layout.layout(images);
		}
		
		private function  onDistractorTouch(t:TouchEvent):void{
			var imageItem:ImageItem = t.target as ImageItem;
			if(t.getTouch(stage).phase == TouchPhase.BEGAN){
				var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+imageItem.sound));
				sound.play();
			}
		}
		
		public function setWhoIs(item:Item,atlas:TextureAtlas):void{
			_whoIs = item;
			var img:ImageItem = new ImageItem(atlas.getTexture(_whoIs.image),item.sound) 
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			images.push(img);
			_layout.layout(images);
			var shp:Shape = new Shape();
			shp.graphics.lineStyle(1);
			shp.graphics.drawRect(0,0,img.width+2,img.height+2);
			shp.graphics.endFill();
			var bmd:BitmapData = new BitmapData(shp.width,shp.height);
			bmd.draw(shp);
			
			addChild(img);
			img.addEventListener(TouchEvent.TOUCH,onClick);
			var chanel:SoundChannel = _whereSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
		}
		
		private function onWhereIsPlayed(e:flash.events.Event):void{
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+_whoIs.sound));
			sound.play(); 
		}
		
		private function onClick(t:TouchEvent):void{ 
			/*
			var txture:Texture = Texture.fromBitmapData(bmd);
			_frame= new Image(txture);
			_frame.x=img.x-1;
			_frame.y=img.y-1;
			addChild(_frame);
			*/
			if(t.getTouch(stage).phase == TouchPhase.BEGAN){
				refresh.dispatch() 
			}
		}
		public function clear():void{
			_layout.clear();
			if(_frame){
				_frame.removeFromParent(true);
			}
		}
		
		private function addDistractor(itemName:String,sound:String,atlas:TextureAtlas):ImageItem
		{
			var airplane:Texture = atlas.getTexture(itemName);
			var img:ImageItem = new ImageItem(airplane,sound);
			addChild(img);
			
			return img;
			
		}
	}
}
