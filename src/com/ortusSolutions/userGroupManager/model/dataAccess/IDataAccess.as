package com.ortusSolutions.userGroupManager.model.dataAccess{
	import flash.data.SQLConnection;
	
	public interface IDataAccess{
		
		function createTables():void;
		function getAll():Array;
		function get sqlConnection():SQLConnection;
		function set sqlConnection(connection:SQLConnection):void
		
	}// end public interface IDataAccess interface
	
}// end package enclosure