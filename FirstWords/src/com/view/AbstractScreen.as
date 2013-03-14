package com.view
{
	import com.model.Item;
	import com.model.ScreenModel;
	import com.view.components.ImageItem;
	import com.view.components.ParticlesEffect;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class AbstractScreen extends Sprite
	{
		
		protected var _whereSound:		Sound;
		public var goHome:Signal = new Signal();
		public var done:Signal = new Signal();
		[Embed(source="../../assets/home/homeBtn.png")]
		private var homeBt : 			Class;
		protected var _particlesEffect:	ParticlesEffect;
		protected var _model:			ScreenModel;
		protected var _enabled:			Boolean;
		private var _counter:			uint=0;
		protected var _whoIs:			Item;
		protected var _guiLayer:		Sprite;
		protected var _screenLayer:		Sprite;
		public function AbstractScreen()
		{
			_screenLayer = new Sprite();
			addChild(_screenLayer);
			_guiLayer = new Sprite();
			addChild(_guiLayer);
			addNavigation();
		}
		protected function addNavigation():void{
			_whereSound = new Sound(new URLRequest("../assets/sounds/where.mp3"));
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			_guiLayer.addChild(homeBut);
			homeBut.x=4;
			homeBut.y=4;
			homeBut.addEventListener(starling.events.Event.TRIGGERED, function():void{
				complete();
				goHome.dispatch()
			});
		}
		public function get screenLayer():Sprite{
			return _screenLayer;
		}
		
		public function get diposable():Boolean{
			return true;
		}
		
		public function set model(screenModel:ScreenModel):void{
			_counter=0;
			_model=screenModel;
		}
		
		protected function onGoodClick():Boolean{ 
			if(!_enabled){
				return false;
			}
			var soundFile:String;
			if(Math.random()>0.2)
				soundFile = "../assets/sounds/goodA"+Math.ceil(Math.random()*4)+".mp3";
			else
				soundFile = "../assets/sounds/good"+Math.ceil(Math.random()*4)+".mp3";
			var goodSound:Sound = new Sound(new URLRequest(soundFile));
			var channel:SoundChannel = goodSound.play();
			channel.addEventListener(flash.events.Event.SOUND_COMPLETE,goodSoundComplete);
			_enabled=false;
			return true;
		}
		
		protected function goodSoundComplete(e:flash.events.Event):void{
			Starling.juggler.delayCall(setItems,2);
			SoundChannel(e.target).removeEventListener(flash.events.Event.SOUND_COMPLETE, goodSoundComplete);
		}
		
		protected function setItems():Boolean{
			_model.resetDistractors();
			_enabled = false;
			if(_counter>=_model.numItems){
				complete();
				done.dispatch();
				return false;
			}
			_counter++;
			return true;
		}
		
		protected function complete():void{
			
		}
		
		protected function onWhereIsPlayed(e:flash.events.Event):void{
			var sound:Sound = new Sound(new URLRequest("../assets/sounds/"+_whoIs.sound));
			var chanel:SoundChannel = sound.play(); 
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,function onSoundDone():void{
				_enabled = true
				chanel.removeEventListener(flash.events.Event.SOUND_COMPLETE,onSoundDone);
			});
		}
		
		public function destroy():void{
			removeEventListeners();
			removeChildren();
			_model.reset();
		}
	}
}