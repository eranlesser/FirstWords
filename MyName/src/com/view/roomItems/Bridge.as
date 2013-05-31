package com.view.roomItems
{
	import com.screens.Room;
	
	import flash.display.Bitmap;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Bridge extends PlayItem
	{
		
		
		public function Bridge(space:Space,cbType:CbType,xx:int,yy:int)
		{
			super(space,cbType,xx,yy);
			
		}
		
		override protected function createBody(cbType:CbType,xx:int,yy:int):void{
			_body = new Body( BodyType.DYNAMIC, new Vec2( xx, yy ) );
			var s:Polygon;
			s = new Polygon(
				[   Vec2.weak(8,15)   ,  Vec2.weak(25,24)   ,  Vec2.weak(24,5)   ]
			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(105,91)   ,  Vec2.weak(77,91)   ,  Vec2.weak(56,114)   ,  Vec2.weak(96,112)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(74,40)   ,  Vec2.weak(29,41)   ,  Vec2.weak(41,60)   ,  Vec2.weak(77,91)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(56,114)   ,  Vec2.weak(77,91)   ,  Vec2.weak(41,60)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(13,114)   ,  Vec2.weak(38,109)   ,  Vec2.weak(41,60)   ,  Vec2.weak(29,41)   ,  Vec2.weak(13,70)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(13,70)   ,  Vec2.weak(29,41)   ,  Vec2.weak(25,24)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			s = new Polygon(
				[   Vec2.weak(24,5)   ,  Vec2.weak(25,24)   ,  Vec2.weak(29,41)   ]			);
			s.body = _body;
			s.fluidEnabled = false;
			
			super.createBody(cbType,xx,yy);
			
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild( new Image(Room.atlas.getTexture("bridge")) ) as Sprite;
			//_material.pivotX = _material.width >> 1;
			//_material.pivotY = _material.height >> 1;
		}
		
		
	}
}