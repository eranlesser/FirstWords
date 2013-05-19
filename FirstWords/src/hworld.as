package
{
//	import com.freshplanet.nativeExtensions.Flurry;
	import com.model.Session;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.StageOrientationEvent;
	
	import org.gestouch.core.Gestouch;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingTouchHitTester;
	import org.gestouch.input.NativeInputAdapter;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#F2D399")]
	public class hworld extends Sprite
	{
		
		
		private var _starling:Starling;
		public function hworld()
		{
			super();
			//var obj:DisplayObject =addChild(new Stats());
			//obj.y=80
			// support autoOrients
			Starling.multitouchEnabled = true;
			_starling = new Starling(FirstWordsApp,stage);
			_starling.start();
			Starling.current.nativeStage.align = StageAlign.TOP_LEFT;
			Starling.current.nativeStage.scaleMode = StageScaleMode.NO_SCALE;
			//Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
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
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChange);
			
			// NB! Use Gestouch#removeTouchHitTester() method if you manage multiple Starling instances during
			// your application lifetime.
			Session.init();
			//Flurry.getInstance().setIOSAPIKey("FGJG54WS4ZBX3DYR8T8Q");
			//Flurry.getInstance().startSession();
		}
		
		private function orientationChange(e:StageOrientationEvent):void{
			//onOrientationChanged(e.afterOrientation);
			if (e.afterOrientation != StageOrientation.ROTATED_LEFT && e.afterOrientation != StageOrientation.ROTATED_RIGHT)
			{
				e.preventDefault();
			}
		}
	}
	
	
}