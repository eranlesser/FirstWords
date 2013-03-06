package com.view.playRoom
{
	import com.Assets;
	import com.Dimentions;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Menu extends Sprite
	{
		private var _data:XML;
		private var _items:Vector.<MenuItem>;
		private var _atlas:TextureAtlas;
		public var itemDropped:Signal = new Signal();
		public static const HEIGHT:int = 90;
		public function Menu(data:XML)
		{
			_data = data;
			init()
		}
		
		private function init():void{
			addBg();
			_atlas = Assets.getAtlas(_data.menu.@atlas);
			_items = new Vector.<MenuItem>();
			for each(var item:XML in _data.menu.item){
				addMenuItem(item);
			}
		}
		
		private function addMenuItem(item:XML):void{
			var menuItem:MenuItem = new MenuItem(_atlas.getTexture(item.@image),item.@image);
			addChild(menuItem);
			menuItem.x = _items.length * (Menu.HEIGHT+2);
			menuItem.y = Dimentions.HEIGHT - HEIGHT - 2;
			_items.push(menuItem);
			menuItem.dropped.add(dropped);
		}
		private function dropped(x:int,y:int,item:MenuItem):void{
			itemDropped.dispatch(x,y,item.id);
			item.x = _items.indexOf(item) * (Menu.HEIGHT+2);
			item.y = Dimentions.HEIGHT - HEIGHT - 2;
		}
		
		private function addBg():void{
			var btmpData:BitmapData = new BitmapData(Dimentions.WIDTH,HEIGHT,false,0xFFFFFF);
			var bg:Bitmap = new Bitmap(btmpData);
			var img:DisplayObject = addChild(new Image(Texture.fromBitmap(bg)));
			img.y=Dimentions.HEIGHT - HEIGHT - 2;
		}
	}
}