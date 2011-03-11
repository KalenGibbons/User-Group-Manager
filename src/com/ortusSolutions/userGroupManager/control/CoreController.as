package com.ortusSolutions.userGroupManager.control{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	import com.ortusSolutions.userGroupManager.events.MeetingEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.NotificationEvent;
	import com.ortusSolutions.userGroupManager.events.PersonEvent;
	import com.ortusSolutions.userGroupManager.events.RaffleEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.Raffle;
	import com.ortusSolutions.userGroupManager.model.services.MeetingService;
	import com.ortusSolutions.userGroupManager.model.services.PersonService;
	import com.ortusSolutions.userGroupManager.model.services.RaffleService;
	import com.ortusSolutions.userGroupManager.vo.NotificationTypes;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import org.spicefactory.parsley.core.messaging.MessageProcessor;
	
	public class CoreController{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var personService:PersonService;
		
		[Inject]
		public var meetingService:MeetingService;
		
		[Inject]
		public var raffleService:RaffleService;
		
		private var dataPreloaded:Boolean = false;
		
		public function CoreController(){
		}// end constructor
		
		/* ***************************************************************************************
		**									GLOBAL HANDLERS
		*************************************************************************************** */
		
		// TODO : add handler to catch RequestCompleteEvents with an response type of error

		[MessageError]
		public function globalErrorHandler(processor:MessageProcessor, error:Error):void{
			messageDispatcher( new NotificationEvent(NotificationEvent.SHOW, Settings.DEFAULT_ERROR_MESSAGE, NotificationTypes.FAULT) );
		}// end globalErrorHandler function
		
		[MessageHandler]
		public function requestCompleteHandler(event:RequestCompleteEvent):void{
			if(event.responseType == ResponseType.RESULT_OK){
				handleCompleteRequest(event);
			}else{
				handleFaultRequest(event);
			}
		}// end requestCompleteHandler function
		
		[MessageHandler (selector="preloadAll")]
		public function preloadData(event:ModelEvent):void{
			trace('preloaded');
			if(!dataPreloaded){
				trace('loading preload data');
				// load all the applicable data
				personService.loadPeople();
				meetingService.loadMeetings();
				raffleService.loadRaffles();
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
		
		[MessageHandler (selector="savePerson")]
		public function savePerson(event:PersonEvent):void{
			var person:Person = event.person;
			personService.savePerson(person);
		}// end savePerson method
		
		[Command (selector="deletePerson")]
		public function deletePerson(event:PersonEvent):void{
			var person:Person = event.person;
			personService.deletePerson(person);
		}// end deletePerson method
		
		/* ***************************************************************************************
		**									MEETING HANDLERS
		*************************************************************************************** */
		
		[MessageHandler (selector="loadMeetings")]
		public function loadMeetings(event:ModelEvent):void{
			meetingService.loadMeetings();
		}// end loadMeetings function
		
		[MessageHandler (selector="saveMeeting")]
		public function saveMeeting(event:MeetingEvent):void{
			var meeting:Meeting = event.meeting;
			meetingService.saveMeeting(meeting);
		}// end execute method
		
		[MessageHandler (selector="deleteMeeting")]
		public function deleteMeeting(event:MeetingEvent):void{
			var meeting:Meeting = event.meeting;
			meetingService.deleteMeeting(meeting);
		}// end deleteMeeting function
		
		/* ***************************************************************************************
		**									RAFFLE HANDLERS
		*************************************************************************************** */
		
		[MessageHandler (selector="loadRaffles")]
		public function loadRaffles(event:ModelEvent):void{
			raffleService.loadRaffles();
		}// end loadRaffles function
		
		[MessageHandler (selector="saveRaffle")]
		public function saveRaffle(event:RaffleEvent):void{
			var raffle:Raffle = event.raffle;
			raffleService.saveRaffle(raffle);
		}// end execute method
		
		[Command (selector="deleteRaffle")]
		public function deleteRaffle(event:RaffleEvent):void{
			var raffle:Raffle = event.raffle;
			raffleService.deleteRaffle(raffle);
		}// end deleteRaffle method
		
		/* ***************************************************************************************
		**									PRIVATE FUNCTIONS
		*************************************************************************************** */
		
		private function handleCompleteRequest(event:RequestCompleteEvent):void{
			var message:String = "";
			var showMessage:Boolean = true;
			switch(event.type){
				case PersonEvent.SAVE:	
					var member:Person = event.data as Person;
					message = member.fullName + " has been added as a member.";
					break;
				case PersonEvent.EDIT:	
					var member:Person = event.data as Person;
					message = member.fullName + " has been updated.";
					break;
				case PersonEvent.DELETE:	
					var member:Person = event.data as Person;
					message = member.fullName + " has been removed as a member.";
					break;
				case MeetingEvent.SAVE:
					message = "This meeting has been saved.";
					break;
				case MeetingEvent.EDIT:
					message = "This meeting has been updated.";
					break;
				case MeetingEvent.DELETE:
					message = "This meeting has been deleted.";
					break;
				case RaffleEvent.SAVE:
					message = "This raffle has been saved";
					break;
				case RaffleEvent.DELETE:
					message = "This raffle has been deleted.";
					break;
				default:
					showMessage = false;
					trace('uncaught completion ' + event.type);
			}
			
			// display the message to the user
			if(showMessage){
				messageDispatcher( new NotificationEvent(NotificationEvent.SHOW, message, NotificationTypes.SUCCESS) );
			}
		}// end handleCompleteRequest function
		
		private function handleFaultRequest(event:RequestCompleteEvent):void{
			var message:String = "";
			switch(event.type){
				case PersonEvent.SAVE:	
					var member:Person = event.data as Person;
					message = "Sorry, an error has occurred. This member has not been saved. \nPlease try again.";
					break;
				case PersonEvent.EDIT:	
					var member:Person = event.data as Person;
					message = "Sorry, an error has occurred. This member has not been updated. \nPlease try again.";
					break;
				case PersonEvent.DELETE:	
					var member:Person = event.data as Person;
					message = "Sorry, an error has occurred. This member has not been removed. \nPlease try again.";
					break;
				case MeetingEvent.SAVE:
					message = "Sorry, an error has occurred. This meeting has not been saved. \nPlease try again.";
					break;
				case MeetingEvent.EDIT:
					message = "Sorry, an error has occurred. This meeting has not been updated. \nPlease try again.";
					break;
				case  MeetingEvent.DELETE:	
					message = "Sorry, an error has occurred. This meeting has not been deleted. \nPlease try again.";
					break;
				case RaffleEvent.SAVE:
					message = "Sorry, an error has occurred. This raffle has not been saved. \nPlease try again.";
					break;
				case RaffleEvent.DELETE:
					message = "Sorry, an error has occurred. This raffle has not been deleted. \nPlease try again.";
					break;
				default:
					trace('uncaught fault ' + event.type);
			}
			messageDispatcher( new NotificationEvent(NotificationEvent.SHOW, message, NotificationTypes.FAULT) );
		}// end handleFaultRequest function
		
	}// end CoreController class
	
}// end package enclosure