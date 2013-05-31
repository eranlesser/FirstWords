package com.food
{
	import com.snake.Snake;
	import com.utils.filters.GlowFilter;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class ExplodingFood extends Food
	{
		[Embed(source="assets/explodingFood.png")]
		private  const food:Class;
		
		public function ExplodingFood()
		{
			super();
		}
		
		
		override public function get type():String{
			return Food.EXPLODING;
		}
		
		override protected function draw():void{
			var img:Image = new Image(Texture.fromBitmap(new food()));
			addChild(img);
			img.x = (Snake.stepSize-img.width)/2;
			img.y = (Snake.stepSize-img.height)/2;
			var shiner:DelayedCall = Starling.juggler.delayCall(
				function shine():void{
					if(img.filter == null){
						img.filter = new GlowFilter();
					}else{
						img.filter=null;
					}
				},0.6
			)
			shiner.repeatCount = 0;
		}
	}
}