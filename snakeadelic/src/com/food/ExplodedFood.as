package com.food
{
	import com.snake.Snake;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;

	public class ExplodedFood extends Food
	{
		
		[Embed(source="assets/explodedFood.png")]
		private  const food:Class;
		public function ExplodedFood()
		{
			super();
		}
		
		override public function get score():uint{
			return 10;
		}
		
		override public function get growBy():uint{
			return 0;
		}
		
		override public function get type():String{
			return Food.EXPLODED;
		}
		
		override protected function draw():void{
			var img:Image = new Image(Texture.fromBitmap(new food()));
			addChild(img);
			img.x = (Snake.stepSize-img.width)/2;
			img.y = (Snake.stepSize-img.height)/2;
			var blinker:DelayedCall = Starling.juggler.delayCall(blink,1);
			blinker.repeatCount=8;
		}
		
		private function blink():void{
				if(alpha == 1){
					alpha = 0.5;
				}else{
					alpha = 1;
				}
			}
	}
}