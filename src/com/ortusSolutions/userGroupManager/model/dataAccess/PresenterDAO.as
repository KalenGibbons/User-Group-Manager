package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import flash.data.SQLStatement;
	
	public class PresenterDAO extends BaseDAO implements IDataAccess{
		
		public function PresenterDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function createTables():void{
			createPresentersTable();
		}// end createTables function
		
		public function getAll():Array{
			return null;
		}// end getAll function
		
		public function getPresenters(meetingID:Number):Array{
			var sql:String =	"SELECT	people.id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM 	people, meetingPresenters " +
								"WHERE 	people.id = meetingPresenters.presenter " +
								"	AND meetingPresenters.meeting = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = meetingID;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getPresenters function
		
		public function removeAllPresenters(meetingID:Number):void{
			var sql:String = 	"DELETE " +
								"FROM meetingPresenters " +
								"WHERE meeting = @meetingID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@meetingID"] = meetingID;
			sqlStatement.execute();
		}// end removeAllPresenters function
		
		public function addPresenter(meetingID:Number, presenterID:Number):void{
			var sql:String =	"INSERT INTO meetingPresenters (meeting, presenter)" +
								"VALUES(@MEETING, @PRESENTER)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING"] = meetingID;
			sqlStatement.parameters["@PRESENTER"] = presenterID;
			sqlStatement.execute();
		}// end addPresenter function
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createPresentersTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingPresenters ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"presenter INTEGER NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createPresentersTable function
		
	}// end public class PresenterDAO extends BaseDAO implements IDataAccess
	
}// end package enclosure