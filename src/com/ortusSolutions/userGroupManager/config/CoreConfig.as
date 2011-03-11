package com.ortusSolutions.userGroupManager.config{
	
	import com.ortusSolutions.userGroupManager.control.CoreController;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.AttendeeDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresenterDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	import com.ortusSolutions.userGroupManager.model.services.AttendeeService;
	import com.ortusSolutions.userGroupManager.model.services.CoreService;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	import com.ortusSolutions.userGroupManager.model.services.PersonService;
	import com.ortusSolutions.userGroupManager.model.services.PresenterService;
	import com.ortusSolutions.userGroupManager.model.services.RaffleService;
	
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
		public var attendeeService:AttendeeService;
		public var presenterService:PresenterService;
		public var raffleService:RaffleService;
		
		// model - data access
		public var personDAO:PersonDAO;
		public var meetingDAO:MeetingDAO;
		public var attendeeDAO:AttendeeDAO;
		public var presenterDAO:PresenterDAO;
		public var raffleDAO:RaffleDAO;

		// data
		public var people:ArrayCollection = 		new ArrayCollection();
		public var meetings:ArrayCollection =		new ArrayCollection();
		public var raffles:ArrayCollection =		new ArrayCollection();
		
		// controller
		public var coreController:CoreController;

		// other
		public var dbConnection:SQLConnection;
		
		
		public function CoreConfig(){
			coreService = new CoreService(databaseName);
			dbConnection = coreService.getBaseConnection();
			
			// model - data access
			personDAO =		 	new PersonDAO();
			meetingDAO = 		new MeetingDAO();
			attendeeDAO = 		new AttendeeDAO();
			presenterDAO = 		new PresenterDAO();
			raffleDAO = 		new RaffleDAO();
			
			// model - services
			personService = 	new PersonService();
			meetingService =	new MeetingService();
			attendeeService =	new AttendeeService();
			presenterService = 	new PresenterService();
			raffleService =		new RaffleService();
			
			// controller
			coreController = 	new CoreController();
		}// end constructor
		
	}// end CoreConfig class
	
}// end package enclosure