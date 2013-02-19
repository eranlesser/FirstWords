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
			for(var i:uint=0;i<numItems;i++){
				addPlaceHolder(((Dimentions.WIDTH-100)/numItems)*i,Dimentions.HEIGHT*2/3);
			}
		}
	}
}