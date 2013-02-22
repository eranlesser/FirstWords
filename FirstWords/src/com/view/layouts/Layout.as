package com.view.layouts
{
	import com.view.components.ImageItem;
	
	import starling.display.Image;

	public class Layout
	{
		protected var _placeHolders:Vector.<PlaceHolder>;
		public function Layout()
		{
			_placeHolders = new Vector.<PlaceHolder>();
		}
		
		protected function addPlaceHolder(x:int,y:int,width:int,height:int):void{
			_placeHolders.push(new PlaceHolder(x,y,width,height));
		}
		
		public function layout(images:Vector.<ImageItem>):void{
			var placeHolder:PlaceHolder;
			for each(var image:ImageItem in images){
				placeHolder = getRandomPlaceHolder();
				placeHolder.image = image;
			}
		}
		
		public function clear():void{
			for each(var placeHolder:PlaceHolder in _placeHolders){
				placeHolder.clear();
			}
		}
		
		private function getRandomPlaceHolder():PlaceHolder{
			var placeHolder:PlaceHolder=_placeHolders[Math.round(Math.random()*(_placeHolders.length-1))];
			while(!placeHolder.empty){
				placeHolder = _placeHolders[Math.round(Math.random()*(_placeHolders.length-1))];
			}
			return placeHolder;
		}
	}
}
import com.view.components.ImageItem;

import starling.display.Image;

class PlaceHolder{
	private var _x:int;
	private var _y:int;
	private var _width:int;
	private var _height:int;
	private var _image:Image;
	function PlaceHolder(xx:int,yy:int,width:int,height:int){
		_x=xx;
		_y=yy;
		_width=width;
		_height=height;
	}

	public function get empty():Boolean
	{
		return _image==null;
	}

	
	public function set image(img:ImageItem):void{
		_image = img;
		_image.x = _x;
		_image.y = _y;
		if(_image.width>_width){
			var ratio:Number = _width/_image.width;
			_image.width = _width;
			_image.height = _image.height*ratio;
			
		}else if(_width>_image.width){
			_image.x = _x+(_width-_image.width)/2;
		}
		if(_height>_image.height){
			_image.y = _y+(_height-_image.height)/2;
		}
	}
	
	public function clear():void{
		if(_image){
			_image.removeFromParent(true);
			_image=null;
		}
	}
	
}