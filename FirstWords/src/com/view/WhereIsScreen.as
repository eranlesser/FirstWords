package com.view
{
	import com.Assets;
	import com.model.Item;
	import com.model.WhereIsScreenModel;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class WhereIsScreen extends Sprite{
		private var _whoIs:Item;
		public function WhereIsScreen()
		{
		}
		
		public function setDistractors(items:Vector.<Item>, atlas:TextureAtlas):void{
			for each(var item:Item in items){
				addDistractor(item.image, atlas);
			}
		}
		
		public function setWhoIs(item:Item,atlas:TextureAtlas):void{
			_whoIs = item;
			addChild(new Image(atlas.getTexture(_whoIs.image)));
		}
		
		private function addDistractor(itemName:String,atlas:TextureAtlas):void
		{
			
			var airplane:Texture = atlas.getTexture(itemName);
			addChild(new Image(airplane));
			
		}
	}
}