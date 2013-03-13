package com.controller
{
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.rawData.WhereIsData;
	import com.view.AbstractScreen;
	import com.view.HomeScreen;
	import com.view.PlayRoom;
	import com.view.WhereIsScene;
	import com.view.WhereIsScreen;
	
	import starling.display.Sprite;

	public class Progressor
	{
		
		private var _app:					Sprite;
		private var _screens:				ScreensModel;
		private var _homeScreen:			HomeScreen;
		private var _currentScreen:		    AbstractScreen;
		private var _playRoom:				PlayRoom;
		public function Progressor(app:Sprite)
		{
			_app = app;
			_screens = new ScreensModel(WhereIsData.data);
			_homeScreen = new HomeScreen(_screens);
		}
		
		public function goNext():void{
			removeScreen(_currentScreen);;
			_currentScreen = addScreen(_screens.getNext());
		}
		
		public function goTo(screenIndex:int):void{
			removeScreen(_currentScreen);
			_currentScreen = addScreen(_screens.getScreen(screenIndex));
		}
		
		public function goHome():void{
			if(_currentScreen){
				removeScreen(_currentScreen);
			}
			_app.addChild(_homeScreen);
			_currentScreen = _homeScreen;
			_homeScreen.gotoSignal.add(goTo);
		}
		
		private function removeScreen(screen:AbstractScreen):void{
			screen.done.remove(goNext);
			screen.goHome.remove(goHome);
			screen.destroy();
			_app.removeChild(screen);
		}
		
		private function addScreen(model:ScreenModel):AbstractScreen{
			var screen:AbstractScreen;
			switch(model.type){
				case "whereIsScreen":
					screen = new WhereIsScreen();
					break;
				case "whereScene":
					screen = new WhereIsScene();
					break;
				case "playRoom":
					if(!_playRoom){
						_playRoom = new PlayRoom();
					}
					screen = _playRoom;
					break;
			}
			screen.done.add(goNext);
			screen.goHome.add(goHome);
			screen.model = model;
			_app.addChild(screen);
			return screen;
		}
		
	}
}