package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.MeetingDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="loadMeetings", type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="saveMeeting", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="loadMeetings", type="com.ortusSolutions.userGroupManager.events.ModelEvent")]
	
	public class MeetingService{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var meetingDAO:MeetingDAO;
		
		[Inject(id="meetings")]
		public var meetings:ArrayCollection;
		
		public function MeetingService(){
		}// end constructor
		
		[Init]
		public function initializeHandler():void{
			meetingDAO.createTables();
		}// end initializeHandler function
		
		public function loadMeetings():void{
			try{
				// clear out any old records
				meetings.source = [];
				// load all meeting records
				var meetingRecords:Array = meetingDAO.getAll();
				// populate the meetings ArrayCollection
				for(var i:int=0; i<meetingRecords.length; i++){
					meetings.addItem( new Meeting().populate(meetingRecords[i]) );
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
			// begin transaction
			meetingDAO.sqlConnection.begin();
			try{
				// save meeting
				var meetingID:Number = meetingDAO.saveMeeting(meeting);
				/* save relationships */
				// remove existing attendees
				meetingDAO.removeAllAttendees(meetingID);
				// add new attendees
				for each(var attendee:Person in meeting.attendees){
					meetingDAO.addAttendee(meetingID, attendee.id);
				}
				// remove existing presentors
				meetingDAO.removeAllPresentors(meetingID);
				// add new presentors
				for each(var presentor:Person in meeting.presentors){
					meetingDAO.addPresentor(meetingID, presentor.id);
				}
				// TODO : Add raffles too
				
				// commit transaction
				meetingDAO.sqlConnection.commit();
			}catch(error:Error){
				// rollback changes
				meetingDAO.sqlConnection.rollback();
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