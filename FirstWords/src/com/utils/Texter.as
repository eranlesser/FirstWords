package com.utils
{
	public class Texter
	{
		public function Texter()
		{
		}
		
		public static function flip(str:String):String{
			var newStr:String = "";
			for(var i:int=str.length-1;i>=0;i--){
				trace(str.charAt(i),i,str.length)
				newStr = newStr + str.charAt(i);
			}
			
			return newStr;
		}
	}
}