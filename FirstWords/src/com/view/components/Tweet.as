package com.view.components
{
	import com.view.playRoom.Book;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Tweet extends Sprite
	{
		[Embed(source="../../../assets/tweets/birds0.png")]
		private var birds : Class;
		[Embed(source="../../../assets/tweets/birds1.png")]
		private var birds1 : Class;
		[Embed(source="../../../assets/tweets/birds2.png")]
		private var birds2 : Class;
		[Embed(source="../../../assets/tweets/birds3.png")]
		private var birds3 : Class;
		[Embed(source="../../../assets/tweets/birds4.png")]
		private var birds4 : Class;
		private var _lastNoteImage:Image;
		public var clicked:Signal = new Signal();
		public function Tweet(bg:String,tweets:XML)
		{
			addChild(new Image(Texture.fromBitmap(new birds())));
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		public function play(tweet:Boolean=true):void{
			var call:DelayedCall = Starling.juggler.delayCall(addNote,0.2);
			call.repeatCount=12;
			Starling.juggler.delayCall(removeNote,0.2*13);
			if(tweet){
				var sound:Sound = new Sound(new URLRequest("../../assets/sounds/birds1.mp3"))
				sound.play();
			}
		}
		
		public function tweet():void{
			addNote();
			Starling.juggler.delayCall(removeNote,2);
		}
		private function removeNote():void{
			if(numChildren>1){
				removeChildAt(1);
			}
		}
		
		private function addNote():void{
			removeNote();
			addChild(getRandomImage());
		}
		
		private function getRandomImage():Image{
			var rand:Number = Math.random();
			var img:Image;
			if(rand<0.25){
				img=new Image(Texture.fromBitmap(new birds1()));
			}else if(rand<0.5){
				img=new Image(Texture.fromBitmap(new birds2()));
				
			}else if(rand<0.75){
				img=new Image(Texture.fromBitmap(new birds3()));
				
			}else{
				img=new Image(Texture.fromBitmap(new birds4()));
				
			}
			if(_lastNoteImage==img){
				return getRandomImage();				
			}
			img.scaleX=-1;
			img.x=img.width;
			_lastNoteImage = img;
			trace("add",img,rand)
			return img;
		}
		
		private function onTouch(t:TouchEvent):void{
			if(t.getTouch(stage)&&(t.getTouch(stage).phase == TouchPhase.BEGAN)){
				clicked.dispatch();
			}
		}
	}
}
