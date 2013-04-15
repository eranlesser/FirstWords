package com.controller
{
	import com.model.ScreenModel;
	import com.model.ScreensModel;
	import com.model.rawData.WhereIsData;
	import com.view.Egg;
	import com.view.HomeScreen;
	import com.view.IScreen;
	import com.view.PlayRoom;
	import com.view.Rain;
	import com.view.WhereIsScene;
	import com.view.WhereIsScreen;
	import com.view.menu.ConfigurationScreen;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class Progressor
	{
		
		private var _app:					Sprite;
		private var _screens:				ScreensModel;
		private var _homeScreen:			HomeScreen;
		private var _currentScreen:		    IScreen;
		private var _playRoom:				PlayRoom;
		private var _configScr:ConfigurationScreen;
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
			if(screenIndex==-1){
				if(!_configScr){
					_configScr = new ConfigurationScreen(_screens);
					_configScr.goHome.add(function():void{_app.removeChild(_configScr)});
					_configScr.gotoSignal.add(function onGoTo(indx:uint):void{
						_app.removeChild(_configScr);
						goTo(indx)
					
					});
				}
				_app.addChild(_configScr);
				_configScr.setSelectedScreen();
			}else if(screenIndex==-2){
				removeScreen(_currentScreen);
				_currentScreen = addScreen(_screens.getScreen(1));
			}else{
				removeScreen(_currentScreen);
				_currentScreen = addScreen(_screens.getScreen(screenIndex));
			}
		}
		
		public function goHome():void{
			if(_currentScreen){
				removeScreen(_currentScreen);
			}
			_app.addChild(_homeScreen);
			_currentScreen = _homeScreen;
			_homeScreen.gotoSignal.add(goTo);
		}
		
		private function removeScreen(screen:IScreen):void{
			screen.done.remove(goNext);
			screen.goHome.remove(goHome);
			screen.destroy();
			if(screen == _playRoom){
				_playRoom.visible = false;			
			}else{
				_app.removeChild(screen as DisplayObject);
			}
		}
		
		private function addScreen(model:ScreenModel):IScreen{
			var screen:IScreen;
			switch(model.type){
				case "whereIsScreen":
					screen = new WhereIsScreen();
					break;
				case "whereScene":
					screen = new WhereIsScene();
					break;
				case "egg":
					screen = new Egg();
					break;
				case "rain":
					screen = new Rain();
					break;
				case "playRoom":
					if(!_playRoom){
						_playRoom = new PlayRoom();
					}
					_playRoom.visible = true;
					screen = _playRoom;
					break;
			}
			screen.done.add(goNext);
			screen.goHome.add(goHome);
			screen.model = model;
			_app.addChild(screen as DisplayObject);
			if(screen == _playRoom){
				_playRoom.visible = true;
			}
			return screen;
		}
		
	}
}