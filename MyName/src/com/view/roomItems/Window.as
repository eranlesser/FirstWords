package com.view.roomItems
{
	
	import com.utils.filters.GlowFilter;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	public class Window extends Sprite{
		private var sun:DisplayObject;
		function Window(atlas:TextureAtlas):void{
			addChild(new Image(atlas.getTexture("day_window")));
			sun = addChild(new Image(atlas.getTexture("sun")));
			sun.x=20;
			sun.y=34;
		}
		
		public function sunRise():void{
			var tween:Tween = new Tween(sun,2);
			tween.animate("y",30);
			tween.animate("x", 44);
			tween.onComplete = function():void{
				Starling.juggler.remove(tween);
				sun.filter = null;
				var tween2:Tween = new Tween(sun,2);
				tween2.animate("y",20);
				tween2.animate("x", 34);
				Starling.juggler.add(tween2);
			}
			//tween.animate("rotation", 4);
			Starling.juggler.add(tween);
			sun.filter = new GlowFilter(0xFFFF44,1,12,12);
		}
		
	}
}