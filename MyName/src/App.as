package
{
	import com.model.RoomData;
	import com.screens.Room;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
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
//			var img:Image=new Image(Texture.fromBitmap(new sky()));
//			addChild(img);
//			var frontt:Image=new Image(Texture.fromBitmap(new front()));
//			var backk:Image=new Image(Texture.fromBitmap(new back()));
//			addChild(backk);
//			backk.y=117;
//			frontt.alpha=0;
//			addChild(frontt);
//			var tween:Tween = new Tween(img, 12.0, Transitions.EASE_IN_OUT);
//			tween.animate("y", -950);
//			Starling.juggler.add(tween);
//			var atween:Tween = new Tween(frontt, 12.0, Transitions.EASE_IN_OUT);
//			atween.animate("alpha", 1);
//			Starling.juggler.add(atween);
		}
		
	}
}