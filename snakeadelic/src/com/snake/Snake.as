package com.snake
{
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Sprite;
	
	
	public class Snake extends Sprite{
		private var _head:Head;
		private var _vertebras:Array;
		public static const stepSize:uint=32;
		private var _direction:uint=Keyboard.RIGHT;
		private var _initLocation:Point;
		private var _initSize:uint;
		public var moved:Signal = new Signal();
		public function Snake(initLocation:Point,initSize:uint){
			_vertebras = new Array();
			_initLocation = initLocation;
			_initSize=initSize;
			init();
		}
		
		private function init():void{
			_head = new Head();
			addChild(_head);
			_head.location = _initLocation;
			grow(_initSize);
			for(var i:uint = 0;i<=_initSize;i++){
				move();
			}
		}
		public function get vertebras():Array{
			return _vertebras;
		}
		
		public function get head():Head{
			return _head;
		}
		
		
		public function get direction():uint{
			return _direction;
		}
		public function set direction(dir:uint):void{
			_direction = dir;
		}
		
		public function grow(by:uint):void{
			for(var i:uint=0;i<by;i++){
				var vertb:Vertebra = new Vertebra();
				addChild(vertb);
				_vertebras.push(vertb);
				updadeLocation();
			}
		}
		private function shrink():void{
			var ver:Vertebra = _vertebras.pop();
			removeChild(ver);
		}
		public function update():void{
			move();
		}
		public function get location():Point{
			return _head.location;
		}
		public function reset():void{
			destroy();
			init();
		}
		public function destroy():void{
			visible=false;
			while(_vertebras.length>0){
				shrink();
			}
			_direction=Keyboard.RIGHT;
			removeChild(_head);
			visible=true;
		}
		
		protected function move():void{
			var p:Point=_head.location;
			switch(_direction){
				case Keyboard.UP:
					p.y-=stepSize;
					break;
				case Keyboard.DOWN:
					p.y+=stepSize;
					break;
				case Keyboard.LEFT:
					p.x-=stepSize;
					break;
				case Keyboard.RIGHT:
					p.x+=stepSize;
					break;
			}
			_head.location = p;
			updadeLocation();
			moved.dispatch(_head.location);
		}
		
		private function updadeLocation():void{
			Vertebra(_vertebras[0]).location = _head.oldLocation;
			for(var i:uint=1;i<_vertebras.length;i++){
				Vertebra(_vertebras[i]).location = Vertebra(_vertebras[i-1]).oldLocation;
			}
		}
	}
}