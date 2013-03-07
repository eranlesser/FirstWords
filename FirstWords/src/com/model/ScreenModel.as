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
			var item:Item = _items[Math.floor(Math.random()*(_items.length))];
			if(item.wasWho==true){
				item = whoIsItem;
			}
			item.wasWho=true;
			_groupsInScreen.push(item.groupId);
			return item;
		}
		
		public function get distractor():Item{
			var item:Item = _items[Math.floor(Math.random()*(_items.length))];
			if(_groupsInScreen.indexOf(item.groupId)==-1){
				_groupsInScreen.push(item.groupId);
				return item;
			}else{
				return distractor;
			}
			
		}
		
		public function get groupName():String{
			return _groupName;
		}
		
		public function clear():void{
			_groupsInScreen = new Vector.<String>();
		}
		
		public function reset():void{
			_groupsInScreen = new Vector.<String>();
			for each(var item:Item in _items){
				item.wasWho = false;
			}
			
		}
		
		public function get numItems():int{
			return _items.length;
		}
	}
}