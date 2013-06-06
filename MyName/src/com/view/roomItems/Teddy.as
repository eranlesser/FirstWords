package com.view.roomItems
{
	import com.screens.Room;
	import com.utils.filters.GlowFilter;
	
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Teddy extends PlayItem
	{
		private var _assetName:String;
		private var _hgt:uint;
		public function Teddy(space:Space,cbType:CbType,x:int,assetName:String,hgt:uint):void{
			_assetName = assetName;
			_hgt=hgt;
			super(space,cbType,x,0);
			
			
		}
		
		override protected function createBody(cbType:CbType,xx:int,yy:int):void{
			_body = new Body( BodyType.DYNAMIC, new Vec2( xx, yy ) );
			_body.shapes.add( new Polygon( Polygon.rect(28,0,8,_hgt), Material.wood() ) );
			_body.shapes.add( new Polygon( Polygon.rect(0,_hgt,80,90), Material.wood() ) );
//			var s:Polygon;
//			s = new Polygon(
//				[   Vec2.weak(0,5)   ,  Vec2.weak(0,10)   ,  Vec2.weak(100,10)   ,  Vec2.weak(100,5)   ]
//				
//			);
//			s.body = _body;
//			s.fluidEnabled = false;
//			
//			s = new Polygon(
//				[   Vec2.weak(80,0)   ,  Vec2.weak(80,15)   ,  Vec2.weak(100,0)   ,  Vec2.weak(100,15)   ]
//			);
//			s.body = _body;
//			s.fluidEnabled = false;
			_body.mass=12;
			super.createBody(cbType,xx,yy);
			
		}
		
		public function get body():Body{
			return _body;
		}
		
		override protected function createMaterial():void{
			_material = new Sprite();
			_material.addChild(new Image(Room.atlas.getTexture(_assetName)));
			_material.filter = new GlowFilter(0xFFFFFF);
		}
		override protected function updateGraphics( body : Body ) : void
		{
			body.userData.graphic.x = body.position.x;
			body.userData.graphic.y = body.position.y;
			body.userData.graphic.rotation = body.rotation;
		}
		
		
		
	}
}