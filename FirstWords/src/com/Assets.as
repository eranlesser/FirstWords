package com
{	
	import flash.display.Bitmap;
	
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
		
		[Embed(source = "assets/bgStripe1.jpg")] 
		public static const BackgroundImage:Class;
		
		[Embed(source = "assets/frames1.jpg")] 
		public static const Frame:Class;
		
		[Embed(source = "assets/home/room_backround.PNG")] 
		public static const roomThumb:Class;
		
		[Embed(source = "assets/whereIsScene/animals1.jpg")] 
		private static const animals1:Class;
		
		private static var _toysAtlas:TextureAtlas;
		private static var _fruitsAtlas:TextureAtlas;
		private static var _animalsAtlas:TextureAtlas;
		private static var _assets:Vector.<Asset>;
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
		
		public static function getImage(name:String):Bitmap{
			var btmp:Bitmap;
			for each(var asset:Asset in _assets){
				if(asset.name == name){
					btmp = asset.bitMap;
					break;
				}
			}
			return btmp;
		}
		
		public static function load():void{
			_assets = new Vector.<Asset>()
			_assets.push(new Asset("animals1",new animals1()));
		}
		
		public function Assets()
		{
			
		}
	}
}
import flash.display.Bitmap;


class Asset{
	public var name:String;
	public var bitMap:Bitmap;
	public function Asset(nme:String,btmp:Bitmap){
		name = nme;
		bitMap = btmp;
	}
}