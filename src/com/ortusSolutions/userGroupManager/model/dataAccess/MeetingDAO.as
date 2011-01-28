package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class MeetingDAO implements IDataAccess{
		
		private var _sqlConnection:SQLConnection;
		
		public function MeetingDAO(){
			super();
		}// end constructor
		
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function getAll():Array{
			var sql:String = 	"SELECT id, topic, date " +
								"FROM meetings";
			// TODO : Load relationships too
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return sqlStatement.getResult().data;
		}// end getAll function
		
		public function saveMeeting(meeting:Meeting):Number{
			var sql:String =	"INSERT INTO meetings (topic, date) " +
								"VALUES(@TOPIC, @DATE)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@TOPIC"] =	meeting.topic;
			sqlStatement.parameters["@DATE"] = 	meeting.date;
			sqlStatement.execute();
			
			// get and return the id of the newly inserted row
			var sqlResult:SQLResult = sqlStatement.getResult();
			return sqlResult.lastInsertRowID;
		}// end savePerson function
		
		public function removeAllAttendees(meetingID:Number):void{
			var sql:String = 	"DELETE " +
								"FROM meetingAttendees " +
								"WHERE meeting = @meetingID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@meetingID"] = meetingID;
			sqlStatement.execute();
		}// end removeAllAttendees function
		
		public function addAttendee(meetingID:Number, attendeeID:Number):void{
			var sql:String =	"INSERT INTO meetingAttendees (meeting, person)" +
								"VALUES(@MEETING, @ATTENDEE)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING"] = meetingID;
			sqlStatement.parameters["@ATTENDEE"] = attendeeID;
			sqlStatement.execute();
		}// end addAttendee function
		
		public function removeAllPresentors(meetingID:Number):void{
			var sql:String = 	"DELETE " +
								"FROM meetingPresentors " +
								"WHERE meeting = @meetingID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@meetingID"] = meetingID;
			sqlStatement.execute();
		}// end removeAllPresentors function
		
		public function addPresentor(meetingID:Number, presentorID:Number):void{
			var sql:String =	"INSERT INTO meetingPresentors (meeting, presentor)" +
								"VALUES(@MEETING, @PRESENTOR)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING"] = meetingID;
			sqlStatement.parameters["@PRESENTOR"] = presentorID;
			sqlStatement.execute();
		}// end addPresentor function
		
		public function createTables():void{
			createMeetingsTable();
			// create join tables
			createMeetingPresentorsTable();
			createMeetingAttendeesTable();
			createMeetingRafflesTable();
		}// end createTables function
		
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
		
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createMeetingsTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetings ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"topic VARCHAR(255), " +
								"date DATETIME NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingsTable function
		
		protected function createMeetingPresentorsTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingPresentors ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"presentor NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingPresentorsTable function
		
		protected function createMeetingAttendeesTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingAttendees ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"person NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingAttendeesTable function
		
		protected function createMeetingRafflesTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingRaffles ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"raffle NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingRafflesTable function
		
	}// end public class MeetingDAO extends BaseDAO
	
}// end package enclosure