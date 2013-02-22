package
{
	import com.controller.ScreenCreator;
	import com.model.ItemsGroup;
	import com.model.rawData.Toys;
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
			
			var screen:WhereIsScreen = addChild(new WhereIsScreen()) as WhereIsScreen;
			var model:ItemsGroup = new ItemsGroup(Toys.data);
			new ScreenCreator(model,screen);
		}
		
		
	}
}