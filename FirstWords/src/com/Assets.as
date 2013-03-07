package com
{	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
		[Embed(source="assets/baby_toys.xml", mimeType="application/octet-stream")]
		public static const toys_xml:Class;
		
		[Embed(source="assets/baby_toys.png")]
		public static const toys:Class;
		
		[Embed(source="assets/fruits.xml", mimeType="application/octet-stream")]
		public static const fruits_xml:Class;
		
		[Embed(source="assets/fruits.jpg")]
		public static const fruits:Class;
		[Embed(source="assets/animals.xml", mimeType="application/octet-stream")]
		public static const animals_xml:Class;
		
		[Embed(source="assets/animals.jpg")]
		public static const animals:Class;
		
		[Embed(source = "assets/background.jpg")] 
		public static const BackgroundImage:Class;
		
		[Embed(source = "assets/frames1.jpg")] 
		public static const Frame:Class;
		[Embed(source = "assets/bg1.jpg")] 
		public static const Bg:Class;
		
		private static var _toysAtlas:TextureAtlas;
		private static var _fruitsAtlas:TextureAtlas;
		private static var _animalsAtlas:TextureAtlas;
		public static function getAtlas(groupName:String):TextureAtlas{
			var atlas:TextureAtlas;
			var texture:Texture;
			switch(groupName){
				case "toys":
					if(_toysAtlas == null){
						texture=  Texture.fromBitmap(new Assets.toys());
						_toysAtlas = new TextureAtlas(texture,new XML(new Assets.toys_xml()) as XML);
					}
					atlas = _toysAtlas;
					break;
				case "fruits":
					if(_fruitsAtlas == null){
						texture =  Texture.fromBitmap(new Assets.fruits());
						_fruitsAtlas = new TextureAtlas(texture,new XML(new Assets.fruits_xml()) as XML);
					}
					atlas = _fruitsAtlas;
					break;
				case "animals":
					if(_animalsAtlas == null){
						texture =  Texture.fromBitmap(new Assets.animals());
						_animalsAtlas = new TextureAtlas(texture,new XML(new Assets.animals_xml()) as XML);
					}
					atlas = _animalsAtlas;
					break;
			}
			
			return atlas;
		}
		
		public function Assets()
		{
		}
	}
}