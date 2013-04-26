package
{
	import com.model.RoomData;
	import com.screens.Room;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class App extends Sprite
	{
		public function App()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			//progressor.goPlay();
			addChild(new Room(new XML(RoomData.data)));
		}
		
	}
}