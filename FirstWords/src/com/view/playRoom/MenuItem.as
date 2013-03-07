package com.view.playRoom{
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class MenuItem extends Image{
		private var _isDragging:Boolean = false;
		private var _id:String;
		public var dropped:Signal = new Signal();
		public function MenuItem(texture:Texture,id:String)
		{
			super(texture);
			_id = id;
			this.width = Menu.HEIGHT-4;
			this.height=Menu.HEIGHT-4;
			this.x=2;
			this.y=2;
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
	
	private function onTouch(t:TouchEvent):void{
		var touch:Touch = t.getTouch(stage);
		if(touch == null){
			return;
		}
		if((touch.phase == TouchPhase.BEGAN)){
			_isDragging = true;
		}
		if(touch.phase == TouchPhase.MOVED && _isDragging){
			this.x = touch.globalX - this.width/2;
			this.y = touch.globalY - this.height/2;
		}
		if(touch.phase == TouchPhase.ENDED){
			_isDragging = false;
			dropped.dispatch(x,y,this);
		}
	}
	
	public function get id():String{
		return _id;
	}
}
}
