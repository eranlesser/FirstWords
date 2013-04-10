package com.view
{
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.view.components.ImageItem;
	import com.view.components.ParticlesEffect;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class AbstractScreen extends Sprite
	{
		
		protected var _questionSound:		Sound;
		protected var _categorySound:		Sound;
		public var goHome:Signal = new Signal();
		public var done:Signal = new Signal();
		[Embed(source="../../assets/home/homeBtn.png")]
		private var homeBt : 			Class;
		protected var _particlesEffect:	ParticlesEffect;
		protected var _model:			ScreenModel;
		protected var _enabled:			Boolean;
		protected var _categorySoundPlaying:	Boolean=false;
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
			if(_model.sound == "where" || _model.sound == ""){
				_questionSound = new Sound(new URLRequest("../assets/sounds/where.mp3"));
			}else if(_model.sound == "who"){
				_questionSound = new Sound(new URLRequest("../assets/sounds/who.mp3"));
			}
			if(_model.categorySound!=""){
				_categorySound = new Sound(new URLRequest("../assets/sounds/"+_model.categorySound));
				var chnl:SoundChannel = _categorySound.play();
				_categorySoundPlaying=true;
				chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,function onCatSoundDone(e:flash.events.Event):void{
					chnl.removeEventListener(flash.events.Event.SOUND_COMPLETE,onCatSoundDone);
					playWhoIsSound();
					_categorySoundPlaying=false;
				});
			}
		}
		
		protected function playWhoIsSound():void{
			
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
			if(_counter>=_model.numItems){
				closeCurtains();
			}
			return true;
		}
		protected function closeCurtains():void{
			_particlesEffect = new ParticlesEffect();
			_particlesEffect.y = Dimentions.HEIGHT/2;
			_particlesEffect.x=(Dimentions.WIDTH-_particlesEffect.width)/2;
			_screenLayer.addChild(_particlesEffect);
			_particlesEffect.start("drug");
			
		}
		private var _setItemsDelayer:IAnimatable;
		protected function goodSoundComplete(e:flash.events.Event):void{
			_setItemsDelayer = Starling.juggler.delayCall(setItems,2);
			SoundChannel(e.target).removeEventListener(flash.events.Event.SOUND_COMPLETE, goodSoundComplete);
		}
		
		protected function dispatchDone():void{
			done.dispatch();
			if(_particlesEffect){
				_particlesEffect.stop();
				removeChild(_particlesEffect);
			}
		}
		
		protected function setItems():Boolean{
			_model.resetDistractors();
			_enabled = false;
			if(_counter>=_model.numItems){
				complete();
				dispatchDone();
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
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
		}
		
		protected function onWhereSoundDone(e:flash.events.Event):void{
			var chanel:SoundChannel= e.target as SoundChannel;
			_enabled = true
			chanel.removeEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
			
		}
		
		public function destroy():void{
			removeEventListeners();
			removeChildren();
			_model.reset();
			Starling.juggler.remove(_setItemsDelayer);
		}
	}
}