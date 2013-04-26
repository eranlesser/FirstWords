package com.view
{
	import com.model.ItemModel;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class MenuItem extends Sprite
	{
		[Embed(source = "assets/frame.png")] 
		private const frame:Class;
		
		
		private var _model:ItemModel;
		private var _state:String;
		public static const MENU_STATE:uint=0;
		public static const DRAGGED_STATE:uint=1;
		public static const ON_STAGE_STATE:uint=2;
		private var _image:Image;
		public function MenuItem(texture:Texture,itemModel:ItemModel)
		{
			var bg:Image = new Image(Texture.fromBitmap(new frame()));
			addChild(bg);
			_image=new Image(texture);
			_model = itemModel;
			addChild(_image);
			_image.x=(bg.width-_image.width)/2;
			_image.y=(bg.height-_image.height)/2;
		}
		
		public function get model():ItemModel{
			return _model
		}
	}
}