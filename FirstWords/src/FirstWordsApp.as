package
{
	import com.controller.Progressor;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FirstWordsApp extends Sprite
	{
		public function FirstWordsApp()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			var progressor:Progressor = new Progressor(this);
			progressor.goHome();
			//progressor.goPlay();
		}
		
		
	}
}