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
		
		protected var _categorySound:		Sound;
		protected var _particlesEffect:		ParticlesEffect;
		protected var _model:				ScreenModel;
		protected var _enabled:				Boolean;
		protected var _categorySoundPlaying:Boolean=false;
		protected var _whoIs:				Item;
		protected var _guiLayer:			Sprite;
		protected var _screenLayer:			Sprite;
		protected var _soundManager:		SoundPlayer = new SoundPlayer();

		protected var _wBirdNote:			Button;
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
		
		protected function  onDistractorTouch(imageItem:ImageItem):void{
			if(!_enabled){
				return;
			}
			var sound:Sound;
			if(_model.distractorType == ""){
				sound = _soundManager.getSound("../assets/narration/",imageItem.aSound);
			}else{
				sound = _soundManager.getSound("../assets/narration/",_whoIs.qSound);
			}	
			var chnl:SoundChannel = sound.play();
			chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,function onChnl():void{
				chnl.removeEventListener(flash.events.Event.SOUND_COMPLETE,onChnl);
				if(imageItem.enhanceSound!=""){
					var hSound:Sound = new Sound(new URLRequest("../assets/sounds/effects/"+imageItem.enhanceSound));
					hSound.play();
				}
				_enabled=true;
			});
			_enabled = false;
		}
		
		public function set model(screenModel:ScreenModel):void{
			_counter=0;
			_model=screenModel;
			if(_model.categorySound!=""){
				_categorySound = _soundManager.getSound("../assets/narration/",_model.folder +"/"+ _model.categorySound);
				var chnl:SoundChannel = _categorySound.play();
				_categorySoundPlaying=true;
				chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,onCatSoundDone);
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
		
		private function onCatSoundDone(e:flash.events.Event):void{
			var chnl:SoundChannel = e.target as SoundChannel;
			chnl.removeEventListener(flash.events.Event.SOUND_COMPLETE,onCatSoundDone);
			Starling.juggler.delayCall(playWhoIsSound,1);
			_categorySoundPlaying=false;
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
			var sound:Sound = _soundManager.getSound("../assets/narration/",_whoIs.qSound);
			var chanel:SoundChannel = sound.play(); 
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
			_enabled=false;
		}
		private var _goodFeedBack:String;
		private function get goodFeedBack():String{
			var soundFile:String;
			//soundFile = 192+Math.floor(Math.random()*19)+".mp3";
			soundFile = "/good/"+int(1+Math.floor(Math.random()*19.8))+".mp3";
			if(soundFile==_goodFeedBack){
				soundFile=goodFeedBack;
			}
			_goodFeedBack = soundFile;
			return soundFile;
		}
		private function get goodLastFeedBack():String{
			var soundFile:String;
			soundFile = "/good/"+int(20+Math.floor(Math.random()*6.8))+".mp3";
			if(soundFile==_goodFeedBack){
				soundFile=goodFeedBack;
			}
			_goodFeedBack = soundFile;
			return soundFile;
		}
		
		protected function onGoodClick():Boolean{ 
			if(!_enabled){
				return false;
			}
			var goodSound:Sound;
			if(_counter>=_model.numItems){
				closeCurtains();
				goodSound = _soundManager.getSound("../assets/narration/",goodLastFeedBack);
			}else{
				goodSound = _soundManager.getSound("../assets/narration/",goodFeedBack);
			}
			var channel:SoundChannel = goodSound.play();
			channel.addEventListener(flash.events.Event.SOUND_COMPLETE,goodSoundComplete);
			_enabled=false;
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
		
		
		protected function onWhereSoundDone(e:flash.events.Event):void{
			var chanel:SoundChannel= e.target as SoundChannel;
			_enabled = true
			chanel.removeEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
			_wBirdNote.visible=false;
		}
		
	}
}