package com.view.components
{
	import com.Dimentions;
	
	import flash.display.Bitmap;
	import flash.net.getClassByAlias;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Clouds extends Sprite
	{
		[Embed(source="../../../assets/home/clouds1.png")]
		private var clouds1:Class;
		[Embed(source="../../../assets/home/cloud2.png")]
		private var clouds2:Class;
		[Embed(source="../../../assets/home/cloud3.png")]
		private var clouds3:Class;
		[Embed(source="../../../assets/home/cloud4.png")]
		private var clouds4:Class;
		[Embed(source="../../../assets/home/cloud5.png")]
		private var clouds5:Class;
		[Embed(source="../../../assets/home/cloud6.png")]
		private var clouds6:Class;
		[Embed(source="../../../assets/home/cloud7.png")]
		private var clouds7:Class;
		public function Clouds()
		{
			var call:DelayedCall = Starling.juggler.delayCall(addCloud,5);
			call.repeatCount = 0;
			setClouds();
		}
		
		private function setClouds():void{
			for(var i:uint=0;i<3;i++){
				var cloud:Image;
				var randomCloud:Number = Math.random();
				if(randomCloud<0.1){
					cloud = Image.fromBitmap(new clouds1());
				}else if(randomCloud<0.2){
					cloud = Image.fromBitmap(new clouds2());
				}else if(randomCloud<0.3){
					cloud = Image.fromBitmap(new clouds3());
				}else if(randomCloud<0.4){
					cloud = Image.fromBitmap(new clouds4());
				}else if(randomCloud<0.5){
					cloud = Image.fromBitmap(new clouds5());
				}else if(randomCloud<0.6){
					cloud = Image.fromBitmap(new clouds6());
				}else if(randomCloud<0.7){
					cloud = Image.fromBitmap(new clouds7());
				}else if(randomCloud<0.8){
					cloud = Image.fromBitmap(new clouds4());
				}else if(randomCloud<0.9){
					cloud = Image.fromBitmap(new clouds3());
				}else if(randomCloud<1){
					cloud = Image.fromBitmap(new clouds2());
				}
				addChild(cloud);
				var xx:int = Dimentions.WIDTH*Math.random()+200;
				cloud.x = xx;
				cloud.y = Math.random()*Dimentions.HEIGHT/10;
				cloud.alpha=Math.random();
				Starling.juggler.tween(cloud,Math.random()*4+22,{x:xx-Dimentions.WIDTH});
			}
		}
		
		private function addCloud():void{
			var cloud:Image;
			var randomCloud:Number = Math.random();
			if(randomCloud<0.1){
				cloud = Image.fromBitmap(new clouds1());
			}else if(randomCloud<0.2){
				cloud = Image.fromBitmap(new clouds2());
			}else if(randomCloud<0.3){
				cloud = Image.fromBitmap(new clouds3());
			}else if(randomCloud<0.4){
				cloud = Image.fromBitmap(new clouds4());
			}else if(randomCloud<0.5){
				cloud = Image.fromBitmap(new clouds5());
			}else if(randomCloud<0.6){
				cloud = Image.fromBitmap(new clouds6());
			}else if(randomCloud<0.7){
				cloud = Image.fromBitmap(new clouds7());
			}else if(randomCloud<0.8){
				cloud = Image.fromBitmap(new clouds4());
			}else if(randomCloud<0.9){
				cloud = Image.fromBitmap(new clouds3());
			}else if(randomCloud<1){
				cloud = Image.fromBitmap(new clouds2());
			}
			addChild(cloud);
			cloud.x = Dimentions.WIDTH;
			cloud.y = Math.random()*Dimentions.HEIGHT/10;
			cloud.alpha=Math.random();
			Starling.juggler.tween(cloud,Math.random()*4+22,{x:-cloud.width,onComplete: function():void { cloud.removeFromParent(true); }});
		}
	}
}