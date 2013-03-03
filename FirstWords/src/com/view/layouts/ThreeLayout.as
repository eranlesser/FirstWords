package com.view.layouts
{
	import com.Dimentions;
	
	import starling.display.Sprite;

	public class ThreeLayout extends Layout
	{
		private const numItems:int = 3;
		public function ThreeLayout(view:Sprite)
		{
			super(view);
			init();
		}
		
		private function init():void{
			const gap:int=60;
			var itemWidth:int = (Dimentions.WIDTH-100)/numItems;
			for(var i:uint=0;i<numItems;i++){
				addPlaceHolder((itemWidth+gap)*i+50-gap/2,Dimentions.HEIGHT*1/4,itemWidth-gap,Dimentions.HEIGHT*1/4);
			}
		}
	}
}