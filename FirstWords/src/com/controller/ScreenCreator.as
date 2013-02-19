package com.controller
{
	import com.Assets;
	import com.model.Item;
	import com.model.WhereIsScreenModel;
	import com.view.WhereIsScreen;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ScreenCreator
	{
		private var _model:WhereIsScreenModel;
		private var _view:WhereIsScreen;
		public function ScreenCreator(model:WhereIsScreenModel,view:WhereIsScreen){
			
			view.setWhoIs(new Item(<item image="airplane1" sound="airplane.mp3"  />),Assets.getAtlas("toys"))
		}
		
		public function addWhoIs():void{
			
		}
		
		public function addDistractors():void{
			//var v:Vector.<Item> = new Vector.<Item>();
			//v.push();
		}
	}
}