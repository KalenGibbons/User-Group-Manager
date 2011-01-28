package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Person;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class PersonDAO implements IDataAccess{
		
		private var _sqlConnection:SQLConnection;
		
		public function PersonDAO(){
			super();
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */

		public function createTables():void{
			createPeopleTable();
		}// end createTables function
		
		public function getAll():Array{
			var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM people";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return sqlStatement.getResult().data;
		}// end getAll function
		
		public function getPersonByID(id:int):Array{
			var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate" +
								"FROM people" +
								"WHERE id = @ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@ID"] = id;
			sqlStatement.execute();
			return sqlStatement.getResult().data;
		}// end getPersonByID function
		
		public function savePerson(person:Person):Number{
			var sql:String =	"INSERT INTO people (firstName, lastName, email, phone, twitter, facebook, createdDate)" +
								"VALUES(@FIRST_NAME, @LAST_NAME, @EMAIL, @PHONE, @TWITTER, @FACEBOOK, @createdDate)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = this.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@FIRST_NAME"] = 	person.firstName;
			sqlStatement.parameters["@LAST_NAME"] = 	person.lastName;
			sqlStatement.parameters["@EMAIL"] = 		person.email;
			sqlStatement.parameters["@PHONE"] =			person.phone;
			sqlStatement.parameters["@TWITTER"] = 		person.twitter;
			sqlStatement.parameters["@FACEBOOK"] =		person.facebook;
			sqlStatement.parameters["@createdDate"] = 	new Date();
			sqlStatement.execute();
			
			// get and return the id of the newly inserted row
			var sqlResult:SQLResult = sqlStatement.getResult();
			return sqlResult.lastInsertRowID;
		}// end savePerson function
		
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
		
		protected function createPeopleTable():void{
			var sql:String =	"CREATE TABLE IF NOT EXISTS people ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"firstName VARCHAR(50) NOT NULL, " +
								"lastName VARCHAR(50), " +
								"email VARCHAR(30), " +
								"phone VARCHAR(30), " +
								"twitter VARCHAR(50), " +
								"facebook VARCHAR(50), " + 
								"createdDate DATETIME NOT NULL)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createPeopleTable function
		
	}// end PersonDAO class
	
}// end package enclosure