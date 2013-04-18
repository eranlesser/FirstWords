package com.model
{
	import com.freshplanet.nativeExtensions.Flurry;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.osflash.signals.Signal;

	public class Session
	{
		public static var currentScreen:int=0;
		public static var locked:Boolean = true;
		private static var _playRoomEnabled:Boolean = false;
		public static const FREE_SCREENS_COUNT:uint=4;
		public static var rightAnswer:uint=0;
		public static var wrongAnswer:uint=0;
		public static var changed:Signal = new Signal();
		public function Session()
		{
		}

		public static function get playRoomEnabled():Boolean
		{
			return _playRoomEnabled;
		}

		public static function set playRoomEnabled(value:Boolean):void
		{
			Flurry.getInstance().logEvent("playroomEnabled",value);
			_playRoomEnabled = value;
			changed.dispatch();
			exportSessionData(new XML(<playRoomEnabled>{value}</playRoomEnabled>));
		}
		
		public static function init():void{
			var inputFile:File = File.applicationStorageDirectory.resolvePath("sessions/userSession.xml") ;
			if(inputFile.exists){
				var inputStream:FileStream = new FileStream();
				inputStream.open(inputFile, FileMode.READ);
				var sessionXML:XML = XML(inputStream.readUTFBytes(inputStream.bytesAvailable));
				inputStream.close();
				if(sessionXML == "true"){
					//_playRoomEnabled = true;
					changed.dispatch();
				}
				trace("sessionXML",sessionXML);
			}
		}
		
		private static function exportSessionData(sessionXml:XML):void{
			var folder:File = File.applicationStorageDirectory.resolvePath("sessions");
			if (!folder.exists) { 
				folder.createDirectory();
			} 
			var outputFile:File = folder.resolvePath("userSession.xml");
			if(outputFile.exists){
				outputFile.deleteFile();
			}
			var outputStream:FileStream = new FileStream();
			outputStream.open(outputFile,FileMode.WRITE);
			var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			//outputString += '<userSession>\n';
			outputString += sessionXml.toXMLString()+'\n';
			//outputString += '</userSession>\n';
			outputStream.writeUTFBytes(outputString);
			outputStream.close();
		}

	}
}