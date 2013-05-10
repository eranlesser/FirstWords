package com.view
{
	import com.Dimentions;
	import com.model.Session;
	import com.utils.Texter;
	
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
		
		public function RateThisApp()
		{
			init();
		}
		
		private function init():void{
			var popupImg:Image = new Image(Texture.fromBitmap(new popup()));
			addChild(popupImg);
			var playRoomImg:Image = new Image(Texture.fromBitmap(new playRoom()));
			//addChild(playRoomImg);
			popupImg.width=Dimentions.WIDTH+8;
			popupImg.height=Dimentions.HEIGHT+8;
			popupImg.x=-4;
			popupImg.y=-4;
			var title:TextField = new TextField(800,100,Texter.flip("דרגו את האפליקציה וקבלו גישה חופשית לחדר המשחקים"),"Verdana",24,0x002661);
			title.autoScale=true;
			addChild(title);
			title.x=(Dimentions.WIDTH-title.width)/2
			title.y=80;
			var okBut:Button = new Button(Texture.fromBitmap(new btn()),Texter.flip("דרג"));
			okBut.fontSize=22;
			okBut.fontColor=0x003B94;
			var noBut:Button = new Button(Texture.fromBitmap(new btn()),Texter.flip("לא תודה"));
			noBut.fontSize=22;
			noBut.fontColor=0x003B94;
			addChild(okBut);
			addChild(noBut);
			okBut.y=title.y+title.height-22;
			noBut.y=title.y+title.height-22;
			noBut.x=Dimentions.WIDTH/2-noBut.width-22;
			okBut.x=Dimentions.WIDTH/2+22;
			noBut.addEventListener(Event.TRIGGERED,removeSelf);
			okBut.addEventListener(Event.TRIGGERED,
				function():void{
					removeSelf();
					Session.playRoomEnabled=true;
					var url:URLRequest = new URLRequest("https://itunes.apple.com/us/app/zywzym-r-swnym/id638720649?ls=1&mt=8");
					navigateToURL(url, "_blank");
				}
			);
			
		}
		
		private function removeSelf():void{
			this.removeFromParent(true);
		}
	}
}