package com.view.playRoom
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	
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
		private var _items:Vector.<MenuItem>;
		private var _atlas:TextureAtlas;
		public var itemDropped:Signal = new Signal();
		public static const HEIGHT:int = 90;
		public function Menu()
		{
			init()
		}
		
		public function set model(data:ScreenModel):void{
			_atlas = Assets.getAtlas(data.groupName);
			for each(var item:XML in data.menu.item){
				addMenuItem(item);
			}
		}
		
		private function init():void{
			addBg();
			_items = new Vector.<MenuItem>();
			
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
			//item.x = _items.indexOf(item) * (Menu.HEIGHT+2);
			//item.y = Dimentions.HEIGHT - HEIGHT - 2;
			item.removeFromParent(true);
		}
		
		private function addBg():void{
			var btmpData:BitmapData = new BitmapData(Dimentions.WIDTH,HEIGHT,false,0xFFFFFF);
			var bg:Bitmap = new Bitmap(btmpData);
			var img:DisplayObject = addChild(new Image(Texture.fromBitmap(bg)));
			img.y=Dimentions.HEIGHT - HEIGHT - 2;
		}
	}
}