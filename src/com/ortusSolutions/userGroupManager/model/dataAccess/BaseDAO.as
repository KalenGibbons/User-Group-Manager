package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class BaseDAO{
		
		private var _sqlConnection:SQLConnection;

		public function BaseDAO(){
		}// end constructor
		
		/* ***************************************************************************************
		**									GETTERS AND SETTERS
		*************************************************************************************** */
		
		public function get sqlConnection():SQLConnection{
			return _sqlConnection;
		}// end sqlConnection getter
		
		[Inject]
		public function set sqlConnection(connection:SQLConnection):void{
			_sqlConnection = connection;
		}// end sqlConnection setter
		
		protected function getQueryResults(statement:SQLStatement):Array{
			var results:SQLResult = statement.getResult();
			return (results.data) ? results.data : [];
		}// end getQueryResults function
		
	}// end public class BaseDAO
	
}// end package enclosure