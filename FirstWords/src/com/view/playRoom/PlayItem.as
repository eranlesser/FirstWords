package com.view.playRoom
{
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.display.Sprite;

	public class PlayItem
	{
		protected var _body:Body;
		protected var _material:Sprite;
		protected var _space:Space;
		public function PlayItem(space:Space,updateFunction:Function)
		{
			_space = space;
			createMaterial();
			createBody(updateFunction);
		}
		
		protected function createBody(updateFunction:Function):void{
			_body.space = _space;
			_body.userData.graphic = _material;
			_body.userData.graphicUpdate = updateFunction;
		}
		
		protected function createMaterial():void{
			
		}
		
		public function get userData():*{
			return _body.userData;
		}
		
		public function get material():Sprite{
			return _material;
		}
	}
}