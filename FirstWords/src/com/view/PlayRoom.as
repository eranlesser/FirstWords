package com.view
{
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.view.playRoom.Baloon;
	import com.view.playRoom.BasketBall;
	import com.view.playRoom.Cube;
	import com.view.playRoom.FlyBaloon;
	import com.view.playRoom.Menu;
	import com.view.playRoom.Plane;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.dynamics.Arbiter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class PlayRoom extends AbstractScreen
	{
		private static const GRAVITY_X : Number = 0;
		private static const GRAVITY_Y : Number = 3000;
		
		private static const STEP_TIME : Number = 0.01;
		private var _room:Sprite;
		
		[Embed(source="../../assets/playroom/bg.png")]
		private var Background:Class;
		[Embed(source="../../assets/playroom/play_room_bed.png")]
		private var bed:Class;
		[Embed(source="../../assets/playroom/play_room_box.png")]
		private var box:Class;
		[Embed(source="../../assets/playroom/play_room_lamp.png")]
		private var lamp:Class;
		[Embed(source="../../assets/playroom/play_room_light.png")]
		private var light:Class;
		[Embed(source="../../assets/playroom/play_room_shelf.png")]
		private var shelf:Class;
		[Embed(source="../../assets/playroom/play_room_leftBoard.png")]
		private var leftBoard:Class;
		[Embed(source="../../assets/playroom/play_room_rightBoard.png")]
		private var rightBoard:Class;
		[Embed(source="../../assets/playroom/play_room_win.png")]
		private var win:Class;
		[Embed(source="../../assets/playroom/play_room_winBg.png")]
		private var winBg:Class;
		[Embed(source="../../assets/nextIdle.png")]
		private var arrow:Class;
		[Embed(source="../../assets/nextHint.png")]
		private var arrowHint:Class;
		
		private var _nativeStage : Stage;
		private var _space : Space;
		private var _hand : PivotJoint;
		
		private var _ballCollisionType:CbType = new CbType();
		private var _cubeCollisionType:CbType = new CbType();
		private var _floorCollisionType:CbType = new CbType();
		private var _menu:Menu;
		private var _delayer:DelayedCall;
		private var _arrowHint:Button;
		public function PlayRoom()
		{
			_delayer = Starling.juggler.delayCall(showHint,20);
			_delayer.repeatCount = 1;
			
		}
		
		private function showHint():void{
			var counter:uint = 0;
			var hinter:DelayedCall = Starling.juggler.delayCall(
				function onShowHint():void{
					_arrowHint.visible = !_arrowHint.visible;
					counter++;
					if(counter==10){
						//done.dispatch();
					}
				},0.5
				
			);
			hinter.repeatCount=20;
		}
		
		override public function get diposable():Boolean{
			return false;
		}
		
		private function init() : void
		{
			if(_menu){
				_menu.visible = true;
				return; // inited
			}
			_nativeStage = Starling.current.nativeStage;
			
			addBackground();
			createSpace();
			createHand();
			listenForMouseDown();
			listenForMouseUp();
			listenForEnterFrame();
			useAccelerometer();
			_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_floorCollisionType,_cubeCollisionType,ballToCube));
			_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_ballCollisionType,_cubeCollisionType,ballToFloor));
			_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_ballCollisionType,_floorCollisionType,ballToFloor));
			
			_menu = new Menu();
			_screenLayer.addChild(_menu);
			_menu.x = (Dimentions.WIDTH - _menu.width)/2;
			_menu.itemDropped.add(onMenuItemDropped);
			
			var arrow:Button = new Button(Texture.fromBitmap(new arrow()));
			addChild(arrow);
			arrow.x = Dimentions.WIDTH - arrow.width-8;
			arrow.y=4;
			arrow.addEventListener(Event.TRIGGERED,function():void{done.dispatch()});
			_arrowHint = new Button(Texture.fromBitmap(new arrowHint()));
			addChild(_arrowHint);
			_arrowHint.x = Dimentions.WIDTH - _arrowHint.width-8;
			_arrowHint.y=4;
			_arrowHint.addEventListener(Event.TRIGGERED,function():void{done.dispatch()});
			_arrowHint.visible = false;
