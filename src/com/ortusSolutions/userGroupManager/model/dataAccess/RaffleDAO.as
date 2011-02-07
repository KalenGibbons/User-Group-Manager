package com.ortusSolutions.userGroupManager.model.dataAccess{
	
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
		}// end createTables function
		
		public function getAll():Array{
			return null;
		}// end getAll function
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		protected function createRaffleTable():void{
			var sql:String = 	"CREATE TABLE IF NOT EXISTS meetingRaffles ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"meeting INTEGER NOT NULL, " +
								"raffle NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createMeetingRafflesTable function
		
	}// end public class RaffleDAO extends BaseDAO implements IDataAccess
	
}// end package enclosure