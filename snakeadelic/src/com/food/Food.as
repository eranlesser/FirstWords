package com.food
{
	import com.snake.Snake;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Food extends Sprite
	{
		[Embed(source="assets/food.png")]
		private  const food:Class;
		public static const REGULAR:String = "regular";
		public static const EXPLODING:String = "exploding";
		public static const EXPLODED:String = "exploded";
		public function Food()
		{
			init();
		}
		
		private function init():void{
			draw();
			
		}
		
		protected function draw():void{
			var img:Image = new Image(Texture.fromBitmap(new food()));
			addChild(img);
			img.x = (Snake.stepSize-img.width)/2;
			img.y = (Snake.stepSize-img.height)/2;
		}
		
		public function get score():uint{
			return 10;
		}
		
		public function get growBy():uint{
			return 1;
		}
		
		public function get type():String{
			return REGULAR;
		}
	}
}