package com.model
{
	public class ItemModel
	{
		private var _menuIndex:uint;
		private var _x:uint;
		private var _y:uint;
		private var _texture:String;
		public var currentX:int;
		public var currentY:int;
		public function ItemModel(data:XML)
		{
			_x=data.@x;
			_y=data.@y;
			_menuIndex=data.@menuIndex;
			_texture = data.@image;
		}

		public function set menuIndex(value:uint):void
		{
			_menuIndex = value;
		}

		public function get texture():String
		{
			return _texture;
		}

		public function get y():uint
		{
			return _y;
		}

		public function get x():uint
		{
			return _x;
		}

		public function get menuIndex():uint
		{
			return _menuIndex;
		}

	}
}