package com.model
{
	public class Item
	{
		private var _image:String;
		private var _sound:String;
		private var _groupId:String;
		private var _wasWho:Boolean=false;
		public function Item(data:XML){
			_image = data.@image;
			_sound = data.@sound;
			_groupId = data.@groupId;
		}

		public function get groupId():String
		{
			return _groupId;
		}

		public function get wasWho():Boolean
		{
			return _wasWho;
		}

		public function set wasWho(value:Boolean):void
		{
			_wasWho = value;
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