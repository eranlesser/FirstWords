package com.view
{
	import com.Dimentions;
	
	import flash.geom.Rectangle;
	
	import org.gestouch.events.GestureEvent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	public class ItemsMenu extends Sprite
	{
		public static const ITEM_WIDTH:uint = 110;
		public static const ITEM_GAP:uint = 2;
		[Embed(source="assets/arrow.jpg")]
		private  const arrow:Class;
		[Embed(source="assets/menuBg.jpeg")]
		private  const menuBg:Class;
		private var _thumbsLayer:Sprite;
		private var _thumbsContent:Sprite;
		public function ItemsMenu()
		{
			super();
			//alpha=0.5;
			//addEventListener(GestureEvent.GESTURE_BEGAN,onGesture);
			addChild(new Image(Texture.fromBitmap(new menuBg()))).alpha=0.5;
			addEventListener(TouchEvent.TOUCH,onGesture);
			_thumbsLayer = new Sprite();
			addChild(_thumbsLayer);
			_thumbsLayer.clipRect = new Rectangle(0,0,Dimentions.WIDTH-100,ITEM_WIDTH)
			_thumbsLayer.x=50;
			_thumbsContent = new Sprite();
			_thumbsLayer.addChild(_thumbsContent);
			var rArrow:Button = new Button(Texture.fromBitmap(new arrow()));
			rArrow.scaleX=-1;
			rArrow.x=rArrow.width;
			rArrow.alpha=0.5;
			addChild(rArrow);
			rArrow.y = (ITEM_WIDTH - rArrow.height)/2
			var lArrow:Button = new Button(Texture.fromBitmap(new arrow()));
			addChild(lArrow);
			lArrow.y = (ITEM_WIDTH - rArrow.height)/2;
			lArrow.x = Dimentions.WIDTH - lArrow.width;
			lArrow.alpha = 0.5;
			lArrow.addEventListener(Event.TRIGGERED,function():void{move(1)});
			rArrow.addEventListener(Event.TRIGGERED,function():void{move(-1)});
		}
		
		public function get itemsWidth():uint{
			return numChildren*(ITEM_WIDTH+ITEM_GAP);
		}
		
		private function onGesture(e:TouchEvent):void{
			if(e.type=="swipe"){
				//move(e);
			}
		}
		private var isTweening:Boolean;
		private function move(dir:int):void{
			
			var t:Tween = new Tween(_thumbsContent,1);
			Starling.juggler.add(t);
			var newX:int=1;
			if(dir==1){
				newX = _thumbsContent.x-(Dimentions.WIDTH/2);
			}else if(dir==-1){
				if(_thumbsContent.x<0){
					newX = _thumbsContent.x+(Dimentions.WIDTH/2);
				}
			}
			//if(newX<1){
			trace(isTweening)
			if(!isTweening){
				t.animate("x",newX);
				isTweening = true;
				t.onComplete = function():void{
					isTweening = false;
				}
			}
			//}
		}
		
		public function addItem(item:RoomItem):void{
			_thumbsContent.addChild(item);
			item.x = item.model.menuIndex * (ITEM_WIDTH+ITEM_GAP);
			item.y=0;
		}
		
		public function removeItem(item:RoomItem):void{
			_thumbsContent.removeChild(item);
		}
		
		public function isChild(item:RoomItem):Boolean{
			return _thumbsContent.contains(item);
		}
		
	}
}