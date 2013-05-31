package com.utils
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;

	public class NameNarator
	{
		private var _calls:Vector.<DelayedCall>;
		private var _sound:Sound;
		public function NameNarator(soundFile:String)
		{
			_calls = new Vector.<DelayedCall>();
			_sound = new Sound(new URLRequest(soundFile));
		}
		
		public function play(cuePoints:Vector.<Number>):void{
			for each(var cue:Number in cuePoints){
				_calls.push(Starling.juggler.delayCall(onCue,cue));
			}
		}
		
		private function onCue():void{
			_sound.play();
		}
	}
}