package com.view
{
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.model.Session;
	import com.view.components.ImageItem;
	import com.view.components.ParticlesEffect;
	import com.view.utils.SoundPlayer;
	
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
	
	public class AbstractScreen extends Sprite implements IScreen
	{
		
		protected var _questionSound:		Sound;
		protected var _categorySound:		Sound;
		protected var _particlesEffect:		ParticlesEffect;
		protected var _model:				ScreenModel;
		protected var _enabled:				Boolean;
		protected var _categorySoundPlaying:Boolean=false;
		protected var _whoIs:				Item;
		protected var _guiLayer:			Sprite;
		protected var _screenLayer:			Sprite;
		protected var _soundManager:		SoundPlayer = new SoundPlayer();

		private var _wBirdNote:			Button;
		private var _goHome:			Signal = new Signal();
		private var _counter:			uint=0;
		private var _setItemsDelayer:	IAnimatable;
		
		[Embed(source="../../assets/whereBird.png")]
		private var wBird : 			Class;
		[Embed(source="../../assets/whereBird_note.png")]
		private var wBirdNote : 			Class;
		private var _done:Signal = new Signal();
		[Embed(source="../../assets/home/homeBtn.png")]
		private var homeBt : 			Class;
		
		public function AbstractScreen()
		{
			_screenLayer = new Sprite();
			addChild(_screenLayer);
			_guiLayer = new Sprite();
			addChild(_guiLayer);
			addNavigation();
		}

		public function get done():Signal
		{
			return _done;
		}

		public function get goHome():Signal
		{
			return _goHome;
		}
		
		public function get screenLayer():Sprite{
			return _screenLayer;
		}
		
		public function get model():ScreenModel{
			return _model;
		}
		
		public function set model(screenModel:ScreenModel):void{
			_counter=0;
			_model=screenModel;
			if(_model.sound == "where" || _model.sound == ""){
				_questionSound = _soundManager.getSound("../assets/sounds/","where.mp3")//new Sound(new URLRequest("../assets/sounds/where.mp3"));
			}else if(_model.sound == "who"){
				_questionSound = _soundManager.getSound("../assets/sounds","/who.mp3");
			}
			if(_model.categorySound!=""){
				_categorySound = _soundManager.getSound("../assets/sounds/",_model.categorySound);
				var chnl:SoundChannel = _categorySound.play();
				_categorySoundPlaying=true;
				chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,function onCatSoundDone(e:flash.events.Event):void{
					chnl.removeEventListener(flash.events.Event.SOUND_COMPLETE,onCatSoundDone);
					playWhoIsSound();
					_categorySoundPlaying=false;
				});
			}
			
			var whereBird:Button = new Button(Texture.fromBitmap(new wBird()));
			addChild(whereBird);
			_wBirdNote = new Button(Texture.fromBitmap(new wBirdNote()));
			addChild(_wBirdNote);
			_wBirdNote.visible = false;
			whereBird.x = Dimentions.WIDTH - whereBird.width//-2;
			_wBirdNote.x = Dimentions.WIDTH - _wBirdNote.width//-2;
			whereBird.addEventListener(starling.events.Event.TRIGGERED,function():void{
				if(_enabled){
					playWhoIsSound();
				}
			});
		}
		
		public function destroy():void{
			removeEventListeners();
			removeChildren();
			_model.reset();
			Starling.juggler.remove(_setItemsDelayer);
			_soundManager.stopSounds();
		}

		protected function addNavigation():void{
			var homeBut:Button = new Button( Texture.fromBitmap(new homeBt()) );
			_guiLayer.addChild(homeBut);
			homeBut.x=8;
			homeBut.y=8;
			homeBut.addEventListener(starling.events.Event.TRIGGERED, function():void{
				complete();
				goHome.dispatch()
			});
		}
		
		
		protected function playWhoIsSound():void{
			_wBirdNote.visible=true;
		}
		
		protected function onGoodClick():Boolean{ 
			if(!_enabled){
				return false;
			}
			var soundFile:String;
			if(Math.random()>0.2)
				soundFile = "goodA"+Math.ceil(Math.random()*4)+".mp3";
			else
				soundFile = "good"+Math.ceil(Math.random()*4)+".mp3";
			var goodSound:Sound = _soundManager.getSound("../assets/sounds/",soundFile);
			var channel:SoundChannel = goodSound.play();
			channel.addEventListener(flash.events.Event.SOUND_COMPLETE,goodSoundComplete);
			_enabled=false;
			if(_counter>=_model.numItems){
				closeCurtains();
			}
			Session.rightAnswer++;
			return true;
		}
		
		protected function closeCurtains():void{
			_particlesEffect = new ParticlesEffect();
			_particlesEffect.y = Dimentions.HEIGHT/2;
			_particlesEffect.x=(Dimentions.WIDTH-_particlesEffect.width)/2;
			_screenLayer.addChild(_particlesEffect);
			_particlesEffect.start("drug");
			
		}
		
		protected function goodSoundComplete(e:flash.events.Event):void{
			_setItemsDelayer = Starling.juggler.delayCall(setItems,2);
			SoundChannel(e.target).removeEventListener(flash.events.Event.SOUND_COMPLETE, goodSoundComplete);
		}
		
		protected function dispatchDone():void{
			done.dispatch();
			if(_particlesEffect){
				_particlesEffect.dispose();
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
			var sound:Sound = _soundManager.getSound("../assets/sounds/",_whoIs.sound);
			var chanel:SoundChannel = sound.play(); 
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
		}
		
		protected function onWhereSoundDone(e:flash.events.Event):void{
			var chanel:SoundChannel= e.target as SoundChannel;
			_enabled = true
			chanel.removeEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
			_wBirdNote.visible=false;
		}
		
	}
}