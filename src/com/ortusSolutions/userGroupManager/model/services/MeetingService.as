package com.ortusSolutions.userGroupManager.model.services{
	
	import coldfusion.air.SessionToken;
	import coldfusion.air.events.SessionFaultEvent;
	import coldfusion.air.events.SessionResultEvent;
	
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Attendee;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.Presenter;
	import com.ortusSolutions.userGroupManager.model.dataAccess.AttendeeDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresenterDAO;
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
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
		public var presenterService:PresenterService;
		
		[Inject]
		public var raffleService:RaffleService;
		
		[Inject(id="meetings")]
		public var meetings:ArrayCollection;
		
		public function MeetingService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		/*[Init]
		public function initializeHandler():void{
			meetingDAO.createTables();
		}// end initializeHandler function*/
		
		// TODO : Do we still need this extraneous parameter
		public function loadMeetings(loadExtraneousData:Boolean=true):void{
			var loadToken:SessionToken = ConnectorService.syncSession.loadAll(Meeting);
			loadToken.addResponder( new Responder(loadMeetingsHandler, loadMeetingsFaultHandler) );
			
			/*try{
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
						loadMeetingRelations(meeting);
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
			}*/
		}// end loadMeetings function
		
		protected function loadMeetingsHandler(event:SessionResultEvent):void{
			meetings.source = (event.result as ArrayCollection).source;
			// refresh the arrayCollection
			meetings.refresh();
			// announce the change
			messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_MEETINGS, ResponseType.RESULT_OK) );
		}// end loadMeetingsHandler function
		
		protected function loadMeetingsFaultHandler(event:SessionFaultEvent):void{
			messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_MEETINGS, ResponseType.ERROR_OCCURRED, event.error) );
		}// end loadMeetingsFaultHandler function
		
		public function getMeetingsByUser(user:int):Array{
			var meetings:Array = [];
			var meetingRecords:Array = meetingDAO.getMeetingsByUser(user);
			for(var i:int=0; i < meetingRecords.length; i++){
				var meeting:Meeting = new Meeting().populate(meetingRecords[i]) as Meeting;
				//loadMeetingRelations(meeting);
				meetings.push(meeting);
			}
			return meetings;
		}// end getMeetingsByUser function
		
		public function getMeetingById(id:int):Meeting{
			var meetingRecord:Array = meetingDAO.getMeetingByID(id);
			return (meetingRecord.length == 1) ? new Meeting().populate(meetingRecord[0]) as Meeting : null;
		}// end getMeetingById function
		
		public function getRecentMeetings(count:int):Array{
			var meetings:Array = [];
			var meetingRecords:Array = meetingDAO.getRecentMeetings(count);
			for(var i:int=0; i < meetingRecords.length; i++){
				var meeting:Meeting = new Meeting().populate(meetingRecords[i]) as Meeting;
				//loadMeetingRelations(meeting);
				meetings.push(meeting);
			}
			return meetings;
		}// end getRecentMeetings function
		
		public function saveMeeting(meeting:Meeting):void{
			var saveToken:SessionToken = ConnectorService.syncSession.save(meeting);
			saveToken.addResponder( new Responder(saveHandler, saveFaultHandler) );
			/*
			var sqlConnection:SQLConnection = meetingDAO.sqlConnection;
			var eventType:String;
			// begin transaction
			sqlConnection.begin();
			try{
				if(isNaN(meeting.id) || meeting.id == 0){
					// save person
					meeting.id = meetingDAO.saveMeeting(meeting);
					eventType = MeetingEvent.SAVE;
				}else{
					meetingDAO.editMeeting(meeting);
					eventType = MeetingEvent.EDIT;
				}
				// remove existing attendees and add new ones
				attendeeService.removeAllAttendees(meeting.id);
				attendeeService.addAttendees(meeting.id, meeting.attendees.source);
				// remove existing presenters and add new ones
				presenterService.removeAllPresenters(meeting.id);
				presenterService.addPresenters(meeting.id, meeting.presenters.source);
				// save raffles
				raffleService.saveMeetingRaffles(meeting.raffles.source, meeting.id);
				// commit transaction
				sqlConnection.commit();
			}catch(error:Error){
				// rollback changes
				sqlConnection.rollback();
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.RESULT_OK, meeting) );
			// reload all the people and raffle
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) );
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
			*/
		}// end saveMeeting function
		
		protected function saveHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : figure out
			//messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.RESULT_OK, meeting) );
			// reload all the people and raffle
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) );
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
		}// end saveHandler function
		
		protected function saveFaultHandler(event:SessionFaultEvent):void{
			trace('adsf');
			// TODO : figure out what event to dispatch
			//messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.ERROR_OCCURRED, event.error) );
		}// end saveFaultHandler function
		
		public function deleteMeeting(meeting:Meeting):void{
			// TODO : figure out the cascading
			var deleteToken:SessionToken = ConnectorService.syncSession.remove(meeting);
			deleteToken.addResponder( new Responder(deleteHandler, deleteFaultHandler) );
			/*
			try{
				meetingDAO.deleteMeeting(meeting);
			}catch(error:Error){
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(MeetingEvent.DELETE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(MeetingEvent.DELETE, ResponseType.RESULT_OK, meeting) );
			// reload all the meeting data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
			*/
		}// end deleteMeeting function
		
		protected function deleteHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : figure out if we need to include the meeting in the event
			//messageDispatcher( new RequestCompleteEvent(MeetingEvent.DELETE, ResponseType.RESULT_OK, meeting) );
			// reload all the meeting data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
		}// end deleteHandler function
		
		protected function deleteFaultHandler(event:SessionFaultEvent):void{
			// dispatch error message
			messageDispatcher( new RequestCompleteEvent(MeetingEvent.DELETE, ResponseType.ERROR_OCCURRED, event.error) );
		}// end deleteFaultHandler function
		
		/*
		private function loadMeetingRelations(meeting:Meeting):void{
			meeting.attendees =		 	new ArrayCollection();
			meeting.attendees.source = 	attendeeService.getAttendees(meeting.id);
			meeting.presenters = 		new ArrayCollection();
			meeting.presenters.source = presenterService.getPresenters(meeting.id);
			meeting.raffles = 			new ArrayCollection();
			meeting.raffles.source = 	raffleService.getRafflesByMeeting(meeting.id);
		}// end loadMeetingRelations function
		*/
		
	}// end MeetingService class
	
}// end package enclosure