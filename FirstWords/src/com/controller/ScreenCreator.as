package com.controller
{
	import com.Assets;
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.view.WhereIsScreen;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class ScreenCreator
	{
		private var _view:WhereIsScreen;
		private var _model:ScreenModel;
		private var _counter:uint=0;
		public var done:Signal = new Signal();
		public function ScreenCreator(view:WhereIsScreen){
			_view = view;
			_view.refresh.add(setItems);
			
		}
		
		public function set model(group:ScreenModel):void{
			_model=group;
			setItems();
		}
		
		private function reset():void{
			_view.clear();
			_model.clear();
			var bg:Image = new Image(Texture.fromBitmap(new Assets.Bg()));
			_view.addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
		}
		
		private function setItems():void{
			reset();
			if(_counter>=_model.numItems){
				_view.complete();
				done.dispatch();
				return;
			}
			_view.setWhoIs(_model.whoIsItem,Assets.getAtlas(_model.groupName));
			var items:Vector.<Item> = new Vector.<Item>();
			items.push(_model.distractor);
			items.push(_model.distractor);
			_view.setDistractors(items,Assets.getAtlas(_model.groupName));
			_counter++;
		}
	}
}