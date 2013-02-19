package com.model
{
	public class ItemsGroup
	{
		private var _items:Vector.<Item>;
		private var _askedCounter:uint=0;
		public function ItemsGroup(data:XML){
			_items = new Vector.<Item>();
			for each(var itemData:XML in data.item){
				_items.push(new Item(itemData));
			}
		}
		
		public function getNextItem():Item{
			return _items[_askedCounter];
		}
	}
}