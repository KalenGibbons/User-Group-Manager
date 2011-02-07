package com.ortusSolutions.userGroupManager.control{
	
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.PersonEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	import com.ortusSolutions.userGroupManager.model.services.PersonService;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import org.spicefactory.parsley.core.messaging.MessageProcessor;
	
	public class CoreController{
		
		[Inject]
		public var personService:PersonService;
		
		[Inject]
		public var meetingService:MeetingService;
		
		private var dataPreloaded:Boolean = false;
		
		public function CoreController(){
		}// end constructor
		
		/* ***************************************************************************************
		**									GLOBAL HANDLERS
		*************************************************************************************** */
		
		// TODO : add handler to catch RequestCompleteEvents with an response type of error

		[MessageError]
		public function globalErrorHandler(processor:MessageProcessor, error:Error):void{
			// TODO : Do something whe erorrs are caught
			trace('caught error');
		}// end globalErrorHandler function
		
		[MessageHandler (selector="preloadAll")]
		public function preloadData(event:ModelEvent):void{
			if(!dataPreloaded){
				// load all the applicable data
				personService.loadPeople();
				meetingService.loadMeetings();
				dataPreloaded = true;
			}
		}// end preloadData function
		
		/* ***************************************************************************************
		**									PERSON HANDLERS
		*************************************************************************************** */
		
		[MessageHandler (selector="loadPeople")]
		public function loadPeople(event:ModelEvent):void{
			personService.loadPeople();
		}// end loadPeople function
		
		[Command (selector="savePerson")]
		public function savePerson(event:PersonEvent):void{
			var person:Person = event.person;
			personService.savePerson(person);
		}// end savePerson method
		
		/* ***************************************************************************************
		**									MEETING HANDLERS
		*************************************************************************************** */
		
		[MessageHandler (selector="loadMeetings")]
		public function loadMeetings(event:ModelEvent):void{
			meetingService.loadMeetings();
		}// end loadPeople function
		
		[MessageHandler (selector="saveMeeting")]
		public function saveMeeting(event:MeetingEvent):void{
			var meeting:Meeting = event.meeting;
			meetingService.saveMeeting(meeting);
		}// end execute method
		
		
		
	}// end CoreController class
	
}// end package enclosure