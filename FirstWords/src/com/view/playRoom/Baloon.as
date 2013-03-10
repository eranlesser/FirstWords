package com.view.playRoom
{
	import com.view.components.ParticlesEffect;
	
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
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Baloon extends PlayItem
	{
		[Embed(source="../../../assets/playroom/baloon.jpg")]
		private var baloon : Class;
		private var _sound:Sound;
		public function Baloon(space:Space, cbType:CbType, xx:int, yy:int)
		{
			super(space, cbType, xx, yy);
		}
		
		override protected function createBody(cbType:CbType,xx:int,yy:int):void{
			_body = new Body( BodyType.DYNAMIC, new Vec2( xx, yy ) );
			_body.shapes.add( new Polygon( Polygon.rect(0,0,_material.width,_material.height), Material.wood() ) );
			_body.gravMass = -0.1;
			super.createBody(cbType,xx,yy);
			
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild( Image.fromBitmap( new baloon() ) ) as Sprite;
			_material.addEventListener(TouchEvent.TOUCH,onTouch);
			_sound = new Sound(new URLRequest("../../../assets/sounds/playroom/pop.mp3"));
			var cnl:SoundChannel = _sound.play();
			cnl.stop();
			
			//_material.pivotX = _material.width >> 1;
			//_material.pivotY = _material.height >> 1;
		}
		
		private function onTouch(e:TouchEvent):void{
			if(e.getTouch(_material.stage).phase == TouchPhase.BEGAN){
				_material.removeEventListener(TouchEvent.TOUCH,onTouch);
				var _particlesEffect:ParticlesEffect;
				_particlesEffect = new ParticlesEffect();
				_particlesEffect.width=_material.width/10;
				_particlesEffect.height=_material.height/10;
				_particlesEffect.x=_material.x+_material.width/2;
				_particlesEffect.y=_material.y+_material.height/2;
				_material.parent.addChild(_particlesEffect);
				_particlesEffect.start("jfish");
				_sound.play();
				Starling.juggler.delayCall(function removeParticles():void{
					_particlesEffect.stop();
					_particlesEffect.removeFromParent(true)
				},0.3);
				_material.removeFromParent(true);
				_space.bodies.remove(_body);
			}
		}
	}
}