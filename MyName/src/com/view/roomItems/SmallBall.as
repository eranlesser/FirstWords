package com.view.roomItems
{
	import com.screens.Room;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class SmallBall extends PlayItem
	{
		
		private static const BALL_ELASTICITY : Number = 1.8;
		
		public function SmallBall(space:Space,cbType:CbType,xx:int,yy:int)
		{
			super(space,cbType,xx,yy);
			
		}
		
		override protected function createBody(cbType:CbType,xx:int,yy:int):void{
			_body = new Body( BodyType.DYNAMIC, new Vec2( xx, yy ) );
			_body.shapes.add( new Circle( _material.width/2, null, new Material( BALL_ELASTICITY ) ) );
			super.createBody(cbType,xx,yy);
			
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild(new Image(Room.atlas.getTexture("small_ball")) ) as Sprite;
			_material.pivotX = _material.width >> 1;
			_material.pivotY = _material.height >> 1;
		}
		
		
	}
}