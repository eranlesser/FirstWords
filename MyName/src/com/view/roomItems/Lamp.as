package com.view.roomItems
{
	
	import com.screens.Room;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	public class Lamp extends PlayItem{
		private var _lamp:Button;
		function Lamp(space:Space,cbType:CbType):void{
			super(space,cbType,453,0);
			
			
		}
		
		override protected function createBody(cbType:CbType,xx:int,yy:int):void{
			_body = new Body( BodyType.STATIC, new Vec2( xx, yy ) );
			//_body.shapes.add( new Polygon( Polygon.rect(0,0,_material.width,_material.height), Material.wood() ) );
			var s:Polygon;
			s = new Polygon(
				[   Vec2.weak(-0.5,81)   ,  Vec2.weak(63,156.5)   ,  Vec2.weak(152.5,129)   ,  Vec2.weak(110.5,59)   ,  Vec2.weak(98,51.5)   ]);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(110.5,59)   ,  Vec2.weak(119,-0.5)   ,  Vec2.weak(118,-0.5)   ,  Vec2.weak(98,51.5)   ]);
			s.body = _body;
			s.fluidEnabled = false;
			super.createBody(cbType,xx,yy);
			
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild(new Image(Room.atlas.getTexture("lamp-full-light-on")));
			_lamp = new Button(Room.atlas.getTexture("lamp_on"));
			_lamp.x=23;
			_lamp.y=93;
			_lamp.addEventListener(Event.TRIGGERED,toggleLight);
			_material.addChild(_lamp);
			_lamp.alpha=0;
		}
		public var lightChanged:Signal = new Signal();
		private function toggleLight():void{
			if(_lamp.alpha==0){
				_lamp.alpha=1;
			}else{
				_lamp.alpha=0;
			}
			lightChanged.dispatch(_lamp.alpha);
		}
		
		
	}
}