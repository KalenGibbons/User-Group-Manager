package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import flash.data.SQLStatement;
	
	public class AttendeeDAO extends BaseDAO implements IDataAccess{
		
		public function AttendeeDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function createTables():void{
			createAttendeesTable();
		}// end createTables function
		
		public function getAll():Array{
			return null;
		}// end getAll function
		
		public function getAttendees(meetingID:Number):Array{
			var sql:String =	"SELECT	people.id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM 	people, meetingAttendees " +
								"WHERE 	people.id = meetingAttendees.attendee " +
								"	AND meetingAttendees.meeting = @MEETING_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = meetingID;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getAttendees function	
		
		public function removeAllAttendees(meetingID:Number):void{
			var sql:String = 	"DELETE " +
								"FROM meetingAttendees " +
								"WHERE meeting = @meetingID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@meetingID"] = meetingID;
			sqlStatement.execute();
		}// end removeAllAttendees function
		
		public function addAttendee(meetingID:Number, attendeeID:Number):void{
			var sql:String =	"INSERT INTO meetingAttendees (meeting, attendee)" +
								"VALUES(@MEETING, @ATTENDEE)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING"] = meetingID;
			sqlStatement.parameters["@ATTENDEE"] = attendeeID;
			sqlStatement.execute();
		}// end addAttendee function
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createAttendeesTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingAttendees ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"attendee INTEGER NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createAttendeesTable function
		
		
	}// end public class AttendeeDAO extends BaseDAO implements IDataAccess
	
}// end package enclosure