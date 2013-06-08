package com.model.rawData
{
	import com.model.Session;
	
	import flash.utils.Dictionary;

	public class Texts
	{
		private var _hebTexts:Dictionary = new Dictionary();
		private var _engTexts:Dictionary = new Dictionary();
		public function Texts()
		{
			init();
		}
		
		private function init():void{
			_hebTexts["nav"]="תפריט";
			_hebTexts["about"]="אודות";
			_hebTexts["rateText"]="דרגו את האפליקציה וקבלו גישה חופשית לחדר המשחקים";
			_hebTexts["rate"]="דרג";
			_hebTexts["noThanks"]="לא תודה";
			_engTexts["nav"]="Screens";
			_engTexts["about"]="About";
			_engTexts["rateText"]="Rate us and get free play-room access";
			_engTexts["rate"]="Rate";
			_engTexts["noThanks"]="No Thanks";
		}
		
		public function getText(id:String):String{
			if(Session.lang=="israel"){
				return flip(_hebTexts[id]);
			}else{
				return _engTexts[id];
			}
		}
		
		private function flip(str:String):String{
			if(Session.lang!="israel"){
				return str;
			}
			var newStr:String = "";
			for(var i:int=str.length-1;i>=0;i--){
				newStr = newStr + str.charAt(i);
			}
			
			return newStr;
		}
		
		public function getAboutText(lang:String):String{
			var txt:String;
			switch(lang){
				case "eng":
					txt = "When we follow the general development of a baby, one observes that language and speech are primary components in the infant's development.  At the outset the baby pronounces parts of words or just gibberish.  As he continues to develop, at age one or two years, he expresses himself in complete words related to his surroundings and supporters. The first word the child acquires are connected to his immediate world such as: toys, pets, family members, body parts, clothing etc. He will pronounce words such as: daddy, mommy, ball (Teddy) bear, bottle, head, dog etc. When he is asked by to identify an object from pictures in books or in various choice games, he knows to choose the correct object even if he pronounces the words incorrectly. In this application we have concentrated on the baby's ability to identify individual objects in a picture showing a number of objects familiar to infants from their surroundings. The baby, from one and a half to two years old, is asked, by a pleasant voice, to point to a particular object in a group of pictures and when he touches the correct picture he receives positive reinforcement.  In the event he chooses incorrectly he will hear the correct name of the object sought and in this way will enlarge his vocabulary. The infant at this age is capable of learning new words every day and his vocabulary generally contains hundreds of words and this before he knows how to form words into sentences. This application is designed to aid you the parent to expose the infant to a variety of words thus enriching his language skills."
					break;
			}
			return txt;
		}
		
	}
}