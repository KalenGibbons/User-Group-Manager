package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Meeting;
	
	import flash.data.SQLConnection;
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
								"WHERE isActive = 1 " +
								"ORDER BY date DESC, id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getAll function
		
		public function getRecentMeetings(count:int):Array{
			var sql:String = 	"SELECT TOP @MEETING_COUNT id, topic, date " +
								"FROM meetings " +
								"WHERE isActive = 1 " +
								"ORDER BY date DESC, id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_COUNT"] = count;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getRecentMeetings function
		
		public function getMeetingsByUser(user:int):Array{
			var sql:String = 	"SELECT meetings.id, topic, date " +
								"FROM 	meetings, meetingAttendees " +
								"WHERE 	meetings.id = meetingAttendees.meeting " +
								"	AND attendee = @USER_ID " +
								"ORDER BY meetings.id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@USER_ID"] = user;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getMeetingsByUser function
		
		public function getMeetingByID(id:int):Array{
			var sql:String = 	"SELECT id, topic, date " +
								"FROM meetings " +
								"WHERE id = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = id;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getMeetingByID function
		
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
		
		public function editMeeting(meeting:Meeting):void{
			var sql:String =	"UPDATE meetings " +
								"SET	topic = @TOPIC, " +
								"		date = @DATE " +
								"WHERE 	id = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@TOPIC"] =			meeting.topic;
			sqlStatement.parameters["@DATE"] = 			meeting.date;
			sqlStatement.parameters["@MEETING_ID"] = 	meeting.id;
			sqlStatement.execute();
		}// end editMeeting function
		
		public function deleteMeeting(meeting:Meeting):void{
			var sql:String =	"UPDATE meetings " +
								"SET	isActive = 0 " +
								"WHERE	id = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = meeting.id;
			sqlStatement.execute();
		}// end deleteMeeting function
			
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createMeetingsTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetings ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"topic VARCHAR(255), " +
								"date DATETIME NOT NULL, " +
								"isActive INTEGER NOT NULL DEFAULT 1)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingsTable function
		
	}// end public class MeetingDAO extends BaseDAO
	
}// end package enclosure