package com.view
{
	import com.Dimentions;
	import com.model.Session;
	import com.model.rawData.Texts;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class RateThisApp extends Sprite
	{
		[Embed(source = "../../assets/playroom.png")] 
		private static const playRoom:Class;
		
		[Embed(source = "../../assets/popup.png")] 
		private static const popup:Class;
		
		[Embed(source = "../../assets/btn.png")] 
		private static const btn:Class;
		private var _texts:Texts;
		private var _rateTitle:TextField;
		private var _okBut:Button;
		private var _noThanksBut:Button;
		public function RateThisApp()
		{
			init();
		}
		
		private function init():void{
			_texts = new Texts();
			var popupImg:Image = new Image(Texture.fromBitmap(new popup()));
			addChild(popupImg);
			var playRoomImg:Image = new Image(Texture.fromBitmap(new playRoom()));
			//addChild(playRoomImg);
			popupImg.width=Dimentions.WIDTH+8;
			popupImg.height=Dimentions.HEIGHT+8;
			popupImg.x=-4;
			popupImg.y=-4;
			_rateTitle = new TextField(800,100,_texts.getText("rateText"),"Verdana",24,0x002661);
			_rateTitle.autoScale=true;
			addChild(_rateTitle);
			_rateTitle.x=(Dimentions.WIDTH-_rateTitle.width)/2
			_rateTitle.y=80;
			_okBut = new Button(Texture.fromBitmap(new btn()),_texts.getText("rate"));
			_okBut.fontSize=22;
			_okBut.fontColor=0x003B94;
			_noThanksBut = new Button(Texture.fromBitmap(new btn()),_texts.getText("noThanks"));
			_noThanksBut.fontSize=22;
			_noThanksBut.fontColor=0x003B94;
			addChild(_okBut);
			addChild(_noThanksBut);
			_okBut.y=_rateTitle.y+_rateTitle.height-22;
			_noThanksBut.y=_rateTitle.y+_rateTitle.height-22;
			_noThanksBut.x=Dimentions.WIDTH/2-_noThanksBut.width-22;
			_okBut.x=Dimentions.WIDTH/2+22;
			_noThanksBut.addEventListener(Event.TRIGGERED,removeSelf);
			_okBut.addEventListener(Event.TRIGGERED,
				function():void{
					removeSelf();
					Session.playRoomEnabled=true;
					var url:URLRequest = new URLRequest("https://itunes.apple.com/us/app/zywzym-r-swnym/id638720649?ls=1&mt=8");
					navigateToURL(url, "_blank");
				}
			);
			Session.langChanged.add(setTexts);
		}
		
		private function setTexts():void{
			_rateTitle.text = _texts.getText("rateText");
			_okBut.text = _texts.getText("rate");
			_noThanksBut.text = _texts.getText("noThanks");
		}
		
		private function removeSelf():void{
			this.removeFromParent(true);
		}
	}
}