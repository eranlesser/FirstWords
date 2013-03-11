package com.model
{
	public class ScreensModel
	{
		private var _screens:Vector.<ScreenModel>;
		private var _index:int=0;
		public function ScreensModel(data:XML)
		{
			_screens = new Vector.<ScreenModel>();
			for each(var screen:XML in data.screens.data){
				_screens.push(new ScreenModel(screen));
			}
		}
		
		public function getNext():ScreenModel{
			_index++;
			var  scr:ScreenModel = _screens[_index];
			return scr;
		}
		
		public function getScreen(indx:int):ScreenModel{
			_index = indx;
			return _screens[indx];
		}
		
		public function get screens():Vector.<ScreenModel>{
			return _screens;
		}
		
	}
}