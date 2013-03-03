package com.controller
{
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.rawData.Toys;
	import com.model.rawData.WhereIsData;
	import com.view.HomeScreen;
	import com.view.PlayRoom;
	import com.view.WhereIsScreen;
	
	import starling.display.Sprite;

	public class Progressor
	{
		private var _whereIsScreen:			WhereIsScreen;
		private var _whereIsScreenCreator:	ScreenCreator;
		private var _app:					Sprite;
		private var _screens:				ScreensModel;
		private var _homeScreen:			HomeScreen;
		private var _playRoom:PlayRoom;
		public function Progressor(app:Sprite)
		{
			_app = app;
			_whereIsScreen = new WhereIsScreen();
			_screens = new ScreensModel(WhereIsData.data);
			_whereIsScreenCreator = new ScreenCreator(_whereIsScreen);
			_whereIsScreenCreator.done.add(goNext);
			_homeScreen = new HomeScreen(_screens);
			_homeScreen.gotoSignal.add(goTo);
			_playRoom = new PlayRoom();
		}
		
		public function goNext():void{
			setWhereIsScreen();
			_whereIsScreenCreator.model = _screens.getNext();
		}
		
		public function goTo(screenIndex:int):void{
			setWhereIsScreen();
			_whereIsScreenCreator.model = _screens.getScreen(screenIndex);
		}
		
		private function setWhereIsScreen():void{
			if(_homeScreen.parent == _app){
				_app.removeChild(_homeScreen);
			}
			if(_whereIsScreen.parent == null){
				_app.addChild(_whereIsScreen);
			}
		}
		
		public function goHome():void{
			_app.removeChildren();
			_app.addChild(_homeScreen);
		}
		
		public function goPlay():void{
			_app.removeChildren();
			_app.addChild(_playRoom);
		}
		
	}
}