package com.view
{
	import com.Dimentions;
	import com.model.Item;
	import com.view.components.ImageItem;
	import com.view.components.ParticlesEffect;
	import com.view.layouts.Layout;
	import com.view.layouts.ThreeLayout;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends Sprite{
		private var _whoIs:Item;
		private var _layout:Layout;
		private var _whereSound:Sound;
		private var _goodSound:Sound;
		private var _particlesEffect:ParticlesEffect;
		private var _enabled:Boolean;
		public var refresh:Signal = new Signal();
		public function WhereIsScreen()
		{
			_layout = new ThreeLayout(this);
			_whereSound = new Sound(new URLRequest("../assets/sounds/where.mp3"))
			
		}
		
		public function setDistractors(items:Vector.<Item>, atlas:TextureAtlas):void{
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			for each(var item:Item in items){
				var img:ImageItem = addDistractor(item.image,item.sound, atlas)
				images.push(img);
				img.touched.add(onDistractorTouch);
			}
			_layout.layout(images);
		}
		
		private function  onDistractorTouch(imageItem:ImageItem):void{
			if(!_enabled){
				return;
			}
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+imageItem.sound));
			sound.play();
		}
		
		public function setWhoIs(item:Item,atlas:TextureAtlas):void{
			_whoIs = item;
			var img:ImageItem = new ImageItem(atlas.getTexture(_whoIs.image),item.sound) 
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			images.push(img);
			_layout.layout(images);
			_enabled = true;
			//addChild(img);
			
			img.touched.add(onClick);
			var chanel:SoundChannel = _whereSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
		}
		
		private function onWhereIsPlayed(e:flash.events.Event):void{
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+_whoIs.sound));
			sound.play(); 
		}
		
		public function complete():void{
			_particlesEffect = new ParticlesEffect();
			addChild(_particlesEffect);
			_particlesEffect.x=Dimentions.WIDTH/2;
			_particlesEffect.y=Dimentions.HEIGHT;
			_particlesEffect.width=Dimentions.WIDTH;
			_particlesEffect.start("drug");
		}
		
		private function onClick(img:ImageItem):void{ 
//			var shp:Shape = new Shape();
//			shp.graphics.lineStyle(1);
//			shp.graphics.drawRect(0,0,img.width+2,img.height+2);
//			shp.graphics.endFill();
//			var bmd:BitmapData = new BitmapData(shp.width,shp.height);
//			bmd.draw(shp);
//			var txture:Texture = Texture.fromBitmapData(bmd);
//			_frame= new Image(txture);
//			_frame.x=img.x-1;
//			_frame.y=img.y-1;
//			addChild(_frame);
			if(!_enabled){
				return;
			}
			
			var soundFile:String;
			if(Math.random()>0.2)
				soundFile = "../assets/sounds/goodA"+Math.ceil(Math.random()*4)+".mp3";
			else
				soundFile = "../assets/sounds/good"+Math.ceil(Math.random()*4)+".mp3";
			var goodSound:Sound = new Sound(new URLRequest(soundFile));
			var channel:SoundChannel = goodSound.play();
			channel.addEventListener(flash.events.Event.SOUND_COMPLETE,goodSoundComplete);
			_particlesEffect = new ParticlesEffect();
			_particlesEffect.width=img.width/10;
			_particlesEffect.height=img.height/10;
			_particlesEffect.x=img.x+img.width/2;
			_particlesEffect.y=img.y+img.height/2;
			addChild(_particlesEffect);
			_particlesEffect.start("drug");
			_enabled=false;
		}
		
		private function goodSoundComplete(e:flash.events.Event):void{
			Starling.juggler.delayCall(moveNext,2);
			
			SoundChannel(e.target).removeEventListener(flash.events.Event.SOUND_COMPLETE, goodSoundComplete);
		}
		
		private function moveNext():void{
			refresh.dispatch() ;
		}
		
		public function clear():void{
			_layout.clear();
			if(_particlesEffect){
				_particlesEffect.stop();
			}
		}
		
		private function addDistractor(itemName:String,sound:String,atlas:TextureAtlas):ImageItem
		{
			var airplane:Texture = atlas.getTexture(itemName);
			var img:ImageItem = new ImageItem(airplane,sound);
			//addChild(img);
			
			return img;
			
		}
	}
}
