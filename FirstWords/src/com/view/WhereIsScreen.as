package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
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
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends Sprite{
		private var _whoIs:Item;
		private var _layout:Layout;
		private var _whereSound:Sound;
		private var _goodSound:Sound;
		private var _particlesEffect:ParticlesEffect;
		private var _enabled:Boolean;
		private var _model:ScreenModel;
		private var _counter:uint=0;
		public var refresh:Signal = new Signal();
		[Embed(source="../../assets/home.jpg")]
		private var homeBt : Class;
		public var goHome:Signal = new Signal();
		public var done:Signal = new Signal();
		public function WhereIsScreen()
		{
			_layout = new ThreeLayout(this);
			_whereSound = new Sound(new URLRequest("../assets/sounds/where.mp3"));
			
			var bg:Image = new Image(Texture.fromBitmap(new Assets.BackgroundImage()));
			addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			addChild(homeBut);
			homeBut.x=4;
			homeBut.y=4;
			homeBut.addEventListener(starling.events.Event.TRIGGERED , function():void{
				complete();
				goHome.dispatch()
			});
		}
		
		
		
		private function complete():void{
			_model.reset();
		}
		
		private function onClick(img:ImageItem):void{ 
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
		
		public function set model(group:ScreenModel):void{
			_counter=0;
			_model=group;
			setItems();
		}
		
		
		private function goodSoundComplete(e:flash.events.Event):void{
			Starling.juggler.delayCall(moveNext,2);
			
			SoundChannel(e.target).removeEventListener(flash.events.Event.SOUND_COMPLETE, goodSoundComplete);
		}
		
		private function moveNext():void{
			setItems();
		}
		
		private function clear():void{
			_layout.clear();
			if(_particlesEffect){
				_particlesEffect.stop();
			}
		}
		
		private function setItems():void{
			clear();
			_model.clear();
			if(_counter>=_model.numItems){
				complete();
				done.dispatch();
				return;
			}
			setWhoIs(_model.whoIsItem,Assets.getAtlas(_model.groupName));
			var items:Vector.<Item> = new Vector.<Item>();
			items.push(_model.distractor);
			items.push(_model.distractor);
			setDistractors(items,Assets.getAtlas(_model.groupName));
			_counter++;
		}
		
		private function setDistractors(items:Vector.<Item>, atlas:TextureAtlas):void{
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			for each(var item:Item in items){
				var img:ImageItem = addDistractor(item.image,item.sound, atlas)
				images.push(img);
				img.touched.add(onDistractorTouch);
			}
			_layout.layout(images);
		}
		
		private function addDistractor(itemName:String,sound:String,atlas:TextureAtlas):ImageItem
		{
			var airplane:Texture = atlas.getTexture(itemName);
			var img:ImageItem = new ImageItem(airplane,sound);
			return img;
		}
		
		private function  onDistractorTouch(imageItem:ImageItem):void{
			if(!_enabled){
				return;
			}
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+imageItem.sound));
			sound.play();
		}
		
		private function setWhoIs(item:Item,atlas:TextureAtlas):void{
			_whoIs = item;
			var img:ImageItem = new ImageItem(atlas.getTexture(_whoIs.image),item.sound) 
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			images.push(img);
			_layout.layout(images);
			
			img.touched.add(onClick);
			var chanel:SoundChannel = _whereSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
		}
		
		private function onWhereIsPlayed(e:flash.events.Event):void{
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+_whoIs.sound));
			var chanel:SoundChannel = sound.play(); 
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,function():void{_enabled = true});
		}
		
		
	}
}
