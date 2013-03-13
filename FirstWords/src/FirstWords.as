package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import org.gestouch.core.Gestouch;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingTouchHitTester;
	import org.gestouch.input.NativeInputAdapter;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	

	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#FFFFFF")]
	public class FirstWords extends Sprite
	{
		
		
		private var _starling:Starling;
		public function FirstWords()
		{
			super();
			//addChild(new Stats());
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_starling = new Starling(FirstWordsApp,stage);
			_starling.start();
			// Gestouch initialization step 1 of 3:
			
			// Initialize native (default) input adapter. Needed for non-DisplayList usage.
			
			Gestouch.inputAdapter ||= new NativeInputAdapter(stage);
			
			
			// Gestouch initialization step 2 of 3:
			// Register instance of StarlingDisplayListAdapter to be used for objects of type starling.display.DisplayObject.
			// What it does: helps to build hierarchy (chain of parents) for any Starling display object and
			// acts as a adapter for gesture target to provide strong-typed access to methods like globalToLocal() and contains().
			
			Gestouch.addDisplayListAdapter(DisplayObject, new StarlingDisplayListAdapter());
			
			
			// Gestouch initialization step 3 of 3:
			// Initialize and register StarlingTouchHitTester.
			// What it does: finds appropriate target for the new touches (uses Starling Stage#hitTest() method)
			// What does “-1” mean: priority for this hit-tester. Since Stage3D layer sits behind native DisplayList
			// we give it lower priority in the sense of interactivity.
			
			Gestouch.addTouchHitTester(new StarlingTouchHitTester(_starling), -1);
			
			// NB! Use Gestouch#removeTouchHitTester() method if you manage multiple Starling instances during
			// your application lifetime.
		}
	}
}