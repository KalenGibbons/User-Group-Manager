package com.ortusSolutions.userGroupManager.model.services{

	import coldfusion.air.SessionToken;
	import coldfusion.air.SyncManager;
	
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	public class ConnectorService{
		
		private static var _databaseConnection:SQLConnection;
		private static var _databaseFile:File;
		private static var _syncManager:SyncManager;
		private static var _syncSession:SessionToken;
		
		public static function createDatabaseConnection(databaseName:String):void{
			_databaseFile = 			File.applicationStorageDirectory.resolvePath(databaseName);
			var fileExists:Boolean =	_databaseFile.exists;
			_databaseConnection = 		new SQLConnection();
			_databaseConnection.open(_databaseFile);
		}// end createDatabaseConnection function
		
		public static function createSyncConnection(cfPort:int, cfServer:String, syncCFC:String, destination:String="ColdFusion", sessionId:int=646464):void{
			_syncManager = 				new SyncManager();
			_syncManager.cfPort = 		cfPort;
			_syncManager.cfServer = 	cfServer;
			_syncManager.syncCFC = 		syncCFC;
			_syncManager.destination = 	destination;
			_syncSession = 				_syncManager.openSession(_databaseFile, sessionId);
		}// end createSyncConnection function
		
		/* ***************************************************************************************
		**									GETTER FUNCTIONS
		*************************************************************************************** */
		
		public static function get databaseConnection():SQLConnection{
			return _databaseConnection;
		}// end databaseConnection getter function
		
		public static function get databaseFile():File{
			return _databaseFile;
		}// end databaseFile getter function
		
		public static function get syncManager():SyncManager{
			return _syncManager;
		}// end syncManager getter function
		
		public static function get syncSession():SessionToken{
			return _syncSession;
		}// end syncSession getter function
		
	}// end ConnectorService class
	
}// end package enclosure