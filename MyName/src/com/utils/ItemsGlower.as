package com.utils
{
	import com.utils.filters.GlowFilter;
	import com.view.RoomItem;
	
	import starling.core.Starling;

	public class ItemsGlower
	{
		private var _items:Vector.<CuedItem>;
		public function ItemsGlower()
		{
			_items = new Vector.<CuedItem>();
		}
		
		public function addItem(item:RoomItem,glowTime:Number):void{
			_items.push(new CuedItem(item,glowTime));
		}
		
		public function start():void{
			for each(var item:CuedItem in _items){
				Starling.juggler.delayCall(onCue,item.cue,item);
			}
		}
		
		private function onCue(item:CuedItem):void{
			//item.item.scaleX=1.1;
			//item.item.scaleY=1.1;
			//item.item.y=item.item.y+12;
			item.item.filter = new GlowFilter(0xFFFFFF,1,12,12);
			Starling.juggler.delayCall(function():void{
				//item.item.scaleX=1;
				//item.item.scaleY=1;
				//item.item.y=item.item.y-12;
				item.item.filter = null;
			},2);
		}
	}
}
import com.view.RoomItem;

class CuedItem{
	public var item:RoomItem;
	public var cue:Number;
	public function CuedItem(iitem:RoomItem,ccue:Number){
		item=iitem;
		cue=ccue;
	}
}