package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.ScreenModel;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;

	public class CategoryIntroScreen extends AbstractScreen
	{
		public function CategoryIntroScreen()
		{
		}
		
		override public function set model(screenModel:ScreenModel):void{
			var bg:Image = new Image(Texture.fromBitmap(Assets.getImage(screenModel.backGround)));
			_screenLayer.addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			super.model = screenModel;
			Starling.juggler.delayCall(function(){done.dispatch()},5);
			var sound:Sound = new Sound(new URLRequest(screenModel.sound));
			sound.play();
		}
	}
}