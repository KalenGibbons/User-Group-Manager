package com.ortusSolutions.userGroupManager.model.services{

	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	public class ConnectorService{
		
		public static function createDatabaseConnection(databaseName:String):SQLConnection{
			var sqlConnection:SQLConnection = new SQLConnection();
			var dbFile:File = File.applicationStorageDirectory.resolvePath(databaseName);
			var fileExists:Boolean = dbFile.exists;
			sqlConnection.open(dbFile);
			return sqlConnection;
		}// end createDatabaseConnection function
		
	}// end ConnectorService class
	
}// end package enclosure