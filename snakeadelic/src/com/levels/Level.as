package com.levels
{
	import com.BoundriesCollisionDetector;
	import com.Dimentions;
	import com.FoodController;
	import com.MovementController;
	import com.snake.Snake;
	
	import flash.geom.Point;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Level extends Sprite
	{
		
		private var _snake:Snake;
		private var _updater:DelayedCall;
		private var _score:TextField;
		private var _foodController:FoodController;
		[Embed(source="assets/restart.png")]
		private  const restart:Class;
		public function Level(){
			init();
		}
		
		private function init():void{
			_snake = new Snake(new Point(0,160),2);
			addChild(_snake);
			new MovementController(_snake,this);
			new BoundriesCollisionDetector(_snake,this);
			_foodController = new FoodController(_snake,this);
			_updater = Starling.juggler.delayCall(update,0.1);
			_updater.repeatCount=0;
			_score = new TextField(120,30,"0","Verdana",18);
			_score.x=Dimentions.WIDTH-_score.width;
			addChild(_score);
		}
		
		public function updateScore(add:int):void{
			_score.text = (int(_score.text)+add).toString();
		}
		
		private function update():void{
			_snake.update();
		}
		
		public function set snakeDirection(direction:uint):void{
			_snake.direction = direction;
		}
		
		public function fail():void{
			//removeChild(_snake);
			Starling.juggler.remove(_updater);
			var endText:TextField = new TextField(300,200,"GAME OVER","Verdana",40);
			endText.x = (Dimentions.WIDTH-endText.width)/2;
			endText.y = (Dimentions.HEIGHT-endText.height)/2-30;
			addChild(endText);
			
			var restartBut:Button = new Button(Texture.fromBitmap(new restart()));
			addChild(restartBut);
			
			restartBut.x = (Dimentions.WIDTH-restartBut.width)/2;
			restartBut.y = (Dimentions.HEIGHT-restartBut.height)/2+30;
			addChild(restartBut);
			restartBut.addEventListener(Event.TRIGGERED,function rg():void{
				_snake.reset();
				_updater = Starling.juggler.delayCall(update,0.2);
				_updater.repeatCount=0;	
				removeChild(restartBut);
				removeChild(endText);
				_foodController.reset();
				_score.text="0";
			}
			);
		}
		
	}
}