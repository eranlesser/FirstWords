package com.view.utils
{
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;

	public class SoundPlayer
	{
		private var _sounds:Vector.<Sound> = new Vector.<Sound>();
		
		public function SoundPlayer()
		{
		}
		
		public function getSound(prefix:String,soundStr:String):Sound{
			var sound:Sound = new Sound(new URLRequest(prefix+"/heb/"+soundStr));
			return sound;
		}
		
		public function stopSounds():void{
			SoundMixer.stopAll();
		}
	}
}