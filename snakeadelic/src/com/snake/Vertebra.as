package com.snake
{
	
	import com.ILocalalbe;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Vertebra extends Sprite implements ILocalalbe
	{
		protected var _location:Point;
		private var _oldLocation:Point;
		[Embed(source="assets/ver.png")]
		private  const ver:Class;
		
		public function Vertebra(){
			 drawSelf();
		}
		private function drawSelf():void{
			//embed square
			var img:Image = addChild(new Image(Texture.fromBitmap(new ver()))) as Image;
			img.x = (Snake.stepSize-img.width)/2;
			img.y = (Snake.stepSize-img.height)/2;
		}
		public function set location(locatn:Point):void{
			if(_location)
				_oldLocation = _location;
			this.x=locatn.x;
			this.y=locatn.y;
			_location=locatn;
		}
		public function get location():Point{
			return _location.clone();
		}
		public function get oldLocation():Point{
			return _oldLocation.clone();
		}
		public function destroy():void{
			//remove square;	
			removeChildren();
			removeEventListeners();
		}
		
	}
}