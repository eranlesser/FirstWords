package com
{	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
		[Embed(source="assets/toys1/toys1.xml", mimeType="application/octet-stream")]
		public static const toys1_xml:Class;
		
		[Embed(source="assets/toys1/toys1.png")]
		public static const toys1:Class;
		
		[Embed(source="assets/fruits.xml", mimeType="application/octet-stream")]
		public static const fruits_xml:Class;
		
		[Embed(source="assets/fruits.jpg")]
		public static const fruits:Class;
		[Embed(source="assets/animals.xml", mimeType="application/octet-stream")]
		public static const animals_xml:Class;
		
		[Embed(source="assets/animals.jpg")]
		public static const animals:Class;
		
		[Embed(source = "assets/bg/bgStripe1.jpg")] 
		public static const BackgroundImage:Class;
		
		[Embed(source = "assets/frames1.jpg")] 
		public static const Frame:Class;
		
		[Embed(source = "assets/home/room_backround.PNG")] 
		public static const roomThumb:Class;
		
		[Embed(source = "assets/whereIsScene/animals1.png")] 
		private static const animals1:Class;

		[Embed(source = "assets/bg/flowersBg.png")] 
		private static const bottomStripe1:Class;
		[Embed(source = "assets/bg/grass_bg.png")] 
		private static const bottomStripe2:Class;
		[Embed(source = "assets/bg/grassBg2.png")] 
		private static const bottomStripe3:Class;
		[Embed(source = "assets/bg/flowersStripe1.png")] 
		private static const bottomStripe4:Class;
		[Embed(source = "assets/bg/flowersStripe2.png")] 
		private static const bottomStripe5:Class;
		[Embed(source = "assets/bg/flowersStripe3.png")] 
		private static const bottomStripe6:Class;
		[Embed(source = "assets/bg/flowersStripe4.png")] 
		private static const bottomStripe7:Class;
		[Embed(source = "assets/bg/flowersStripe5.png")] 
		private static const bottomStripe8:Class;
		
		private static var _toysAtlas:TextureAtlas;
		private static var _fruitsAtlas:TextureAtlas;
		private static var _animalsAtlas:TextureAtlas;
		private static var _assets:Vector.<Asset>;
		private static var _bottomStripe:Vector.<Asset>;
		public static function getAtlas(groupName:String):TextureAtlas{
			var atlas:TextureAtlas;
			var texture:Texture;
			switch(groupName){
				case "toys1":
					if(_toysAtlas == null){
						texture=  Texture.fromBitmap(new Assets.toys1());
						_toysAtlas = new TextureAtlas(texture,new XML(new Assets.toys1_xml()) as XML);
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
			
			_bottomStripe = new Vector.<Asset>();
			_bottomStripe.push(new Asset("bottomStripe1",new bottomStripe1()));
			_bottomStripe.push(new Asset("bottomStripe2",new bottomStripe2()));
			_bottomStripe.push(new Asset("bottomStripe3",new bottomStripe3()));
			_bottomStripe.push(new Asset("bottomStripe4",new bottomStripe4()));
			_bottomStripe.push(new Asset("bottomStripe5",new bottomStripe5()));
			_bottomStripe.push(new Asset("bottomStripe6",new bottomStripe6()));
			_bottomStripe.push(new Asset("bottomStripe7",new bottomStripe7()));
			_bottomStripe.push(new Asset("bottomStripe8",new bottomStripe8()));
			
		}
		
		public static function get bottomStripe():Bitmap{
			return _bottomStripe[Math.min(Math.floor(Math.random()*(_bottomStripe.length)),_bottomStripe.length-1)].bitMap
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