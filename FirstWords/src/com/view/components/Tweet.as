package com.view.components
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Tweet extends Sprite
	{
		[Embed(source="../../../assets/tweets/group1.png")]
		private var birds : Class;
		public function Tweet(bg:String,tweets:XML)
		{
			addChild(new Image(Texture.fromBitmap(new birds())));
		}
	}
}
import starling.display.Image;
import starling.display.Sprite;

class TweetNote extends Sprite{
	public function TweetNote(img:Image,xx:int,yy:int,soundFile:String){
		
	}
	
}