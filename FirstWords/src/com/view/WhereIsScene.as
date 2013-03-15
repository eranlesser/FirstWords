package com.view
{
	import com.Assets;
	import com.Dimentions;
	import com.model.Item;
	import com.model.ScreenModel;
	import com.view.components.ParticlesEffect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class WhereIsScene extends AbstractScreen
	{
		private var _whereIsBtn:Button;
		public function WhereIsScene()
		{
			
		}
		private var _clics:uint=0;
		private var _resoult:String="";
		private var _x:uint;
		private var _y:uint;
		
		override public function set model(screenModel:ScreenModel):void{
			var bg:Image = new Image(Texture.fromBitmap(Assets.getImage(screenModel.backGround)));
			_screenLayer.addChild(bg);
			bg.width = Dimentions.WIDTH;
			bg.height = Dimentions.HEIGHT;
			super.model = screenModel;
			for(var i:uint=0;i<_model.numItems;i++){
				addItem(_model.distractor);
			}
			setItems();
			bg.addEventListener(TouchEvent.TOUCH,function onMouseDown(e:TouchEvent):void{
				var touch:Touch = e.getTouch(stage);
				if(touch && (touch.phase == TouchPhase.BEGAN)){
					_clics++;
					trace(_clics)
					if(_clics==1){
						_x=touch.globalX;
						_y=touch.globalY;
						_resoult = _resoult + _x.toString()+","+_y.toString()+",";
					}else if(_clics==2){
						_resoult = _resoult + Math.round(touch.globalX-_x).toString()+",";
					}else{
						_resoult = _resoult + Math.round(touch.globalY-_y).toString();
						trace(_resoult);
						_clics=0;
						_resoult="";
					}
					
				}
			});
		}
		
		override protected function setItems():Boolean{
			if(!super.setItems()){
				return false;
			}
			setWhoIs(_model.whoIsItem)
			return true;
		}
		
		private function setWhoIs(item:Item):void{
			if(_whereIsBtn){
				_screenLayer.removeChild(_whereIsBtn);
			}
			_whoIs = item;
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0x333333);
			shp.graphics.drawRect(0,0,item.rect.width,item.rect.height);
			shp.graphics.endFill();
			var btmData:BitmapData = new BitmapData(shp.width,shp.height);
			btmData.draw(shp);
			var img:Image = new Image(Texture.fromBitmapData(btmData));
			_whereIsBtn = new Button(img.texture);
			_whereIsBtn.x = item.rect.x;
			_whereIsBtn.y = item.rect.y;
			_screenLayer.addChild(_whereIsBtn);
			var chanel:SoundChannel = _whereSound.play();
			chanel.addEventListener(flash.events.Event.SOUND_COMPLETE,onWhereIsPlayed);
			_whereIsBtn.addEventListener(starling.events.Event.TRIGGERED,function onGood():void{
				if(onGoodClick()){
					_whereIsBtn.removeEventListener(starling.events.Event.TRIGGERED, onGood);
					_particlesEffect = new ParticlesEffect();
					_particlesEffect.width=img.width/10;
					_particlesEffect.height=img.height/10;
					_particlesEffect.x=img.x+img.width/2;
					_particlesEffect.y=img.y+img.height/2;
					_screenLayer.addChild(_particlesEffect);
					_particlesEffect.start("drug");
				}
			});
			_whereIsBtn.alpha=0.3;
			
			
		}
		
		
		private function addItem(item:Item):void{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(0xFFFFFF);
			shp.graphics.drawRect(0,0,item.rect.width,item.rect.height);
			shp.graphics.endFill();
			var btmData:BitmapData = new BitmapData(shp.width,shp.height);
			btmData.draw(shp);
			var img:Image = new Image(Texture.fromBitmapData(btmData));
			img.x = item.rect.x;
			img.y = item.rect.y;
			img.alpha=0.1;
			_screenLayer.addChild(img);
		}
	}
}