package com
{
	import com.levels.Level;
	import com.snake.Snake;
	import com.snake.Vertebra;
	
	import flash.geom.Point;

	public class BoundriesCollisionDetector
	{
		private var _level:Level;
		private var _snake:Snake;
		public function BoundriesCollisionDetector(snake:Snake,level:Level){
			_level=level;
			_snake = snake;
			snake.moved.add(checkCollisions);
		}
		
		private function checkCollisions(p:Point):void
		{
			if(p.x<0 || p.y<0 || p.x> Dimentions.WIDTH - Snake.stepSize || p.y>Dimentions.HEIGHT-Snake.stepSize){
				_level.fail();
			}
			for each(var v:Vertebra in _snake.vertebras){
				if(v.x==p.x && v.y==p.y){
					_level.fail();
				}
			}
			
		}
	}
}