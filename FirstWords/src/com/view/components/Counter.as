package com.view.components
{
	import com.view.playRoom.Book;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;

	public class Counter
	{
		private var _to:uint;
		private var _index:uint = 0;
		private var _delayCall:DelayedCall;
		public var done:Signal = new Signal();
		public var tick:Signal = new Signal();
		private var _soundStr:String = "../../../../assets/sounds/counter/count";
		private var _knockSound:Sound = new Sound(new URLRequest("../../../../assets/sounds/egg/knock.mp3")); ;
		public function Counter()
		{
		}
		
		public function count(to:uint,delay:uint=0):void{
			_index=0;	
			_to=to;
			if(delay>0){
				_delayCall = Starling.juggler.delayCall(progress,delay);
			}
		}
		
		public function progress():void{
			_index++;
			tick.dispatch();
			//var coundSound:Sound = new Sound(new URLRequest(_soundStr+_index.toString()+".mp3"));
			_knockSound.play();
			try{
				//coundSound.play();
			}catch(e:Error){
				
			}
			if(_index==_to){
				done.dispatch();
			}
		}
		
	}
}