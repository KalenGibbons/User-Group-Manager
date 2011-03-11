package com.ortusSolutions.userGroupManager.model.dataAccess{
	
	import com.ortusSolutions.userGroupManager.model.Person;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	public class PersonDAO extends BaseDAO implements IDataAccess{
		
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
								"FROM people " +
								"WHERE isActive = 1 " +
								"ORDER BY firstname, lastName, id";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getAll function
		
		public function getPersonByID(id:int):Array{
			var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM people " +
								"WHERE id = @ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@ID"] = id;
			sqlStatement.execute();
			return getQueryResults(sqlStatement);
		}// end getPersonByID function
		
		public function savePerson(person:Person):Number{
			var sql:String =	"INSERT INTO people (firstName, lastName, email, phone, twitter, facebook, createdDate)" +
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
			
			// get and return the id of the newly inserted row
			var sqlResult:SQLResult = sqlStatement.getResult();
			return sqlResult.lastInsertRowID;
		}// end savePerson function
		
		public function editPerson(person:Person):void{
			var sql:String =	"UPDATE people " +
								"SET	firstName = @FIRST_NAME, " +
								"		lastName = @LAST_NAME, " +
								"		email = @EMAIL, " +
								"		phone = @PHONE, " +
								"		twitter = @TWITTER, " +
								"		facebook = @FACEBOOK " +
								"WHERE 	id = @USER_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@USER_ID"] = 		person.id;
			sqlStatement.parameters["@FIRST_NAME"] = 	person.firstName;
			sqlStatement.parameters["@LAST_NAME"] = 	person.lastName;
			sqlStatement.parameters["@EMAIL"] = 		person.email;
			sqlStatement.parameters["@PHONE"] =			person.phone;
			sqlStatement.parameters["@TWITTER"] = 		person.twitter;
			sqlStatement.parameters["@FACEBOOK"] =		person.facebook;
			sqlStatement.execute();
		}// end editPerson function
		
		public function deletePerson(person:Person):void{
			var sql:String =	"UPDATE people " +
								"SET	isActive = 0 " +
								"WHERE	id = @USER_ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@USER_ID"] = person.id;
			sqlStatement.execute();
		}// end deletePerson function
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		protected function createPeopleTable():void{
			var sql:String =	"CREATE TABLE IF NOT EXISTS people ( "+
								"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
								"firstName VARCHAR(50) NOT NULL, " +
								"lastName VARCHAR(50), " +
								"email VARCHAR(50), " +
								"phone VARCHAR(30), " +
								"twitter VARCHAR(50), " +
								"facebook VARCHAR(50), " + 
								"createdDate DATETIME NOT NULL, " +
								"isActive INTEGER NOT NULL DEFAULT 1)";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
		}// end createPeopleTable function
		
	}// end PersonDAO class
	
}// end package enclosure