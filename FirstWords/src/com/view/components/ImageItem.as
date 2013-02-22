package com.view.components{
	
import starling.display.Image;
import starling.textures.Texture;

public class ImageItem extends Image{
	private var _sound:String;
	function ImageItem(texture:Texture,sound:String):void{
		_sound = sound;
		super(texture);
	}
	
	public function get sound():String
	{
		return _sound;
	}
}
}