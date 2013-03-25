package com.model
{
	import flash.geom.Rectangle;
	
	import nape.geom.Vec2;

	public class Item
	{
		private var _image:String;
		private var _sound:String;
		private var _groupId:String;
		private var _rects:Vector.<Rectangle>;
		private var _wasWho:Boolean=false;
		
		public function Item(data:XML){
			_image = data.@image;
			_sound = data.@sound;
			_groupId = data.@groupId;
			_rects = new Vector.<Rectangle>();
			for each(var rectXml:XML in data.rect){
				var rectInfo:Array = String(rectXml.@vector).split(",");
				_rects.push(new Rectangle(rectInfo[0],rectInfo[1],rectInfo[2],rectInfo[3]));
			}
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
		
		public function get rects():Vector.<Rectangle>{
			return _rects;
		}

	}
}