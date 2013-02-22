package com.controller
{
	import com.Assets;
	import com.model.Item;
	import com.model.ItemsGroup;
	import com.view.WhereIsScreen;

	public class ScreenCreator
	{
		private var _view:WhereIsScreen;
		private var _model:ItemsGroup;
		private var _counter:uint=0;
		public function ScreenCreator(model:ItemsGroup,view:WhereIsScreen){
			_view = view;
			_model=model;
			_view.refresh.add(setItems);
			//view.setWhoIs(new Item(<item image="airplane1" sound="airplane.mp3"  />),Assets.getAtlas("toys"));
			setItems();
		}
		
		private function setItems():void{
			
			_view.clear();
			_model.clear();
			if(_counter>=8){
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