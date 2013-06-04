package com.model.rawData
{
	public class Transportation
	{
		public function Transportation()
		{
		}
		
		
		public static var data:XML = 
			<data type="whereScene" backGround="transportation"  thumbNail="transportationTmb">
				<item   groupId="boat" qsound="190.mp3" asound="191.mp3">
					<rect vector="10,10,500,380"/>
				</item>
				<item  qsound="184.mp3" asound="185.mp3" groupId="car">
					<rect vector="505,10,500,380"/>
				</item>
				<item  qsound="188.mp3" asound="189.mp3" groupId="truck">
					<rect vector="10,390,500,380"/>
				</item>
				<item  qsound="186.mp3" asound="187.mp3" groupId="plane">
					<rect vector="505,390,500,380"/>
				</item>
			</data>;
	}
}