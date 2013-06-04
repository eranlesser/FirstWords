package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.view.components.Counter;
	import com.view.utils.SoundPlayer;
	
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Rain extends AbstractScreen
	{
	[Embed(source="../../assets/rain/atlas.xml", mimeType="application/octet-stream")]
	private var seed_xml:Class;
	[Embed(source="../../assets/rain/atlas.png")]
	private var seed:Class;
	
	[Embed(source = "../../assets/rain/cloud.png")] 
	private var cloud:Class;
	
	[Embed(source = "../../assets/rain/rain.png")] 
	private var rain:Class;
	
		private var _cloud:Image;
		private var _rain:Image;
		private var _seed:Image;
		private var _atlas:TextureAtlas;
		private var _index:uint=1;
		private var _chnl:SoundChannel;
		private var _counter:Counter = new Counter();
		public function Rain()
		{
			_cloud = new Image(Texture.fromBitmap(new cloud()));
			addChild(_cloud);
			_cloud.x=(Dimentions.WIDTH-_cloud.width)/2;
			_cloud.y=20;//(Dimentions.HEIGHT-_cloud.height)/4;
			_cloud.addEventListener(TouchEvent.TOUCH,onCloudTouch);
			_rain = new Image(Texture.fromBitmap(new rain()));
			addChild(_rain);
			_rain.x=(Dimentions.WIDTH-_rain.width)/2;
			_rain.y=_cloud.y+_cloud.height;
			var xml:XML = (new XML(new seed_xml()));
			_atlas = new TextureAtlas(Texture.fromBitmap(new seed()),xml);
			_seed = new Image(_atlas.getTexture("flower1"));
			addChild(_seed);
			_seed.x = (Dimentions.WIDTH-_seed.width)/2;
			_seed.y=Dimentions.HEIGHT-_seed.height-20;
			_rain.visible=false;
			_enabled=true;
		}
		
		private function onCloudTouch(e:TouchEvent):void{
			if(!_enabled||_categorySoundPlaying){
				return;
			}
			if(e.getTouch(stage) &&e.getTouch(stage).phase == TouchPhase.BEGAN){
				var sound:Sound = new Sound(new URLRequest("../../../assets/sounds/heb/rain.mp3"));
				_chnl = sound.play();
				_rain.visible = true;
				 _enabled=false;
				 Starling.juggler.delayCall(progress,1);
				//progress();
			}
			//if(e.getTouch(stage) &&e.getTouch(stage).phase == TouchPhase.ENDED){
		}
		
		private function onTimer():void{
			progress();
		}
		override protected function playWhoIsSound():void{//don't show bird note
		}
		
		
		private function progress():void{
			if(_index==10){
				_index=10;
				_counter.progress();
				_rain.visible=false;
				Starling.juggler.delayCall(function end():void{
					var soundPlayer:SoundPlayer = new SoundPlayer();
					soundPlayer.getSound("../../../assets/narration","107.mp3").play();
					Starling.juggler.delayCall(dispatchDone,2.5);
				},1);
				closeCurtains();
				_enabled=false;
				if(_chnl){
					_chnl.stop();
				}
				return;
			}
			_rain.visible = false;
			_counter.progress();
			_chnl.stop();
			_index++;
			removeChild(_seed);
			var seedStr:String = ("flower"+Math.min(_index,9)).toString();
			_seed = new Image(_atlas.getTexture(seedStr));
			addChild(_seed);
			if(_index>9){
				_seed.scaleY = 1.1;
			}
			if(_index>10){
				_seed.scaleY = 1.2;
			}
			_seed.x = (Dimentions.WIDTH-_seed.width)/2;
			_seed.y=Dimentions.HEIGHT-_seed.height-20;
			_enabled=true;
		}
		
		
	}
}