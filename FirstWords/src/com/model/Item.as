package com.model
{
	public class Item
	{
		private var _image:String;
		private var _sound:String;
		public function Item(data:XML){
			_image = data.@image;
			_sound = data.@sound;
		}

		public function get sound():String
		{
			return _sound;
		}

		public function get image():String
		{
			return _image;
		}

	}
}