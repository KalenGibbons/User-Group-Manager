package com.ortusSolutions.userGroupManager.config{
	
	import com.ortusSolutions.userGroupManager.control.CoreController;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.model.services.CoreService;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	import com.ortusSolutions.userGroupManager.model.services.PersonService;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	
	public class CoreConfig{
		
		
		
		
		
		// Settings
		public var applicationName:String =			Settings.APPLICATION_NAME;
		public var databaseName:String = 			Settings.DATABASE_NAME;
		public var dateFormat:String = 				Settings.DATE_FORMAT;
		
		// model - services
		public var coreService:CoreService;
		public var personService:PersonService;
		public var meetingService:MeetingService;
		
		// model - data access
		public var personDAO:PersonDAO;
		public var meetingDAO:MeetingDAO;

		// model - vo
		public var person:Person = 					new Person();
		
		// data
		public var people:ArrayCollection = 		new ArrayCollection();
		public var meetings:ArrayCollection =		new ArrayCollection();
		
		// controller
		public var coreController:CoreController;

		// other
		public var dbConnection:SQLConnection;
		
		
		public function CoreConfig(){
			coreService = new CoreService(databaseName);
			dbConnection = coreService.getBaseConnection();
			personDAO = new PersonDAO();
			meetingDAO = new MeetingDAO();
			personService = new PersonService();
			meetingService = new MeetingService();
			coreController = new CoreController();
		}// end constructor
		
	}// end CoreConfig class
	
}// end package enclosure