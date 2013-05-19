package com.model.rawData
{
	public class Transportation
	{
		public function Transportation()
		{
		}
		
		
		public static var data:XML = 
			<data type="whereScene" backGround="transportation"  thumbNail="transportationTmb">
				<item   groupId="struck" qsound="90.mp3" asound="91.mp3">
					<rect vector="10,10,500,380"/>
				</item>
				<item  qsound="92.mp3" asound="93.mp3" groupId="boat">
					<rect vector="505,10,500,380"/>
				</item>
				<item  qsound="94.mp3" asound="95.mp3" groupId="car">
					<rect vector="10,390,500,380"/>
				</item>
				<item  qsound="96.mp3" asound="97.mp3" groupId="plane">
					<rect vector="505,390,500,380"/>
				</item>
			</data>;
	}
}