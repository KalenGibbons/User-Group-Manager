package com.ortusSolutions.userGroupManager.model.services{
	
	import coldfusion.air.Session;
	import coldfusion.air.SessionToken;
	import coldfusion.air.events.SessionFaultEvent;
	import coldfusion.air.events.SessionResultEvent;
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.PersonEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
	public class PersonService{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var personDAO:PersonDAO;
		
		[Inject(id="people")]
		public var people:ArrayCollection;
		
		public function PersonService(){
		}// end constructor
		
		/*[Init]
		public function initializeHandler():void{
			personDAO.createTables();
		}// end initializeHandler function*/
		
		public function loadPeople():void{
			var loadToken:SessionToken = ConnectorService.syncSession.loadAll(Person);
			loadToken.addResponder( new Responder(loadPeopleHandler, loadPeopleFaultHandler) );
			
			
			/*var session:Session = ConnectorService.syncSession;
			trace('adsf');
			//var x:Array = session.loadAll('Person');
			try{
				// clear out any old records
				people.source = [];
				// load all person records
				var peopleRecords:Array = personDAO.getAll();
				// populate the people ArrayCollection with Persons
				for(var i:int=0; i<peopleRecords.length; i++){
					people.addItem( new Person().populate(peopleRecords[i]) );
				}
				// refresh the data
				people.refresh();
				// announce that all the data has been loaded
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_PEOPLE, ResponseType.RESULT_OK) );
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_PEOPLE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}*/
		}// end loadPeople function
		
		protected function loadPeopleHandler(event:SessionResultEvent):void{
			people.source = (event.result as ArrayCollection).source;
			// refresh the arrayCollection			
			people.refresh();
			// announce the change
			messageDispatcher ( new RequestCompleteEvent(ModelEvent.LOAD_PEOPLE, ResponseType.RESULT_OK) );
		}// end loadPeopleHandler function
			
		protected function loadPeopleFaultHandler(event:SessionFaultEvent):void{
			// announce the failure - so sad!
			messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_PEOPLE, ResponseType.ERROR_OCCURRED, event.error) );
		}// end loadPeopleFaultHandler function
		
		public function loadPerson(id:int):Person{
			// TODO : implement this function
			var foundPerson:Array = personDAO.getPersonByID(id);
			return (foundPerson && foundPerson.length == 1) ? processPerson(foundPerson[0]) : null;
		}// end loadPerson function
		
		public function savePerson(person:Person):void{
			var saveToken:SessionToken = ConnectorService.syncSession.save(person);
			saveToken.addResponder( new Responder(saveHandler, saveFaultHandler) );
			/*
			var sqlConnection:SQLConnection = personDAO.sqlConnection;
			var eventType:String;
			// begin transaction
			sqlConnection.begin();
			try{
				if(isNaN(person.id) || person.id == 0){
					// save person
					personDAO.savePerson(person);
					eventType = PersonEvent.SAVE;
				}else{
					// update person
					personDAO.editPerson(person);
					eventType = PersonEvent.EDIT;
				}
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
			messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) );
			*/
		}// end savePerson function
		
		protected function saveHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : Figure out new event
			//messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) );
		}// end saveHandler function
		
		protected function saveFaultHandler(event:SessionFaultEvent):void{
			trace('adsf');
			// TODO : Figure out new event
			//messageDispatcher( new RequestCompleteEvent(eventType, ResponseType.ERROR_OCCURRED, event.error) );
		}// end saveFaultHandler function
		
		public function deletePerson(person:Person):void{
			// TODO : figure out cascading options
			var deleteToken:SessionToken = ConnectorService.syncSession.remove(person);
			deleteToken.addResponder( new Responder(deleteHandler, deleteFaultHandler) );
			/*
			try{
				personDAO.deletePerson(person);
			}catch(error:Error){
				// dispatch error message
				messageDispatcher( new RequestCompleteEvent(PersonEvent.DELETE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(PersonEvent.DELETE, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) );
			*/
		}// end deletePerson function
		
		protected function deleteHandler(event:SessionResultEvent):void{
			// announce that the save was completed successfully
			// TODO : figure out if we need to pass the person in the event
			//messageDispatcher( new RequestCompleteEvent(PersonEvent.DELETE, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) );
		}// end deleteHandler function
		
		protected function deleteFaultHandler(event:SessionFaultEvent):void{
			// dispatch error message
			messageDispatcher( new RequestCompleteEvent(PersonEvent.DELETE, ResponseType.ERROR_OCCURRED, event.error) );		
		}// end deleteFaultHandler function
		
		/* TODO : remove this function once it's not needed */
		protected function processPerson(value:Object):Person{
			var person:Person = new Person().populate(value) as Person;
			return person;
		}// end processPerson function
		
	}// end PersonService class
	
}// end package enclosure