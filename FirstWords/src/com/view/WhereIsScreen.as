package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.view.components.Clouds;
	import com.view.components.ImageItem;
	import com.view.components.ParticlesEffect;
	import com.view.layouts.Layout;
	import com.view.layouts.ThreeLayout;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends AbstractScreen{
		
		
		private var _layout:			Layout;
		private var _goodSound:			Sound;
		[Embed(source="../../assets/home/flowersBg.png")]
		private var flowersBg : Class;
		[Embed(source="../../assets/home/grass_bg.png")]
		private var grassBg : Class;
		
		public function WhereIsScreen()
		{
			super();
			init();
		}
		
		private function init():void{
			_layout = new ThreeLayout(this.screenLayer);
			var bg:Image = new Image(Texture.fromBitmap(new Assets.BackgroundImage()));
			_screenLayer.addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			_screenLayer.addChild(new Clouds());
			var flowers:Image;
			if(Math.random()>0.5)
				flowers = new Image(Texture.fromBitmap(new flowersBg()))
			else
				flowers = new Image(Texture.fromBitmap(new grassBg()))
			_screenLayer.addChild(flowers);
			flowers.y = Dimentions.HEIGHT-flowers.height;
		}
		
		override protected function complete():void{
			_model.reset();
		}
		
		override public function set model(model:ScreenModel):void{
			super.model = model;
			setItems();
		}
		
		private function onGoodItemClick(img:ImageItem):Boolean{
			if(super.onGoodClick()){
				_particlesEffect = new ParticlesEffect();
				_particlesEffect.width=img.width/10;
				_particlesEffect.height=img.height/10;
				_particlesEffect.x=img.x+img.width/2;
				_particlesEffect.y=img.y+img.height/2;
				_screenLayer.addChild(_particlesEffect);
				_particlesEffect.start("drug");
			}
			return true;
		}
		
		private function clear():void{
			_layout.clear();
			if(_particlesEffect){
				_particlesEffect.stop();
			}
		}
		
		override protected function setItems():Boolean{
			if(!super.setItems()){
				return false;
			}
			clear();
			setWhoIs(_model.whoIsItem,Assets.getAtlas(_model.groupName));
			var items:Vector.<Item> = new Vector.<Item>();
			items.push(_model.distractor);
			items.push(_model.distractor);
			setDistractors(items,Assets.getAtlas(_model.groupName));
			return true;
		}
		
		private function setDistractors(items:Vector.<Item>, atlas:TextureAtlas):void{
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			for each(var item:Item in items){
				var img:ImageItem = getDistractor(item.image,item.sound, atlas)
				images.push(img);
				img.touched.add(onDistractorTouch);
			}
			_layout.layout(images);
		}
		
		private function getDistractor(itemName:String,sound:String,atlas:TextureAtlas):ImageItem
		{
			var distractor:Texture = atlas.getTexture(itemName);
			var img:ImageItem = new ImageItem(distractor,sound);
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
			img.touched.add(onGoodItemClick);
			var chanel:SoundChannel = _whereSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
		}
		
		
	}
}
