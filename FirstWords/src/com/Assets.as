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
		
		[Embed(source = "assets/background.jpg")] 
		public static const BackgroundImage:Class;
		
		[Embed(source = "assets/frames1.jpg")] 
		public static const Frame:Class;
		[Embed(source = "assets/bg1.jpg")] 
		public static const Bg:Class;
		
		private static var _toysAtlas:TextureAtlas;
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
					if(_toysAtlas == null){
						texture =  Texture.fromBitmap(new Assets.toys());
						_toysAtlas = new TextureAtlas(texture,new XML(new Assets.toys_xml()) as XML);
					}
					atlas = _toysAtlas;
					break;
			}
			
			return atlas;
		}
		
		public function Assets()
		{
		}
	}
}