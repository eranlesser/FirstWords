package com
{
	import com.food.ExplodedFood;
	import com.food.ExplodingFood;
	import com.food.Food;
	import com.levels.Level;
	import com.snake.Snake;
	import com.snake.Vertebra;
	import com.utils.filters.GlowFilter;
	
	import flash.geom.Point;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.events.Event;

	public class FoodController
	{
		private var _level:Level;
		private var _snake:Snake;
		private var _foods:Vector.<Food> = new Vector.<Food>();
		private var _normalFoodCounter:uint = 0;
		private var _completeCall:DelayedCall;
		public function FoodController(snake:Snake,level:Level)
		{
			_level=level;
			_snake=snake;
			_snake.moved.add(onSnakeMoved);
			addFood();
		}
		
		private function onSnakeMoved(p:Point):void
		{
			for each(var food:Food in _foods){
				if(food.x==p.x&&food.y==p.y){
					eat(food);
				}
			}
		}
		
		private function eat(food:Food):void{
			_snake.grow(food.growBy);
			_level.removeChild(food);
			_level.updateScore(food.score);
			_foods.splice(_foods.indexOf(food),1);
			switch(food.type){
				case Food.EXPLODING:
					addExplodedFood(new Point(food.x,food.y));
					break;
				case Food.EXPLODED:
					var hasExploded:Boolean=false;
					for each (var food:Food in _foods){
						if(food.type == Food.EXPLODED){
							hasExploded=true;
						}
					}
					if(hasExploded==false){
						addFood();
					}
					break;
				case Food.REGULAR:
					addFood();
					break;
			}
		}
		
		private function addExplodedFood(p:Point):void{
			for(var i:uint=0;i<12;i++){
				var food:Food = new ExplodedFood();
				setExplodedFoodLocation(food,p);
				_level.addChild(food);
				_foods.push(food);
				trace("expfood ",food.x,food.y)
			}
			_normalFoodCounter = 0;
			_completeCall = Starling.juggler.delayCall(completeBlink,9);
		}
		
		private function completeBlink():void{
			var food:Food;
			for(var i:int=_foods.length-1;i>=0;i--){
				food = _foods[i];
				_level.removeChild(food);
				_foods.splice(_foods.indexOf(food),1);
			}
			addFood();
		}
		
		
		
		//REGULAR FOOD _______________________
		private function addFood():void{
			var food:Food = getRandomFood();
			setFoodLocation(food);
			_level.addChild(food);
			_foods.push(food);
			_normalFoodCounter++;
			trace("food ",food.x,food.y)
		}
		
		private function setFoodLocation(food:Food):void{
			food.x= Snake.stepSize*Math.round(Math.random()*(Dimentions.WIDTH/Snake.stepSize));
			food.y= Snake.stepSize*Math.round(Math.random()*((Dimentions.HEIGHT/Snake.stepSize)-1));
			if(!isValid(food)){
				setFoodLocation(food);
			}
		}
		private function setExplodedFoodLocation(food:Food,p:Point):void{
			food.x= p.x - (Snake.stepSize*3) + Snake.stepSize*Math.round(Math.random()*6);
			food.y= p.y - (Snake.stepSize*3) + Snake.stepSize*Math.round(Math.random()*6);
			if(!isValid(food)){
				setExplodedFoodLocation(food,p);
			}
		}
		
		
		private function isValid(food:Food):Boolean{
			var valid:Boolean = true;
			for each (var v:Vertebra in _snake.vertebras){
				if(v.x==food.x&&v.y==food.y){
					valid = false;
					break
				}
			}
			for each (var f:Food in _foods){
				if(f.x==food.x&&f.y==food.y){
					valid = false;
					break
				}
			}
			if(_snake.head.x==food.x&&_snake.head.y==food.y){
				valid = false;
			}
			if(food.x<0 || food.y < 0 || food.x >= Dimentions.WIDTH || food.y>=Dimentions.HEIGHT){
				valid = false;
			}
			return valid;
		}
		
		private function getRandomFood():Food{
			var rand:Number = Math.random();
			var level:Number = 0;
			if(_normalFoodCounter>9){
				level = 0.6;
			}else if(_normalFoodCounter>6){
				level = 0.4;
			}else if(_normalFoodCounter>=3){
				level = 0.2;
			}
			trace("level=",level)
			if(rand>level){
				return new Food();
			}else{
				return new ExplodingFood();
			}
		}
		
		public function reset():void{
			_normalFoodCounter=0;
			while(_foods.length>0){
				_foods.pop().removeFromParent(true);
				if(_completeCall && !_completeCall.isComplete){
					Starling.juggler.remove(_completeCall);
				}
			}
			addFood();
		}
		
	}
}