package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Attendee;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.Presentor;
	import com.ortusSolutions.userGroupManager.model.dataAccess.AttendeeDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresentorDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="loadMeetings", type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="saveMeeting", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="loadMeetings", type="com.ortusSolutions.userGroupManager.events.ModelEvent")]
	
	public class MeetingService{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var meetingDAO:MeetingDAO;
		
		[Inject]
		public var attendeeService:AttendeeService;
		
		[Inject]
		public var presentorService:PresentorService;
		
		[Inject]
		public var raffleService:RaffleService;
		
		[Inject(id="meetings")]
		public var meetings:ArrayCollection;
		
		public function MeetingService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		[Init]
		public function initializeHandler():void{
			meetingDAO.createTables();
		}// end initializeHandler function
		
		public function loadMeetings(loadExtraneousData:Boolean=true):void{
			try{
				// clear out any old records
				meetings.source = [];
				// load all meeting records
				var meetingRecords:Array = meetingDAO.getAll();
				var meeting:Meeting;
				// populate the meetings ArrayCollection
				for(var i:int=0; i<meetingRecords.length; i++){
					meeting = new Meeting();
					meeting.populate(meetingRecords[i]);
					if(loadExtraneousData){
						meeting.attendees =		 	new ArrayCollection();
						meeting.attendees.source = 	attendeeService.getAttendees(meeting.id);
						meeting.presentors = 		new ArrayCollection();
						meeting.presentors.source = presentorService.getPresentors(meeting.id);
						meeting.raffles = 			new ArrayCollection();
						meeting.raffles.source = 	raffleService.getRaffles(meeting.id);
					}
					meetings.addItem(meeting);
				}
				// refresh the data
				meetings.refresh();
				// announce that all the data has been loaded
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_MEETINGS, ResponseType.RESULT_OK) );
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_MEETINGS, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
		}// end loadMeetings function
		
		
		public function saveMeeting(meeting:Meeting):void{
			var sqlConnection:SQLConnection = meetingDAO.sqlConnection;
			// begin transaction
			sqlConnection.begin();
			try{
				// save meeting
				var meetingID:Number = meetingDAO.saveMeeting(meeting);
				// remove existing attendees and add new ones
				attendeeService.removeAllAttendees(meetingID);
				attendeeService.addAttendees(meetingID, meeting.attendees.source);
				// remove existing presentors and add new ones
				presentorService.removeAllPresentors(meetingID);
				presentorService.addPresentors(meetingID, meeting.presentors.source);
				
				// TODO : Add raffles too
				
				// commit transaction
				sqlConnection.commit();
			}catch(error:Error){
				// rollback changes
				sqlConnection.rollback();
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(MeetingEvent.SAVE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(MeetingEvent.SAVE, ResponseType.RESULT_OK, meeting) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
		}// end savePerson function
		
	}// end MeetingService class
	
}// end package enclosure