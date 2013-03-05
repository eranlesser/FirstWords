package com.view.playRoom
{
	import com.Assets;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class BasketBall extends PlayItem
	{
		[Embed(source="../../../assets/basketball.png")]
		private var basketball : Class;
		
		private static const BALL_RADIUS : Number = 51.5; // TODO make dynamic
		private static const BALL_ELASTICITY : Number = 1.5;
		
		public function BasketBall(space:Space,updateFunction:Function)
		{
			super(space,updateFunction);
			
		}
		
		override protected function createBody(updateFunction:Function):void{
			_body = new Body( BodyType.DYNAMIC, new Vec2( 500, 100 ) );
			_body.shapes.add( new Circle( BALL_RADIUS, null, new Material( BALL_ELASTICITY ) ) );
			super.createBody(updateFunction);
			
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild( Image.fromBitmap( new basketball() ) ) as Sprite;
			_material.pivotX = _material.width >> 1;
			_material.pivotY = _material.height >> 1;
		}
		
		
	}
}