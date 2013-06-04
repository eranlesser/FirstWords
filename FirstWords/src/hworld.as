package
{
//	import com.freshplanet.nativeExtensions.Flurry;
	//import com.freshplanet.nativeExtensions.Flurry;
	import com.Dimentions;
	import com.model.Session;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	[SWF( frameRate="60", backgroundColor="#F2D399")]

	public class hworld extends Sprite
	{
		
		
		private var _starling:Starling;
		public function hworld()
		{
			super();
			if(stage){
				init(null);
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
			//var obj:DisplayObject =addChild(new Stats());
			//obj.y=80
			// support autoOrients
			
			//Flurry.getInstance().setIOSAPIKey("FGJG54WS4ZBX3DYR8T8Q");
			//Flurry.getInstance().startSession();
			
		}
		
		private function init(e:Event):void{
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			setDisplaySize();
			
			//starling = new Starling(Game, stage, viewPort);
			
			Starling.multitouchEnabled = true;
			_starling = new Starling(FirstWordsApp,stage,viewPort);
			_starling.start();
			Starling.current.nativeStage.align = StageAlign.TOP_LEFT;
			Starling.current.nativeStage.scaleMode = StageScaleMode.NO_SCALE;
			Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChange);
			
			Session.init();
		}
		
		private function setDisplaySize():void{
			var ratio:Number = Math.max(stage.fullScreenWidth,stage.fullScreenHeight) / Dimentions.WIDTH;
			Session.ratio = ratio;
			//_starling.stage.scaleX=ratio;
			//_starling.stage.scaleY=ratio;
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