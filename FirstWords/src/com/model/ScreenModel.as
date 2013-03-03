package com.model
{
	public class ScreenModel
	{
		private var _items:Vector.<Item>;
		private var _groupName:String;
		private var _groupsInScreen:Vector.<String>;
		private var _thumbNail:String;
		public function ScreenModel(data:XML){
			_items = new Vector.<Item>();
			for each(var itemData:XML in data.item){
				_items.push(new Item(itemData));
			}
			_groupName = data.@groupName;
			_thumbNail = data.@thumbNail;
		}
		
		public function get thumbNail():String
		{
			return _thumbNail;
		}

		public function get whoIsItem():Item{
			var item:Item = _items[Math.round(Math.random()*(_items.length-1))];
			while(item.wasWho==true){
				item = _items[Math.round(Math.random()*(_items.length-1))];
			}
			item.wasWho=true;
			_groupsInScreen.push(item.groupId);
			return item;
		}
		public function get distractor():Item{
			var item:Item = _items[Math.round(Math.random()*(_items.length-1))];
			while(_groupsInScreen.indexOf(item.groupId)>=0){
				item = _items[Math.round(Math.random()*(_items.length-1))];
			}
			_groupsInScreen.push(item.groupId);
			return item;
		}
		
		public function get groupName():String{
			return _groupName;
		}
		
		public function clear():void{
			_groupsInScreen = new Vector.<String>();
		}
		
		public function get numItems():int{
			return _items.length;
		}
	}
}