package com.view
{
	import com.Assets;
	import com.Dimentions;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class PlayRoom extends Sprite
	{
		private var _space:Space;
		public function PlayRoom()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			// TODO Auto Generated method stub
			_space = new Space(new Vec2(0,3000));
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(0,Dimentions.HEIGHT-250,Dimentions.WIDTH,50)));
			floor.space = _space;
			addBall();
			
		}
		
		private function addBall():void{
			var ball:Body = new Body(BodyType.DYNAMIC,new Vec2(400,300));
			ball.shapes.add(new Circle(80,null,new Material(40)));
			ball.space = _space;
			var ballSprite:Sprite = new Sprite();
			ballSprite.addChild(new Image(Assets.getAtlas("toys").getTexture("ball1")));
			ball.userData.graphic = ballSprite;
			ball.userData.graphicUpdate = onUpdate;
			addChild(ballSprite);
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame)
			//ball.graphic = new Sprite();
			
		}
		
		private function onEnterFrame(e:Event):void
		{
			// TODO Auto Generated method stub
			_space.step(1/60);
			for (var i:int = 0; i < _space.liveBodies.length; i++) {
				var body:Body = _space.liveBodies.at(i);
				if (body.userData.graphicUpdate) {
					body.userData.graphicUpdate(body);
				}
			}
		}
		
		private function onUpdate(b:Body):void{
			b.userData.graphic.x = b.position.x;
			b.userData.graphic.y = b.position.y;
			//b.userData.graphic.rotation = b.position.angle;
		}
	}
}