package com.ortusSolutions.userGroupManager.commands{
	
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	
	[Event(name="saveMeeting", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="loadMeetings", type="com.ortusSolutions.userGroupManager.events.ModelEvent")]
	
	public class SaveMeetingCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var meetingService:MeetingService;
		
		[Command (selector="saveMeeting")]
		public function execute(event:MeetingEvent):void{
			var meeting:Meeting = event.meeting;
			// TODO : looking into section 6.8 "Error Handlers" for handling errors inside a handler (instead of try/catch)
			try{
				meetingService.saveMeeting(meeting);
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(MeetingEvent.SAVE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(MeetingEvent.SAVE, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_MEETINGS) );
		}// end execute method
		
	}// end SavePersonCommand
	
}// end package enclosure