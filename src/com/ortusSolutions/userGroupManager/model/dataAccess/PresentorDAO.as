package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import flash.data.SQLStatement;
	
	public class PresentorDAO extends BaseDAO implements IDataAccess{
		
		public function PresentorDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function createTables():void{
			createPresentorsTable();
		}// end createTables function
		
		public function getAll():Array{
			return null;
		}// end getAll function
		
		public function getPresentors(meetingID:Number):Array{
			var sql:String =	"SELECT	people.id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM 	people, meetingPresentors " +
								"WHERE 	people.id = meetingPresentors.presentor " +
								"	AND meetingPresentors.meeting = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = meetingID;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getPresentors function
		
		public function removeAllPresentors(meetingID:Number):void{
			var sql:String = 	"DELETE " +
								"FROM meetingPresentors " +
								"WHERE meeting = @meetingID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@meetingID"] = meetingID;
			sqlStatement.execute();
		}// end removeAllPresentors function
		
		public function addPresentor(meetingID:Number, presentorID:Number):void{
			var sql:String =	"INSERT INTO meetingPresentors (meeting, presentor)" +
								"VALUES(@MEETING, @PRESENTOR)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING"] = meetingID;
			sqlStatement.parameters["@PRESENTOR"] = presentorID;
			sqlStatement.execute();
		}// end addPresentor function
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createPresentorsTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingPresentors ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"presentor NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createPresentorsTable function
		
	}// end public class PresentorDAO extends BaseDAO implements IDataAccess
	
}// end package enclosure