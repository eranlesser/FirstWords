package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.model.Session;
	import com.view.components.Clouds;
	import com.view.components.ImageItem;
	import com.view.components.Tweet;
	import com.view.layouts.Layout;
	import com.view.layouts.ThreeLayout;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends AbstractScreen{
		
		
		private var _layout:			Layout;
		private var _goodSound:			Sound;
		private var _clouds:			Clouds;
		private var _birds:				Tweet;
		
		public function WhereIsScreen()
		{
			super();
			init();
		}
		
		private function init():void{
			_layout = new ThreeLayout(this.screenLayer);
			_clouds = new Clouds()
			_screenLayer.addChild(_clouds);
			_birds = new Tweet(null,null);
			_screenLayer.addChild(_birds);
			_birds.clicked.add(
				function():void{
					if(_enabled){
						_birds.tweet(true);
						//playWhoIsSound();
					}
				}
			);
			_birds.y=110;
			_birds.x = Dimentions.WIDTH+12;
			_birds.scaleX=-1;
			
		}
		
		override public function destroy():void{
			_clouds.stop();
			super.destroy();
		}
		
		override protected function complete():void{
			_model.reset();
		}
		
		override public function set model(model:ScreenModel):void{
			super.model = model;
			if(_categorySound){
				var chnl:SoundChannel = _categorySound.play();
				//chnl.addEventListener(Event.SOUND_COMPLETE,function():void{setItems()});
			}
				setItems();
		}
		
		private function onGoodItemClick(img:ImageItem):Boolean{
			if(super.onGoodClick()){
				//_birds.tweet(true);
				img.onGoodClick();
				img.touched.remove(onGoodItemClick);
			}
			return true;
		}
		
		private function clear():void{
			_layout.clear();
		}
		
		override protected function closeCurtains():void{
			_birds.play();
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
			var sound:Sound = _soundManager.getSound("../assets/sounds/",imageItem.sound);
			var chnl:SoundChannel = sound.play();
			chnl.addEventListener(Event.SOUND_COMPLETE,function onChnl():void{
				chnl.removeEventListener(Event.SOUND_COMPLETE,onChnl);
				_enabled=true;
			});
			_enabled = false;
			Session.wrongAnswer++;
		}
		
		private function setWhoIs(item:Item,atlas:TextureAtlas):void{
			_whoIs = item;
			var img:ImageItem = new ImageItem(atlas.getTexture(_whoIs.image),item.sound) 
			var images:Vector.<ImageItem> = new Vector.<ImageItem>();
			images.push(img);
			_layout.layout(images);
			img.touched.add(onGoodItemClick);
			if(!_categorySoundPlaying){//wait for categorySound
				playWhoIsSound();
			}
		}
		
		override protected function playWhoIsSound():void{
			var chanel:SoundChannel = _questionSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
			_enabled=false;
			//_birds.tweet();
			super.playWhoIsSound();
		}
		
		
	}
}
