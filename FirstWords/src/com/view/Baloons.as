package com.view
{
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.view.playRoom.Baloon;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import org.osflash.signals.Signal;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Baloons extends AbstractScreen
	{
		private var _ballons:Vector.<ColoredBaloon>;
		private var _playIndex:uint=0;
		private var _space:Space;
		private static const GRAVITY_X : Number = 0;
		private static const GRAVITY_Y : Number = 3000;
		private static const STEP_TIME : Number = 0.01;
		[Embed(source="../../assets/balloons/baloonsBg.jpg")]
		private var bg : Class;
		public function Baloons()
		{
			super();
			_screenLayer.addChild(new Image(Texture.fromBitmap(new bg())));
			_ballons = new Vector.<ColoredBaloon>();
			createSpace();
			createFloor();
			init();
		}
		
		private function createSpace():void
		{
			_space = new Space( new Vec2( GRAVITY_X, GRAVITY_Y ) );
			listenForEnterFrame();
		}
		
		public static const WALL_WIDTH:uint=22;
		private function createFloor():void
		{
			const floor:Body = new Body( BodyType.STATIC );
			
			// what are all these things?
			floor.shapes.add( new Polygon( Polygon.rect( 0, 0, 1024, 22 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, 0, 60, 768 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 708, 0, 22, 768 ) ) );
			
			floor.space = _space;
		}
		

		
		private function listenForEnterFrame() : void
		{
			var _nativeStage:Stage = Starling.current.nativeStage;
			addEventListener( starling.events.Event.ENTER_FRAME, function( event : starling.events.Event ) : void
			{
				//_hand.anchor1.setxy( _nativeStage.mouseX, _nativeStage.mouseY );
				_space.step( STEP_TIME );
				for (var i:int = 0; i < _space.liveBodies.length; i++) {
					var body:Body = _space.liveBodies.at(i);
					if (body.userData.graphicUpdate) {
						body.userData.graphicUpdate(body);
					}
				}
			});
			
		}
		
		
		
		private function init():void{
			var baloon:ColoredBaloon = new ColoredBaloon("red",_space,new CbType(),300,300);
			addChild(baloon.material);
			var blubaloon:ColoredBaloon = new ColoredBaloon("blu",_space,new CbType(),600,300);
			addChild(blubaloon.material);
			var greenbaloon:ColoredBaloon = new ColoredBaloon("green",_space,new CbType(),450,300);
			addChild(greenbaloon.material);
			var yellowbaloon:ColoredBaloon = new ColoredBaloon("yellow",_space,new CbType(),750,300);
			addChild(yellowbaloon.material);
			
			baloon.poped.add(setWhoIs);
			blubaloon.poped.add(setWhoIs);
			greenbaloon.poped.add(setWhoIs);
			yellowbaloon.poped.add(onLast);
			
			_ballons.push(baloon);
			_ballons.push(blubaloon);
			_ballons.push(greenbaloon);
			_ballons.push(yellowbaloon);
			
			
			setItems();
			
		}
		
		override public function set model(screenModel:ScreenModel):void{
			super.model = screenModel;
			playWhoIsSound();
		}
		
		
		private function onLast():void{
			closeCurtains();
			Starling.juggler.delayCall(super.dispatchDone,2);
		}
		
		override protected function playWhoIsSound():void{
			super.playWhoIsSound();
			var chanel:SoundChannel = _questionSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
			_enabled = false;
		}
		
		
		override protected function onWhereIsPlayed(e:flash.events.Event):void{
			var sound:Sound = _soundManager.getSound("../assets/sounds/",_ballons[_playIndex].colorSoundFile);
			var chanel:SoundChannel = sound.play(); 
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereSoundDone);
			_enabled=true;
		}
		
		override protected function setItems():Boolean{
			setWhoIs();
			return true;
		}
		
		private function setWhoIs():void{
			_ballons[_playIndex].isWho = true;
			_playIndex++;
		}
		
	}
}
import com.Dimentions;
import com.view.components.ParticlesEffect;
import com.view.playRoom.PlayItem;

import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;

import nape.callbacks.CbType;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.space.Space;

import org.osflash.signals.Signal;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;


