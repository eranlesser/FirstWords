package com
{
	
	import com.levels.Level;
	import com.snake.Snake;
	
	import flash.ui.Keyboard;
	
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class MovementController{
		private var _snake:Snake;
		private var _level:Level;
		public function MovementController(snake:Snake,level:Level){
			_snake = snake;
			level.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			_level=level;
		}
		private function onAdded(e:Event):void{
			Level(e.target).stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			
		}
		private function onKeyDown(e:KeyboardEvent):void{
			//_snake.direction = e.keyCode;
			_level.snakeDirection = e.keyCode;
		}
	}
}