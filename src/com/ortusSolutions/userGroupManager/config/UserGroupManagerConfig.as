package com.ortusSolutions.userGroupManager.config{
	
	import com.ortusSolutions.userGroupManager.commands.LoadPeopleCommand;
	import com.ortusSolutions.userGroupManager.commands.SavePersonCommand;
	import com.ortusSolutions.userGroupManager.model.BaseDAO;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.PersonDAO;
	
	import mx.collections.ArrayCollection;
	
	public class UserGroupManagerConfig{
		
		// Settings
		public var applicationName:String =	Settings.APPLICATION_NAME;
		public var databaseName:String = 	Settings.DATABASE_NAME;
		public var dateFormat:String = 		Settings.DATE_FORMAT;
		
		// model
		public var baseDAO:BaseDAO = 		new BaseDAO();
		public var person:Person = 			new Person();
		public var personDAO:PersonDAO = 	new PersonDAO();
		
		// data
		public var people:ArrayCollection = new ArrayCollection();
		
		// commands
		public var savePersonCommand:SavePersonCommand = new SavePersonCommand();
		public var loadPeopleCommand:LoadPeopleCommand = new LoadPeopleCommand();
		
		public function UserGroupManagerConfig(){
		}// end constructor
		
	}// end UserGroupManagerConfig class
	
}// end package enclosure