class ColoredBaloon extends PlayItem{
	[Embed(source="../../assets/balloons/blu.png")]
	private var bluBln : Class;
	[Embed(source="../../assets/balloons/green.png")]
	private var greenBln : Class;
	[Embed(source="../../assets/balloons/orangeBln.png")]
	private var orangeBln : Class;
	[Embed(source="../../assets/balloons/red.png")]
	private var redBln : Class;
	[Embed(source="../../assets/balloons/turkuizeBln.png")]
	private var turkuizeBln : Class;
	[Embed(source="../../assets/balloons/yellow.png")]
	private var yellowBln : Class;
	
	private var _color:String;
	private var _sound:Sound;
	private var _isWho:Boolean=false;
	private var _btnmp:Image;
	public var poped:Signal = new Signal();
	function ColoredBaloon(clr:String,space:Space, cbType:CbType, xx:int, yy:int){
		_btnmp = getBaloon(clr);
		super(space, cbType, xx, yy);
		_sound = new Sound(new URLRequest("../../assets/sounds/playroom/pop.mp3"));
		//_clrSound = new Sound(new URLRequest("../../assets/sounds/colors/"+clr+"_baloon.mp3"));
		_color = clr;
		var cnl:SoundChannel = _sound.play();
		cnl.stop();
		//addChild(img);
		//addEventListener(TouchEvent.TOUCH,onTouch);
	}
	
	public function get colorSoundFile():String{
		return _color+".mp3";
	}
	
	public function set isWho(value:Boolean):void
	{
		_isWho = value;
	}

	private function getBaloon(clr:String):Image{
		var img:Image;
		switch(clr){
			case "blu":
				img = new Image(Texture.fromBitmap(new bluBln()));
			break;
			case "green":
				img = new Image(Texture.fromBitmap(new greenBln()));
			break;
			case "red":
				img = new Image(Texture.fromBitmap(new redBln()));
			break;
			case "yellow":
				img = new Image(Texture.fromBitmap(new yellowBln()));
			break;
		}
		return img;
		
	}
	
	override protected function createBody(cbType:CbType,xx:int,yy:int):void{
		_body = new Body( BodyType.DYNAMIC, new Vec2( xx, yy ) );
		_body.shapes.add( new Polygon( Polygon.rect(0,0,_material.width,_material.height), Material.rubber() ) );
		_body.gravMass = -(0.5)+0.2*Math.random();
		super.createBody(cbType,xx,yy);
		
	}
	
		
	public function get body():Body{
		return _body;
	}
	
	override protected function createMaterial():void{
		_material = new Sprite();
		
		_material.addChild( ( _btnmp ) ) as Sprite;
		_sound = new Sound(new URLRequest("../../../assets/sounds/playroom/pop.mp3"));
		var cnl:SoundChannel = _sound.play();
		cnl.stop();
		//Starling.juggler.delayCall(function():void{
		_material.addEventListener(TouchEvent.TOUCH,onTouch);
		//},2);
		//_material.pivotX = _material.width >> 1;
		//_material.pivotY = _material.height >> 1;
	}
	
	
	public function pop():void{
		
		var particlesEffect:ParticlesEffect;
		particlesEffect = new ParticlesEffect();
		particlesEffect.width=_material.width/10;
		particlesEffect.height=_material.height/10;
		particlesEffect.x=_material.x+_material.width/2;
		particlesEffect.y=_material.y+_material.height/2;
		_material.parent.addChild(particlesEffect);
		particlesEffect.start("jfish");
		_sound.play();
		Starling.juggler.delayCall(removeParticles,0.3,particlesEffect);
		_material.removeFromParent(true);
		_space.bodies.remove(_body);
	}
	
	private function removeParticles(particlesEffect:ParticlesEffect):void{
		particlesEffect.stop();
		//particlesEffect.dispose();
		particlesEffect.parent.removeChild(particlesEffect);
		poped.dispatch();
	}
	
	private function onTouch(e:TouchEvent):void{
		if(!_isWho ){
			return;
		}
		if(e.getTouch(_material.stage).phase == TouchPhase.BEGAN){
			_material.removeEventListener(TouchEvent.TOUCH,onTouch);
			pop();
		}
	}
		private function playColor():void{
		//_clrSound.play();
	}
}