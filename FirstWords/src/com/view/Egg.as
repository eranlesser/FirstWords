package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.view.components.Counter;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.DelayedCall;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Egg extends AbstractScreen
	{
		private var _atlas:TextureAtlas;
		private var _egg:Image;
		private var _counter:Counter = new Counter();
		private var _vc:Vector.<Texture> = new Vector.<Texture>();
		private var _curFrame:uint = 0;
		public function Egg()
		{
			_atlas = Assets.getAtlas("egg");
			_egg = (new Image(_atlas.getTexture("egg1")));
			addChild(_egg);
			_egg.x=(Dimentions.WIDTH-_egg.width)/2
			_egg.y=(Dimentions.HEIGHT-_egg.height)/2
			_egg.addEventListener(TouchEvent.TOUCH,onKnock);
			_vc.push(_atlas.getTexture("egg2"));
			_vc.push(_atlas.getTexture("egg3"));
			_vc.push(_atlas.getTexture("egg6"));
			_enabled=true;
			_counter.count(4);
			_counter.done.add(onCounter);
		}
		
		private function onKnock(e:TouchEvent):void{
			if(!_enabled||_categorySoundPlaying){
				return;
			}
			if(e.getTouch(stage) &&e.getTouch(stage).phase == TouchPhase.BEGAN){
				_counter.progress();
			}
			
		}
		
		private function onCounter():void{
			var chirp:Sound = new Sound(new URLRequest("../../../assets/sounds/egg/chirp.mp3"))
			var sc:SoundChannel = chirp.play();
			sc.addEventListener(Event.SOUND_COMPLETE, 
				function onComplete():void{
					sc.removeEventListener(Event.SOUND_COMPLETE, onComplete);
					chirp.play();
				}
			);
			var delayer:DelayedCall =Starling.juggler.delayCall(progress,1.2);
			delayer.repeatCount=3;
			_enabled=false;
		}
		
		override public function destroy():void{
			if(_egg.parent){
				_egg.removeFromParent(true);
			}
		}
		
		override protected function playWhoIsSound():void{//don't show bird note
		}
		
		private function progress():void{
			removeChild(_egg);
			_egg = new Image(_vc[_curFrame]);
			addChild(_egg);
			_curFrame++;
			_egg.x=(Dimentions.WIDTH-_egg.width)/2
			_egg.y=(Dimentions.HEIGHT-_egg.height)/2
			if(_curFrame == 3){
				Starling.juggler.delayCall(function():void{dispatchDone()},3);
				closeCurtains();
				_enabled=false;
			}
		}
		
		
		
	}
}