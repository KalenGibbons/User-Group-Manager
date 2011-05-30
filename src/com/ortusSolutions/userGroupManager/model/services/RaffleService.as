package com.ortusSolutions.userGroupManager.model.services{
	
	import coldfusion.air.SessionToken;
	import coldfusion.air.events.SessionFaultEvent;
	import coldfusion.air.events.SessionResultEvent;
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.RaffleEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Raffle;
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
	[Event(name="loadRaffles", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="saveRaffle", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="loadRaffles", 	type="com.ortusSolutions.userGroupManager.events.ModelEvent")]
	
	public class RaffleService{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var personService:PersonService;
		
		[Inject]
		public var meetingService:MeetingService;
		
		[Inject]
		public var raffleDAO:RaffleDAO;
		
		[Inject(id="raffles")]
		public var raffles:ArrayCollection;
		
		public function RaffleService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		/*[Init]
		public function initializeHandler():void{
			raffleDAO.createTables();
		}// end initializeHandler function*/
		
		public function loadRaffles():void{
			var loadToken:SessionToken = ConnectorService.syncSession.loadAll(Raffle);
			loadToken.addResponder( new Responder(loadRafflesHandler, loadRafflesFaultHandler) );
			
			/*
			try{
				// clear out any old records
				raffles.source = [];
				// load all raffle records
				var raffleRecords:Array = raffleDAO.getAll();
				// populate the raffle ArrayCollection with Raffles
				for(var i:int=0; i<raffleRecords.length; i++){
					raffles.addItem( processRaffle(raffleRecords[i]) );
				}
				// refresh the data
				raffles.refresh();
				// announce that all the data has been loaded
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_RAFFLES, ResponseType.RESULT_OK) );
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_RAFFLES, ResponseType.ERROR_OCCURRED, error) );
				return;
			}*/
		}// end loadRaffles function
		
		protected function loadRafflesHandler(event:SessionResultEvent):void{
			raffles.source = (event.result as ArrayCollection).source;
			// refresh the arrayCollection
			raffles.refresh();
			// announce the change
			messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_MEETINGS, ResponseType.RESULT_OK) );
		}// end loadRafflesHandler function
		
		protected function loadRafflesFaultHandler(event:SessionFaultEvent):void{
			messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_RAFFLES, ResponseType.ERROR_OCCURRED, event.error) );
		}// end loadRafflesFaultHandler function
		
		/*
		public function getRafflesByMeeting(meeting:int):Array{
			var raffles:Array = [];
			var raffleRecords:Array = raffleDAO.getRafflesByMeeting(meeting);
			for(var i:int=0; i < raffleRecords.length; i++){
				raffles.push( processRaffle(raffleRecords[i]) );
			}
			return raffles;
		}// end getRafflesByMeeting function
		*/
		
		public function getRafflesByUser(user:int):Array{
			var raffles:Array = [];
			var raffleRecords:Array = raffleDAO.getRafflesByUser(user);
			for(var i:int=0; i < raffleRecords.length; i++){
				raffles.push( processRaffle(raffleRecords[i]) );
			}
			return raffles;
		}// end getRafflesByUser function	
		
		/*
		public function getRaffleMeeting(raffle:Raffle):Meeting{
			var meetingID:int = raffleDAO.getRaffleMeetingID(raffle);
			var meeting:Meeting;
			if(meetingID){
				meeting = meetingService.getMeetingById(meetingID);
			}
			return meeting;
		}// end getRaffleMeeting function
		*/
		
		public function saveRaffle(raffle:Raffle):void{
			var saveToken:SessionToken = ConnectorService.syncSession.save(raffle);
			saveToken.addResponder( new Responder(saveHandler, saveFaultHandler) );
			/*
			var sqlConnection:SQLConnection = raffleDAO.sqlConnection;
			sqlConnection.begin();
			try{
				// save raffle
				raffleDAO.saveRaffle(raffle);
				// commit transaction
				sqlConnection.commit();
			}catch(error:Error){
				// rollback changes
				sqlConnection.rollback();
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(RaffleEvent.SAVE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(RaffleEvent.SAVE, ResponseType.RESULT_OK, raffle) );
			// reload all raffles
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) );
			*/
		}// end saveRaffle function
		
		protected function saveHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : Figure out new event
			//messageDispatcher( new RequestCompleteEvent(RaffleEvent.SAVE, ResponseType.RESULT_OK, raffle) );
			// reload all raffles
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) );
		}// end saveHandler function
		
		protected function saveFaultHandler(event:SessionFaultEvent):void{
			trace('asdf');
			// TODO : Figure out event to dispatch
			//messageDispatcher( new RequestCompleteEvent(RaffleEvent.SAVE, ResponseType.ERROR_OCCURRED, error) );
		}// end saveFaultHandler function
		
		/*
		public function saveMeetingRaffles(raffles:Array, meetingID:int):void{
			// save raffles
			for each(var raffle:Raffle in raffles){
				// at this time user's cannot edit raffles, so any with IDs have already been saved
				if(isNaN(raffle.id) || raffle.id == 0){
					var raffleID:int = raffleDAO.saveRaffle(raffle);
					raffleDAO.saveMeetingRaffle(raffleID, meetingID);
				}
			}
		}// end saveMeetingRaffle function
		*/
		
		public function deleteRaffle(raffle:Raffle):void{
			// TODO : Figure out the cascading
			var deleteToken:SessionToken = ConnectorService.syncSession.remove(raffle);
			deleteToken.addResponder( new Responder(deleteHandler, deleteFaultHandler) );
			/*
			try{
				raffleDAO.deleteRaffle(raffle);
			}catch(error:Error){
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(RaffleEvent.DELETE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(RaffleEvent.DELETE, ResponseType.RESULT_OK, raffle) );
			// reload all the raffle data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) )
			*/
		}// end deleteRaffle function
		
		protected function deleteHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : determine if we need to include the raffle in the event
			//messageDispatcher( new RequestCompleteEvent(RaffleEvent.DELETE, ResponseType.RESULT_OK, raffle) );
			// reload all the raffle data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_RAFFLES) );
		}// end deleteHandler function
		
		protected function deleteFaultHandler(event:SessionFaultEvent):void{
			// dispatch error message
			messageDispatcher( new RequestCompleteEvent(RaffleEvent.DELETE, ResponseType.ERROR_OCCURRED, event.error) );
		}// end deleteFaultHandler function
		
		protected function processRaffle(value:Object):Raffle{
			// hand populate the raffle
			var raffle:Raffle = new Raffle();
			raffle.date = 		value.created;
			raffle.id = 		value.id;
			raffle.prize = 		value.prize;
			raffle.raffleType =	value.type;
			raffle.winner = 	personService.loadPerson(value.winner);
			return raffle;	
		}// end processRaffle function
		
	}// end public class RaffleService
	
}// end package enclosure