package com.ortusSolutions.userGroupManager.commands{
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.PersonDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="loadPeople", 	type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="peopleLoaded", type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	
	public class LoadPeopleCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject(id="people")]
		public var people:ArrayCollection;
		
		[Inject]
		public var personDAO:PersonDAO;
		
		[Command (selector="loadPeople")]
		public function execute(event:ModelEvent):void{
			try{
				// load people for local database
				var peopleRecords:Array = personDAO.getAll();
				if(peopleRecords && people){
					// clear out old records
					people.source = [];
					// populate the people ArrayCollection with Persons
					for(var i:int=0; i<peopleRecords.length; i++){
						people.addItem( new Person().populate(peopleRecords[i]) );
					}
					// refresh the data
					people.refresh();
					// announce the update of the people ArrayCollection
					messageDispatcher( new RequestCompleteEvent(ModelEvent.PEOPLE_LOADED, ResponseType.RESULT_OK) );
				}
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(ModelEvent.LOAD_PEOPLE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
		}// end execute method
		
		
	}// end LoadPeopleCommand class
	
}// end package enclosure