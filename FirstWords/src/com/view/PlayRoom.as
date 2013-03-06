package com.view
{
	import com.Dimentions;
	import com.model.rawData.PlayRoomData;
	import com.view.playRoom.BasketBall;
	import com.view.playRoom.Cube;
	import com.view.playRoom.Menu;
	
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class PlayRoom extends Sprite
	{
		private static const GRAVITY_X : Number = 0;
		private static const GRAVITY_Y : Number = 3000;
		
		private static const STEP_TIME : Number = 0.01;
		
		
		[Embed(source="../../assets/background.png")]
		private var Background:Class;
		
		private var _nativeStage : Stage;
		private var _space : Space;
		private var _hand : PivotJoint;
		
		private var _ballCollisionType:CbType = new CbType();
		private var _cubeCollisionType:CbType = new CbType();
		private var _floorCollisionType:CbType = new CbType();
		private var _ballSound:SoundChannel;
		
		private var _menu:Menu;
		public function PlayRoom()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( event : Event ) : void
		{
			_nativeStage = Starling.current.nativeStage;
			
			addBackground();
			createSpace();
			createFloor();
			createHand();
			listenForMouseDown();
			listenForMouseUp();
			listenForEnterFrame();
			useAccelerometer();
			//_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_floorCollisionType,_cubeCollisionType,ballToCube));
			_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_ballCollisionType,_cubeCollisionType,ballToFloor));
			_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION,_ballCollisionType,_floorCollisionType,ballToFloor));
			
			_menu = new Menu(PlayRoomData.data);
			addChild(_menu);
			_menu.x = (Dimentions.WIDTH - _menu.width)/2;
			_menu.itemDropped.add(onMenuItemDropped);
		}
		
		private function onMenuItemDropped(x:int,y:int,id:String):void{
			switch(id){
				case "ball1":
					addBall(x,y);
					break;
				case "cubes1":
					addCube(x,y)
					break;
			}
			trace(id)
		}
		
		private function ballToCube(collision:InteractionCallback):void {
			new Sound(new URLRequest("../../assets/sounds/playroom/bounce.mp3")).play();
		}
		private function ballToFloor(collision:InteractionCallback):void {
			if(_ballSound)
				_ballSound.stop();
			_ballSound = new Sound(new URLRequest("../../assets/sounds/playroom/boing.mp3")).play();
		}
		
		private function addBackground() : void
		{
			addChild( Image.fromBitmap( new Background() ) );
		}
		
		private function createSpace():void
		{
			_space = new Space( new Vec2( GRAVITY_X, GRAVITY_Y ) );
		}
		
		private function createFloor():void
		{
			const floor:Body = new Body( BodyType.STATIC );
			
			// what are all these things?
			floor.shapes.add( new Polygon( Polygon.rect( 0, 768 - Menu.HEIGHT - 2, 1024, 80 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 1024, 0, 200, 768 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, -20, 1024, 180 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( -200, 0, 200, 768 ) ) );
			
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
		
		private function addBall(xx:int,yy:int):void
		{
			var ball:BasketBall = new BasketBall(_space,updateGraphics,_ballCollisionType,xx,yy);
			addChild( ball.material);
		}
		private function addCube(xx:int,yy:int):void
		{
			var cube:Cube = new Cube(_space,updateGraphics,_cubeCollisionType,xx,yy);
			addChild( cube.material);
		}
		
		private function updateGraphics( body : Body ) : void
		{
			body.userData.graphic.x = body.position.x;
			body.userData.graphic.y = body.position.y;
			body.userData.graphic.rotation = body.rotation;
		}
	}
}