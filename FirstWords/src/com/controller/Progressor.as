package com.controller
{
	import com.model.ScreensModel;
	import com.model.rawData.WhereIsData;
	import com.view.HomeScreen;
	import com.view.PlayRoom;
	import com.view.WhereIsScreen;
	
	import starling.display.Sprite;

	public class Progressor
	{
		private var _whereIsScreen:			WhereIsScreen;
		private var _app:					Sprite;
		private var _screens:				ScreensModel;
		private var _homeScreen:			HomeScreen;
		private var _playRoom:				PlayRoom;
		
		public function Progressor(app:Sprite)
		{
			_app = app;
			_whereIsScreen = new WhereIsScreen();
			_screens = new ScreensModel(WhereIsData.data);
			_whereIsScreen.done.add(goNext);
			_whereIsScreen.goHome.add(goHome);
			_homeScreen = new HomeScreen(_screens);
			_homeScreen.gotoSignal.add(goTo);
			_playRoom = new PlayRoom();
			_playRoom.done.add(goNext);
		}
		
		public function goNext():void{
			if(_whereIsScreen.parent == _app){
				_app.removeChild(_whereIsScreen);
				goPlay();
			}else{
				setWhereIsScreen();
				_whereIsScreen.model = _screens.getNext();
			}
		}
		
		public function goTo(screenIndex:int):void{
			setWhereIsScreen();
			_whereIsScreen.model = _screens.getScreen(screenIndex);
		}
		
		private function setWhereIsScreen():void{
			if(_playRoom.parent == _app){
				_app.removeChild(_playRoom);
			}
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