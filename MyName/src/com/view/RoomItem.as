package com.view
{
	import com.model.ItemModel;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class RoomItem extends Sprite
	{
		[Embed(source = "assets/frame.png")] 
		private const frame:Class;
		
		
		private var _model:ItemModel;
		private var _state:String;
		public static const MENU_STATE:uint=0;
		public static const DRAGGED_STATE:uint=1;
		public static const ON_STAGE_STATE:uint=2;
		private var _thumbImage:Image;
		private var _onStageImage:Image;
		private var _bg:Image;
		public function RoomItem(thmb:Image,img:Image,itemModel:ItemModel)
		{
			_bg = new Image(Texture.fromBitmap(new frame()));
			addChild(_bg);
			_bg.alpha = 0.5;
			_thumbImage=thmb//new Image(_atlas.getTexture("small_"+itemModel.texture));
			_model = itemModel;
			addChild(_thumbImage);
			_thumbImage.x=(_bg.width-_thumbImage.width)/2;
			_thumbImage.y=(_bg.height-_thumbImage.height)/2;
			_onStageImage = img//new Image(_atlas.getTexture(itemModel.texture));
			addChild(_onStageImage);
			_onStageImage.visible=false;
			
		}
		
		
		
		public function get model():ItemModel{
			return _model
		}
		
		public function set state(stateIndex:uint):void{
			switch(stateIndex){
				case MENU_STATE:
					_onStageImage.visible=false;
					_thumbImage.visible=true;
					_bg.visible=true;
					break;
				case ON_STAGE_STATE:
					_onStageImage.visible=true;
					_thumbImage.visible=false;
					_bg.visible=false;
					break;
			}
		}
	}
}