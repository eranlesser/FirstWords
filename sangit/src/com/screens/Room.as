package com.screens
{
	import com.Dimentions;
	import com.model.ItemModel;
	import com.view.ItemsMenu;
	import com.view.MenuItem;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Room extends Sprite
	{
		[Embed(source="assets/room.xml", mimeType="application/octet-stream")]
		private  const room_xml:Class;
		
		[Embed(source="assets/room.png")]
		private  const room:Class;
		
		
		private var _atlas:TextureAtlas;
		private var _menu:ItemsMenu;
		private var _window:Window;
		public function Room(data:XML)
		{
			super();
			var texture:Texture=  Texture.fromBitmap(new room());
			_atlas = new TextureAtlas(texture,new XML(new room_xml()) as XML);
			_window = new Window(_atlas);
			addChild(_window);
			_window.x=58;
			_window.y=56;
			addChild(new Image(_atlas.getTexture("empty_room")));
			var lamp:Button = new Button(_atlas.getTexture("lamp_on"));
			lamp.x=463;
			lamp.y=95;
			addChild(lamp);
			lamp.addEventListener(Event.TRIGGERED,function():void{
				if(lamp.alpha==0){
					lamp.alpha=1;
				}else{
					lamp.alpha=0;
				}
			});
			_menu = new ItemsMenu();
			addChild(_menu);
			_menu.y = Dimentions.HEIGHT - ItemsMenu.ITEM_WIDTH-10;
			parse(data)
		}
		
		private function parse(xml:XML):void{
			var itemModel:ItemModel;
			var i:uint=0;
			for each(var item:XML in xml.item){
				itemModel = new ItemModel(item)
				itemModel.menuIndex = i;
				i++;
				_menu.addItem(new MenuItem(_atlas.getTexture("small_"+itemModel.texture),itemModel));
			}
		}
	}
}

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.TextureAtlas;

class Window extends Sprite{
	function Window(atlas:TextureAtlas):void{
		addChild(new Image(atlas.getTexture("day_window")));
		var sun:DisplayObject = addChild(new Image(atlas.getTexture("sun")));
		sun.x=20;
		sun.y=34;
	}
}