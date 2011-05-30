package com.ortusSolutions.userGroupManager.config{
	
	import coldfusion.air.SessionToken;
	import coldfusion.air.SyncManager;
	
	import com.ortusSolutions.userGroupManager.commands.FetchCommand;
	import com.ortusSolutions.userGroupManager.commands.OpenSyncSessionCommand;
	import com.ortusSolutions.userGroupManager.control.CoreController;
	import com.ortusSolutions.userGroupManager.model.dataAccess.AttendeeDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresenterDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	import com.ortusSolutions.userGroupManager.model.services.AttendeeService;
	import com.ortusSolutions.userGroupManager.model.services.ConnectorService;
	import com.ortusSolutions.userGroupManager.model.services.CoreService;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	import com.ortusSolutions.userGroupManager.model.services.PersonService;
	import com.ortusSolutions.userGroupManager.model.services.PresenterService;
	import com.ortusSolutions.userGroupManager.model.services.RaffleService;
	
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
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
		
		// commands
		public var openSyncCommand:OpenSyncSessionCommand = new OpenSyncSessionCommand(Settings.CF_SESSION_ID);
		public var fetchCommand:FetchCommand =				new FetchCommand();
		
		// controller
		public var coreController:CoreController;
		// TODO : remove this and CoreService
		public var dbConnection:SQLConnection;
		
		public function CoreConfig(){
			// persistance
			ConnectorService.createDatabaseConnection(databaseName);
			ConnectorService.createSyncConnection(Settings.CF_SERVER, Settings.CF_SYNC_CFC);
			
			// TODO : remove the following code (old connection method)
			// TODO : Also remove DAOs
			coreService = new CoreService(databaseName);
			dbConnection = coreService.getBaseConnection();
			
			// model - data access
			personDAO =		 		new PersonDAO();
			meetingDAO = 			new MeetingDAO();
			attendeeDAO = 			new AttendeeDAO();
			presenterDAO = 			new PresenterDAO();
			raffleDAO = 			new RaffleDAO();
			
			// model - services
			personService = 		new PersonService();
			meetingService =		new MeetingService();
			attendeeService =		new AttendeeService();
			presenterService = 		new PresenterService();
			raffleService =			new RaffleService();
			
			// controller
			coreController = 		new CoreController();
		}// end constructor
		
	}// end CoreConfig class
	
}// end package enclosure