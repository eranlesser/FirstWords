package com.view.layouts
{
	import com.Dimentions;

	public class ThreeLayout extends Layout
	{
		private const numItems:int = 3;
		public function ThreeLayout()
		{
			super();
			init();
		}
		
		private function init():void{
			var itemWidth:int = (Dimentions.WIDTH-100)/numItems;
			for(var i:uint=0;i<numItems;i++){
				addPlaceHolder(itemWidth*i+50,Dimentions.HEIGHT*1/2,itemWidth,Dimentions.HEIGHT*1/2);
			}
		}
	}
}