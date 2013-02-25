package com.view.components{
	
import org.osflash.signals.Signal;

import starling.display.Image;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class ImageItem extends Image{
	private var _sound:String;
	private var _bg:Image;
	public var touched:Signal = new Signal();
	function ImageItem(texture:Texture,sound:String):void{
		_sound = sound;
		super(texture);
		addEventListener(TouchEvent.TOUCH,onClick);
	}
	
	private function onClick(t:TouchEvent):void{
		if(t.getTouch(stage).phase == TouchPhase.BEGAN){
			touched.dispatch(this);
		}
	}
	
	public function get bg():Image
	{
		return _bg;
	}

	public function set bg(value:Image):void
	{
		_bg = value;
		_bg.addEventListener(TouchEvent.TOUCH,onClick);
	}

	public function get sound():String
	{
		return _sound;
	}
}
}