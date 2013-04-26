package com.view
{
	import starling.display.Sprite;

	public class ItemsMenu extends Sprite
	{
		public static const ITEM_WIDTH:uint = 110;
		public function ItemsMenu()
		{
			super();
			alpha=0.5;
		}
		
		public function addItem(item:MenuItem):void{
			addChild(item);
			item.x = item.model.menuIndex * (ITEM_WIDTH+2);
		}
		
		public function removeItem(item:MenuItem):void{
			removeChild(item);
		}
		
	}
}