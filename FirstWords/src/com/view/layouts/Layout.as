package com.view.layouts
{
	import starling.display.Image;

	public class Layout
	{
		protected var _placeHolders:Vector.<PlaceHolder>;
		public function Layout()
		{
			_placeHolders = new Vector.<PlaceHolder>();
		}
		
		protected function addPlaceHolder(x:int,y:int):void{
			_placeHolders.push(new PlaceHolder(x,y));
		}
		
		public function layout(images:Vector.<Image>):void{
			var placeHolder:PlaceHolder;
			for each(var image:Image in images){
				placeHolder = getRandomPlaceHolder();
				image.x = placeHolder.x;
				image.y = placeHolder.y;
			}
		}
		
		private function getRandomPlaceHolder():PlaceHolder{
			return _placeHolders[0];
		}
	}
}

class PlaceHolder{
	private var _x:int;
	private var _y:int;
	public var empty:Boolean = true;
	function PlaceHolder(xx:int,yy:int){
		_x=xx;
		_y=yy;
	}

	public function get y():int
	{
		return _y;
	}

	public function get x():int
	{
		return _x;
	}
}