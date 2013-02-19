package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
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