package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#A68952")]
	public class FirstWords extends Sprite
	{
		
		
		private var _starling:Starling;
		public function FirstWords()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_starling = new Starling(FirstWordsApp,stage);
			_starling.start();
		}
	}
}