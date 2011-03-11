package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.PersonEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import flash.data.SQLConnection;
	
	import mx.collections.ArrayCollection;
	
	public class PersonService{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var personDAO:PersonDAO;
		
		[Inject(id="people")]
		public var people:ArrayCollection;
		
		public function PersonService(){
		}// end constructor
		
		[Init]
		public function initializeHandler():void{
			personDAO.createTables();
		}// end initializeHandler function
		
		public function loadPeople():void{
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
			}
		}// end loadPeople function
		
		public function loadPerson(id:int):Person{
			var foundPerson:Array = personDAO.getPersonByID(id);
			return (foundPerson && foundPerson.length == 1) ? processPerson(foundPerson[0]) : null;
		}// end loadPerson function
		
		public function savePerson(person:Person):void{
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
		}// end savePerson function
		
		public function deletePerson(person:Person):void{
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
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) )
		}// end deletePerson function
		
		protected function processPerson(value:Object):Person{
			var person:Person = new Person().populate(value) as Person;
			return person;
		}// end processPerson function
		
	}// end PersonService class
	
}// end package enclosure