package com.view.playRoom
{
	import nape.callbacks.CbType;
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.display.Sprite;

	public class PlayItem
	{
		protected var _body:Body;
		protected var _material:Sprite;
		protected var _space:Space;
		public function PlayItem(space:Space,updateFunction:Function,cbType:CbType,xx:int,yy:int)
		{
			_space = space;
			createMaterial();
			createBody(updateFunction,cbType,xx,yy);
		}
		
		protected function createBody(updateFunction:Function,cbType:CbType,xx:int,yy:int):void{
			_body.space = _space;
			_body.userData.graphic = _material;
			_body.userData.graphicUpdate = updateFunction;
			_body.cbTypes.add(cbType);
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