package com.screens
{
	import com.Dimentions;
	import com.model.ItemModel;
	import com.utils.ItemsGlower;
	import com.utils.NameNarator;
	import com.view.ItemsMenu;
	import com.view.RoomItem;
	import com.view.roomItems.*;
	
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	import flash.utils.getTimer;
	
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Room extends Sprite
	{
		[Embed(source="assets/room.xml", mimeType="application/octet-stream")]
		private  const room_xml:Class;
		
		[Embed(source="assets/room.png")]
		private  const room:Class;
		private static const GRAVITY_X : Number = 0;
		private static const GRAVITY_Y : Number = 3000;
		
		private static const STEP_TIME : Number = 0.01;
		private var _nativeStage : Stage;
		private var _space : Space;
		private var _hand : PivotJoint;
		
		public static var atlas:TextureAtlas;
		private var _menuAtlas:TextureAtlas;
		private var _menu:ItemsMenu;
		private var _window:Window;
		private var _sipur:Sound = new Sound(new URLRequest("sounds/room/bacheder_sipur.mp3"));
		private var _song:Sound = new Sound(new URLRequest("sounds/room/bamamlach.mp3"));
		private var _narator:NameNarator;
		
		private var _frontLayer:Sprite;
		private var _backLayer:Sprite;
		
		public function Room(data:XML)
		{
			super();
			_narator = new NameNarator("sounds/names/emanuel.mp3");
			var texture:Texture=  Texture.fromBitmap(new room());
			atlas = new TextureAtlas(texture,new XML(new room_xml()) as XML);
			//_menuAtlas = new TextureAtlas(Texture.fromBitmap(new menu()),new XML(new menu_xml()) as XML);
			_window = new Window(atlas);
			addChild(_window);
			_window.x=58;
			_window.y=56;
			addChild(new Image(atlas.getTexture("roon-only-with-shelf")));
			
			_menu = new ItemsMenu();
			addChild(_menu);
			_menu.y = Dimentions.HEIGHT - ItemsMenu.ITEM_WIDTH-10;
			parse(data);
			var v:Vector.<Number> = new Vector.<Number>();
			v.push(2.832)
			v.push(21.689)
			v.push(41.351)
			//_narator.play(v);
			_nativeStage = Starling.current.nativeStage;
			createSpace();
			createHand();
			listenForMouseDown();
			listenForMouseUp();
			listenForEnterFrame();
			useAccelerometer();
			createFloor();
			var lamp:Lamp = new Lamp(_space,null);
			addChild(lamp.material);
			lamp.lightChanged.add(onLightChanged);
			lamp.material.x=435;
			_frontLayer = new Sprite();
			_backLayer = new Sprite();
			addChild(_backLayer);
			addChild(_frontLayer);
		}
		
		private function onLightChanged(val:uint):void{
			if(val==1){
				addChildAt(new Image(atlas.getTexture("night room good 1")),2).width=1028;
			}else{
				removeChildAt(2);
			}
		}
		
		private function playStory():void{
			var chnl:SoundChannel = _sipur.play();
			//chnl.addEventListener(flash.events.Event.SOUND_COMPLETE,dropItems);
		}
		
		private function parse(xml:XML):void{
			var itemModel:ItemModel;
			var i:uint=0;
			for each(var item:XML in xml.item){
				if(item.@menuItem!="false"){
					itemModel = new ItemModel(item)
					itemModel.menuIndex = i;
					i++;
					var roomItem:RoomItem = new RoomItem(new Image(atlas.getTexture("small/"+itemModel.texture)),new Image(atlas.getTexture(itemModel.texture)),itemModel);
					_menu.addItem(roomItem);
					roomItem.addEventListener(TouchEvent.TOUCH,onTouch);
				}
			}
			
		}
		
		
		
//		private function onBackToMenu():void{
//			_menu.y=Dimentions.HEIGHT;
//			for each(var roomItem:RoomItem in _items){
//				roomItem.state = RoomItem.MENU_STATE;
//				_menu.addItem(roomItem);
//			}
//			var tween:Tween = new Tween(_menu,1);
//			Starling.juggler.add(tween);
//			tween.animate("y",Dimentions.HEIGHT-ItemsMenu.ITEM_WIDTH);
//			
//		}
		
		
		
		private var _downX:Number;
		private var _downY:Number;
		private function onTouch(e:TouchEvent):void
		{
			var item:RoomItem = e.currentTarget as RoomItem;
			var touch:Touch = e.getTouch(this.stage); 
			if(!touch){
				return;
			}
			if(touch.phase == TouchPhase.BEGAN){
				_downX = touch.globalX;
				_downY = touch.globalY;
			}
			if(touch.phase == TouchPhase.MOVED){	
				if(_menu.contains(item)){
					_menu.removeItem(item);
					addChild(item);
					item.x = touch.globalX-item.width/2;
					item.y = touch.globalY-item.height/2;
						
				}
//				if(touch.globalY>700){
//					item.state = RoomItem.MENU_STATE;
//					item.x = item.x+(touch.globalX-_downX) //-ItemsMenu.ITEM_WIDTH/2;
//					_downX = touch.globalX;
//					item.y = item.y+(touch.globalY-_downY)
//					_downY=touch.globalY;
//						
//				}else{
					item.state = RoomItem.ON_STAGE_STATE;
					item.x = item.x+(touch.globalX-_downX) //-ItemsMenu.ITEM_WIDTH/2;
					_downX = touch.globalX;
					item.y = item.y+(touch.globalY-_downY)
					_downY=touch.globalY;
					//item.x = touch.globalX-item.width/2;
					//item.y = touch.globalY-item.height/2;
				//}
			}
			if(touch.phase == TouchPhase.ENDED){
				if(touch.globalY>620){
					item.state = RoomItem.MENU_STATE;
					_menu.addItem(item);
				}
				else{
					onMenuItemDropped(item.x,item.y,item);
				}
			}
		}
		
		private function onMenuItemDropped(x:int,y:int,item:RoomItem):void{
			removeChild(item);
			//addChild(item);
			//Flurry.getInstance().logEvent("playroom "+id);
			var playItem:PlayItem;
			switch(item.model.texture){
				case "big_ball":
					playItem = new BigBall(_space,null,x,y);
					_frontLayer.addChild(playItem.material);
					break;
				case "small_ball":
					playItem = new SmallBall(_space,null,x,y);
					_frontLayer.addChild(playItem.material);
					break;
				case "orange_cube":
					playItem= new Cube(_space,null,x,y);
					_frontLayer.addChild(playItem.material);
					break;
				case "bridge":
					playItem = new Bridge(_space,null,x,y);
					_frontLayer.addChild(playItem.material);
					break;
				case "pins":
					//playItem = new Bridge(_space,null,x,y);
					_frontLayer.addChild(new Pin(_space,null,x-20,y-5,"bowling-pin-light-blue").material);
					_frontLayer.addChild(new Pin(_space,null,x,y,"bowling-pin-orenge").material);
					_frontLayer.addChild(new Pin(_space,null,x+20,y-5,"bowling-pin-purple").material);
					break;
//				case "ball":
//					var ball:BasketBall = new BasketBall(_space,_ballCollisionType,x,y);
//					_room.addChild( ball.material);
//					break;
//				case "cubes":
//					_room.addChild(new Cube(_space,_cubeCollisionType,x-40,y,1).material);
//					_room.addChild(new Cube(_space,_cubeCollisionType,x+40,y,2).material);
//					_room.addChild(new Cube(_space,_cubeCollisionType,x,y-80,3).material);
//					break;
//				case "bluBln":
//					var baloon:Baloon = new Baloon(_space,_baloonCollisionType,x,y);
//					_room.addChild(baloon.material);
//					baloon.material.addEventListener(TouchEvent.TOUCH,function onTouch(e:TouchEvent):void{
//						//if(baloon.material.stage == null){
//						_hand.active = false;
//						//}
//					});
//					_balloons.push(baloon);
//					break;
//				case "fly_baloon":
//					_room.addChild(new FlyBaloon(_space,_baloonPopCollisionType,x,y).material);
//					break;
//				case "plane":
//					_room.addChild(new Plane(_space,_baloonPopCollisionType,x,y).material);
//					break;
//				case "train2":
//					_room.addChild(new Train(_space,_baloonPopCollisionType,x,y).material);
//					break;
//				case "book":
//					_room.addChild(new Book(_space,_baloonPopCollisionType,x,y).material);
//					break;
//				case "horse":
//					_room.addChild(new Horse(_space,null,x,y).material);
//					break;
//				case "drawing":
//					var drawing:Drawing = new Drawing();
//					_room.addChildAt(drawing,1);
//					drawing.x=x;
//					drawing.y=y;
//					break;
				default:
					_backLayer.addChild(item);
					item.x=x;
					item.y=y;
			}
			
			//_menu.visible = false;
		}
		
		private function createSpace():void
		{
			_space = new Space( Vec2.get( GRAVITY_X, GRAVITY_Y ) );
		}
		public static const WALL_WIDTH:uint=22;
		private function createFloor():void
		{
			const floor:Body = new Body( BodyType.STATIC );
			
			// what are all these things?
			floor.shapes.add( new Polygon( Polygon.rect( 0, 768 - ItemsMenu.ITEM_WIDTH - 2-30, 1024, 200 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 1024-WALL_WIDTH, 0, WALL_WIDTH, 768 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, -20, 1024, 22 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, 0, WALL_WIDTH, 768 ) ) );
			
			floor.space = _space;
			//floor.cbTypes.add(_floorCollisionType);
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
	}
}