//			var tmr:Timer = new Timer(20000,1);
//			tmr.addEventListener(TimerEvent.TIMER_COMPLETE,function onComplete(e:TimerEvent):void{
//				done.dispatch()
//			});
			createFloor();
			//tmr.start();
		}
		
		override public function set model(screenModel:ScreenModel):void{
			init();
			_menu.model = screenModel;
		}
		
		private function onMenuItemDropped(x:int,y:int,id:String):void{
			switch(id){
				case "ball":
					var ball:BasketBall = new BasketBall(_space,_ballCollisionType,x,y);
					_room.addChild( ball.material);
					break;
				case "cubes":
					_room.addChild(new Cube(_space,_cubeCollisionType,x-40,y,1).material);
					_room.addChild(new Cube(_space,_cubeCollisionType,x+40,y,2).material);
					_room.addChild(new Cube(_space,_cubeCollisionType,x,y-80,3).material);
					break;
				case "bluBln":
					var baloon:Baloon = new Baloon(_space,null,x,y);
					_room.addChild(baloon.material);
					baloon.material.addEventListener(TouchEvent.TOUCH,function onTouch(e:TouchEvent):void{
						if(baloon.material.stage == null){
							_hand.active = false;
						}
					});
					break;
				case "fly_baloon":
					_room.addChild(new FlyBaloon(_space,_cubeCollisionType,x,y).material);
					break;
				case "plane":
					_room.addChild(new Plane(_space,_cubeCollisionType,x,y).material);
					break;
			}
			
			//_menu.visible = false;
		}
		
		private function ballToCube(collision:InteractionCallback):void {
			collision.arbiters.foreach(function(arb:Arbiter):void {
				if(Math.abs(arb.collisionArbiter.body2.velocity.x)>300 || Math.abs(arb.collisionArbiter.body2.velocity.y)>120){
					new Sound(new URLRequest("../../assets/sounds/playroom/cube.mp3")).play();
				}
			});
		}
		private function ballToFloor(collision:InteractionCallback):void {
			collision.arbiters.foreach(function(arb:Arbiter):void {
				if(Math.abs(arb.collisionArbiter.body2.velocity.x)>400 || Math.abs(arb.collisionArbiter.body2.velocity.y)>400){
					new Sound(new URLRequest("../../assets/sounds/playroom/boing.mp3")).play();
				}
			});
			
		}
		
		private function addBackground() : void
		{
			drawDarkBg();
			_room = new Sprite();
			_room.addChild( Image.fromBitmap( new Background() ) );
//			_room.addChild( Image.fromBitmap( new bed() ) );
//			_room.addChild( Image.fromBitmap( new shelf() ) );
//			_room.addChild( Image.fromBitmap( new lamp() ) );
//			_room.addChild( Image.fromBitmap( new light() ) );
//			_room.addChild( Image.fromBitmap( new leftBoard() ) );
//			_room.addChild( Image.fromBitmap( new winBg() ) );
//			_room.addChild( Image.fromBitmap( new win() ) );
//			_room.addChild( Image.fromBitmap( new box() ) );
			//var rightBoard:Image = addChild( Image.fromBitmap( new rightBoard() ) ) as Image;
			_screenLayer.addChild(_room);
			//_room.alpha=0.1;
			//rightBoard.addEventListener(TouchEvent.TOUCH,onRightBoardTouch);
		}
		
		private function drawDarkBg():void{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0x333333);
			shp.graphics.drawRect(0,0,Dimentions.WIDTH,Dimentions.HEIGHT);
			shp.graphics.endFill();
			var bmp:BitmapData = new BitmapData(Dimentions.WIDTH,Dimentions.HEIGHT,true,0x333333);
			bmp.draw(shp)
			var txture:Texture = Texture.fromBitmapData(bmp);
			var img:Image = new Image(txture);
			_screenLayer.addChild(img);
		}
		
		private function onRightBoardTouch(e:TouchEvent):void{
			var touch:Touch = e.getTouch(stage);
			if(touch.phase == TouchPhase.MOVED){
				var shp:Shape = new Shape();
				shp.graphics.beginFill(0x333333);
				shp.graphics.drawCircle(0,0,2);
				shp.graphics.endFill();
				var bmp:BitmapData = new BitmapData(4,4,true,0x333333);
				bmp.draw(shp)
				var txture:Texture = Texture.fromBitmapData(bmp);
				var img:Image = new Image(txture);
				_screenLayer.addChild(img);
				img.x=touch.globalX;
				img.y=touch.globalY;
			}
		}
		
		private function createSpace():void
		{
			_space = new Space( new Vec2( GRAVITY_X, GRAVITY_Y ) );
		}
		
		private function createFloor():void
		{
			const floor:Body = new Body( BodyType.STATIC );
			
			// what are all these things?
			floor.shapes.add( new Polygon( Polygon.rect( 0, 768 - Menu.HEIGHT - 2-30, 1024, 200 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 1024-22, 0, 22, 768 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, -20, 1024, 22 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, 0, 22, 768 ) ) );
			
			floor.space = _space;
			floor.cbTypes.add(_floorCollisionType);
		}
		
		private function createHand():void
		{
			_hand = new PivotJoint( _space.world, null, new Vec2(), new Vec2() );
			_hand.active = false;
			_hand.stiff = false;
			_hand.space = _space;
		}
		
		private function listenForMouseDown():void
		{
			_nativeStage.addEventListener( MouseEvent.MOUSE_DOWN, function( event : MouseEvent ) : void
			{
				var mousePoint : Vec2 = new Vec2( event.stageX, event.stageY );
				var bodies : BodyList = _space.bodiesUnderPoint( mousePoint );
				
				if ( bodies.length > 0 )
				{
					var body : Body = bodies.shift();
					_hand.body2 = body;
					_hand.anchor2 = body.worldPointToLocal( mousePoint );
					if(body.type == BodyType.DYNAMIC){
						_hand.active = true;
					}
				}
			});
		}
		
		private function listenForMouseUp():void
		{
			_nativeStage.addEventListener( MouseEvent.MOUSE_UP, function( event : MouseEvent ) : void
			{
				_hand.active = false;
			});
		}
		
		private function listenForEnterFrame() : void
		{
			addEventListener( Event.ENTER_FRAME, function( event : Event ) : void
			{
				_hand.anchor1.setxy( _nativeStage.mouseX, _nativeStage.mouseY );
				_space.step( STEP_TIME );
				for (var i:int = 0; i < _space.liveBodies.length; i++) {
					var body:Body = _space.liveBodies.at(i);
					if (body.userData.graphicUpdate) {
						body.userData.graphicUpdate(body);
					}
				}
			});
		}
		
		private function useAccelerometer():void
		{
			var accelerometer : Accelerometer = new Accelerometer();
			accelerometer.addEventListener( AccelerometerEvent.UPDATE, function( event : AccelerometerEvent ) : void
			{
				_space.gravity = new Vec2( -event.accelerationX * 5000, GRAVITY_Y );
			});
		}
		
		
		
		override public function destroy():void{
		}
		
		
	}
}