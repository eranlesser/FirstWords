package
{
	import com.controller.Progressor;
	import com.controller.ScreenCreator;
	import com.model.ScreenModel;
	import com.model.rawData.Toys;
	import com.view.HomeScreen;
	import com.view.WhereIsScreen;
	
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
			//progressor.goHome();
			progressor.goPlay();
		}
		
		
	}
}