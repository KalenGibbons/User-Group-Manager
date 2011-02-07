package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Meeting;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class MeetingDAO extends BaseDAO implements IDataAccess{
		
		public function MeetingDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function createTables():void{
			createMeetingsTable();
		}// end createTables function
		
		public function getAll():Array{
			var sql:String = 	"SELECT id, topic, date " +
								"FROM meetings " +
								"ORDER BY date DESC, id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getAll function
		
		public function saveMeeting(meeting:Meeting):Number{
			var sql:String =	"INSERT INTO meetings (topic, date) " +
								"VALUES(@TOPIC, @DATE)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@TOPIC"] =	meeting.topic;
			sqlStatement.parameters["@DATE"] = 	meeting.date;
			sqlStatement.execute();
			// get and return the id of the newly inserted row
			var sqlResult:SQLResult = sqlStatement.getResult();
			return sqlResult.lastInsertRowID;
		}// end savePerson function
			
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createMeetingsTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetings ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"topic VARCHAR(255), " +
								"date DATETIME NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingsTable function
		
	}// end public class MeetingDAO extends BaseDAO
	
}// end package enclosure