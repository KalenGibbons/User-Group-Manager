package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.model.Attendee;
	import com.ortusSolutions.userGroupManager.model.dataAccess.AttendeeDAO;
	
	import flash.data.SQLConnection;
	
	public class AttendeeService{
		
		[Inject]
		public var attendeeDAO:AttendeeDAO;
		
		public function AttendeeService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		[Init]
		public function initializeHandler():void{
			attendeeDAO.createTables();
		}// end initializeHandler function
		
		public function getAttendees(meetingID:int):Array{
			var attendees:Array = [];
			var attendeeRecords:Array = attendeeDAO.getAttendees(meetingID);
			var attendee:Attendee;
			for(var i:int=0; i < attendeeRecords.length; i++){
				attendee = new Attendee();
				attendee.populate(attendeeRecords[i]);
				attendees.push(attendee);
			} 
			return attendees;
		}// end getAttendees function
		
		public function addAttendees(meetingID:int, attendees:Array):void{
			for each(var attendee:Attendee in attendees){
				attendeeDAO.addAttendee(meetingID, attendee.id);
			}
		}// end addAttendees function
		
		public function removeAllAttendees(meetingID:int):void{
			attendeeDAO.removeAllAttendees(meetingID);
		}// end removeAllAttendees function
	
	}// end public class AttendeeService
	
}// end package enclosure