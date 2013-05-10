package com.view.components
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.Session;
	import com.utils.InApper;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ScreensMenu extends Sprite
	{
		[Embed(source="../../../assets/bonus.png")]
		private var bonus : 			Class;
		[Embed(source = "../../../assets/btn.png")] 
		private static const btn:Class;
		private var _restoreButton:Button;
		private var _inApper:InApper;
		private var playRoomThmb:ThumbNail;
		public var gotoSignal:Signal = new Signal();
		public function ScreensMenu(screens:ScreensModel)
		{
			init(screens);
			initInapper();
			Session.changed.add(onsessionChanged);
			onsessionChanged();
		}
		
		private function onsessionChanged():void{
			//update bonus screen
			playRoomThmb.locked = !Session.playRoomEnabled;
			//update selected screen + inapp purchase
			setSelectedScreen();
			
			_restoreButton.visible = !Session.fullVersionEnabled;
		}
		
		private function init(screens:ScreensModel):void
		{
			var i:int=0;
			var n:int=0;
			var wdt:uint=170;
			var hgt:uint=136;
			var gap:uint=12;
			for each(var screen:ScreenModel in screens.screens){
				if(screen.thumbNail!=""){
					var menuThmb:ThumbNail = new ThumbNail(Assets.getAtlas("thumbs").getTexture(screen.thumbNail),i);
					menuThmb.x = (n%4)*wdt + (n%4)*gap;//menuThmb.x-5;
					menuThmb.y = Math.floor(n/4)*(hgt+gap);//menuThmb.y-5;
					addChild(menuThmb);
					menuThmb.addEventListener(starling.events.Event.TRIGGERED,function onTriggered(e:starling.events.Event):void{
						var thmbNail:ThumbNail = ThumbNail(Button(e.target).parent);
						if(thmbNail.locked){
							//Flurry.getInstance().logEvent("productStore.available",productStore.available);
							_inApper.signal.addOnce(onInApperEvent);
							_inApper.purchase("babyTweetsHeb.fullContent",1);
						}else{
							gotoSignal.dispatch(thmbNail.index);
						}
					});
					n++;
				}//if
				i++;
			}//for
			playRoomThmb = new ThumbNail(Assets.getAtlas("thumbs").getTexture("plane"),-2,new Image(Texture.fromBitmap(new bonus())));
			addChild(playRoomThmb);
			playRoomThmb.addEventListener(starling.events.Event.TRIGGERED,function onTriggered(e:starling.events.Event):void{
				gotoSignal.dispatch(ThumbNail(Button(e.target).parent).index);
			});
			playRoomThmb.x=width-playRoomThmb.width-4;
			playRoomThmb.y=height-playRoomThmb.height-4;
			x=(Dimentions.WIDTH-width)/2;
			y=140;
			_restoreButton = new Button(Texture.fromBitmap(new btn()),"RESTORE TRANSACTIONS");
			addChild(_restoreButton);
			_restoreButton.x=12;
			_restoreButton.y=-72;
			_restoreButton.addEventListener(Event.TRIGGERED,onRestoreClicked);
			_restoreButton.visible = !Session.fullVersionEnabled;
		}//function
		
		public function setSelectedScreen():void{
			for(var i:uint = 0;i<numChildren-2;i++){ // subtract restore btn
				if(i>Session.FREE_SCREENS_COUNT-1 && !Session.fullVersionEnabled){//apply lock
					(getChildAt(i) as ThumbNail).locked=true;
				}else{
					(getChildAt(i) as ThumbNail).locked=false;
				}
				if((getChildAt(i) as ThumbNail).index==Session.currentScreen){//apply selected screen
					(getChildAt(i) as ThumbNail).selected = true;
				}else{
					(getChildAt(i) as ThumbNail).selected = false;
				}
			}
		}
		
		private function initInapper():void{
			_inApper = new InApper();
			
		}
		
		private function onRestoreClicked(e:Event):void{
			_inApper.signal.addOnce(onInApperEvent);
			_inApper.restoreTransactions();
		}
		
		private function onInApperEvent(eventType:String,data:Object=null):void{
			switch(eventType){
				case InApper.PRODUCT_TRANSACTION_SUCCEEDED:
					Session.fullVersionEnabled=true;
					break;
				case InApper.PRODUCT_RESTORE_SUCCEEDED:
					Session.fullVersionEnabled=true;
					break;
			}
		}
		
	}
}


import com.Assets;
import com.Dimentions;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

class ThumbNail extends Sprite{
	public var index:int;
	private var _btn:Button;
	private var _selectedFrame:Button;
	private var _lock:Image;
	function ThumbNail(asset:Texture,indx:int,lock:Image=null){
		var frame:Button = new Button(Texture.fromBitmap(new Assets.Frame))
		_selectedFrame = new Button(Texture.fromBitmap(new Assets.FrameSelected))
		
		var wdt:uint=170;
		var hgt:uint=136;
		addChild(frame);
		addChild(_selectedFrame);
		_selectedFrame.visible=false;
		frame.width = wdt;
		frame.height = hgt;
		_btn = new Button(asset);
		addChild(_btn)
		_btn.x=(frame.width-_btn.width)/2;
		_btn.y=(frame.height-_btn.height)/2;
		if(lock){
			_lock=lock;
			_lock.x=(wdt-_lock.width)/2;
			_lock.y=-15;
		}else{
			_lock = new Image(Texture.fromBitmap(new Assets.Lock));
			_lock.x=wdt-_lock.width-8;
			_lock.y=hgt-_lock.height-5;
		}
		addChild(_lock);
		
		index=indx;
		
	}
	
	public function set selected(val:Boolean):void{
		_selectedFrame.visible=val;
	}
	
	public function set locked(val:Boolean):void{
		_lock.visible=val;
		//this.touchable = !val;
	}
	
	public function get locked():Boolean{
		return _lock.visible;
	}
	
}