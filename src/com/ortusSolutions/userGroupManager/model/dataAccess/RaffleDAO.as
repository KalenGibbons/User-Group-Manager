package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Raffle;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class RaffleDAO extends BaseDAO implements IDataAccess{
		
		public function RaffleDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		public function createTables():void{
			createRaffleTable();
			createMeetingRaffleTable();
		}// end createTables function
		
		public function getAll():Array{
			var sql:String = 	"SELECT id, prize, winner, type, created " +
								"FROM 	raffles " +
								"WHERE	isActive = 1 " +
								"ORDER BY id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getAll function
		
		public function getRafflesByMeeting(meeting:int):Array{
			var sql:String = 	"SELECT raffles.id, prize, winner, type, created " +
								"FROM 	raffles, meetingRaffles " +
								"WHERE 	raffles.id = meetingRaffles.raffle " +
								"	AND	meetingRaffles.meeting = @MEETING_ID " +
								"ORDER BY raffles.id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = meeting;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getRafflesByMeeting function
		
		public function getRafflesByUser(user:int):Array{
			var sql:String = 	"SELECT id, prize, winner, type, created " +
								"FROM 	raffles " +
								"WHERE 	winner = @USER_ID " +
								"ORDER BY raffles.id DESC";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@USER_ID"] = user;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getRafflesByUser function
		
		public function getRaffleMeetingID(raffle:Raffle):int{
			var meetingID:int;
			var sql:String =	"Select meeting " +
								"FROM 	meetingRaffles " +
								"WHERE 	raffle = @RAFFLE_ID";
			var sqlStatement:SQLStatement = new SQLStatement;
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@RAFFLE_ID"] = raffle.id;
			sqlStatement.execute();
			var results:Array = getQueryResults(sqlStatement);
			if(results != null && results.length > 0){
				meetingID = results[0].meeting;
			}
			return meetingID; 
		}// end getRaffleMeetingID function
		
		public function saveRaffle(raffle:Raffle):Number{
			var sql:String =	"INSERT INTO raffles (prize, winner, type) " +
								"VALUES(@PRIZE, @WINNER, @TYPE)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@PRIZE"] = 	raffle.prize;
			sqlStatement.parameters["@WINNER"] = 	raffle.winner.id;
			sqlStatement.parameters["@TYPE"] = 		raffle.raffleType;
			sqlStatement.execute();
			
			// get and return the id of the newly inserted row
			var sqlResult:SQLResult = sqlStatement.getResult();
			return sqlResult.lastInsertRowID;
		}// end saveRaffle function
		
		public function saveMeetingRaffle(raffleID:int, meetingID:int):void{
			var sql:String =	"INSERT INTO meetingRaffles (meeting, raffle) " +
								"VALUES(@MEETING_ID, @RAFFLE_ID)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@MEETING_ID"] = 	meetingID;
			sqlStatement.parameters["@RAFFLE_ID"] = 	raffleID;
			sqlStatement.execute();
		}// end saveMeetingRaffle function
		
		public function deleteRaffle(raffle:Raffle):void{
			var sql:String =	"UPDATE raffles " +
								"SET	isActive = 0 " +
								"WHERE	id = @RAFFLE_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@RAFFLE_ID"] = raffle.id;
			sqlStatement.execute();
		}// end deleteRaffle function
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createRaffleTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS raffles ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"prize VARCHAR(255) NOT NULL, " +
								"winner INTEGER NOT NULL, " +
								"type INTEGER NOT NULL, " +
								"created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, " +
								"isActive INTEGER NOT NULL DEFAULT 1)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingRafflesTable function
		
		protected function createMeetingRaffleTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingRaffles ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"raffle INTEGER NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingRafflesTable function
		
	}// end public class RaffleDAO extends BaseDAO implements IDataAccess
	
}// end package enclosure