package com.ortusSolutions.userGroupManager.model{
	
	import flash.data.SQLStatement;
	
	public class PersonDAO extends BaseDAO{
		
		// TODO : Organize the functions of this class by type and alphabetically
		
		public function PersonDAO(){
			super();
		}// end constructor
		
		public function getAll():Array{
			var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate " +
								"FROM people";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = super.sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.execute();
			return sqlStatement.getResult().data;
		}// end getAll function
		
		public function savePerson(person:Person):void{
			var sql:String = 
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
			person.isLoaded = true;
		}// end savePerson function
		
		public function getPersonByID(id:int):Person{
			var sql:String = 	"SELECT id, firstName, lastName, email, phone, twitter, facebook, createdDate" +
								"FROM people" +
								"WHERE id = @ID";
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = sql;
			sqlStatement.parameters["@ID"] = id;
			sqlStatement.execute();
			var results:Array = sqlStatement.getResult().data;
			return (results && results.length == 1) ? processPerson(results[0]) : null;
		}// end getPersonByID function
		
		protected function processPerson(value:Object):Person{
			var person:Person = new Person().populate(value) as Person;
			person.isLoaded = true;
			return person;
		}// end processPerson function
		
		override protected function createDatabase():void{
			var sql:String = 
				"CREATE TABLE IF NOT EXISTS people ( "+
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
		}// end createDatabase function
		
	}// end PersonDAO class
	
}// end package enclosure