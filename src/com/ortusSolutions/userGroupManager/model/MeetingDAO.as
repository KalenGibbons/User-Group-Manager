package com.ortusSolutions.userGroupManager.model{
	
	
	public class MeetingDAO extends BaseDAO{
		
		public function MeetingDAO(){
			super();
		}// end constructor
		
		// TODO : Add service layer for transactioning (if available) all calls
		
		public function getAll():Array{
			/*var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM Meeting";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return sqlStatement.getResult().data;*/
		}// end getAll function
		
		public function savePerson(person:Person):void{
			/*var sql:String = 
				"INSERT INTO people (firstName, lastName, email, phone, twitter, facebook, createdDate)" +
				"VALUES(@FIRST_NAME, @LAST_NAME, @EMAIL, @PHONE, @TWITTER, @FACEBOOK, @createdDate)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@FIRST_NAME"] = 	person.firstName;
			sqlStatement.parameters["@LAST_NAME"] = 	person.lastName;
			sqlStatement.parameters["@EMAIL"] = 		person.email;
			sqlStatement.parameters["@PHONE"] =			person.phone;
			sqlStatement.parameters["@TWITTER"] = 		person.twitter;
			sqlStatement.parameters["@FACEBOOK"] =		person.facebook;
			sqlStatement.parameters["@createdDate"] = 	new Date();
			sqlStatement.execute();
			person.isLoaded = true;*/
		}// end savePerson function
		
		override protected function createDatabase():void{
			createMeetingsTable();
			// create join tables
			createMeetingPresentorsTable();
			createMeetingAttendeesTable();
			createMeetingRafflesTable();
		}// end createDatabase function
		
		private function createMeetingsTable():void{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS meetings ( "+
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"topic VARCHAR(255), " +
				"date DATETIME NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingsTable function
		
		private function createMeetingPresentorsTable():void{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS meetingPresentors ( "+
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"meeting INTEGER NOT NULL, " +
				"presentor NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingPresentorsTable function
		
		private function createMeetingAttendeesTable():void{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS meetingAttendees ( "+
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"meeting INTEGER NOT NULL, " +
				"person NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingAttendeesTable function
		
		private function createMeetingRafflesTable():void{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS meetingRaffles ( "+
				"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
				"meeting INTEGER NOT NULL, " +
				"raffle NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingRafflesTable function
		
	}// end public class MeetingDAO extends BaseDAO
	
}// end package enclosure