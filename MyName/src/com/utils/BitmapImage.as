package com.utils
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class BitmapImage extends Image
	{
		private var mBitmap:Bitmap;
		
		public function BitmapImage(bitmap:Bitmap)
		{
			mBitmap = bitmap;
			super(Texture.fromBitmap(bitmap));
		}
		
		public override function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
		{
			// on a touch test, invisible or untouchable objects cause the test to fail
			if (forTouch && (!visible || !touchable)) return null;
			
			// otherwise, check bounding box ...
			if (getBounds(this).containsPoint(localPoint))
			{
				// ... and bitmap alpha.
				var clr:uint = mBitmap.bitmapData.getPixel32(localPoint.x,localPoint.y);
				
				if (Color.getAlpha(clr) > 10) return this;
				else return null;
			}
			else return null;
		}
	}
}