package com.ortusSolutions.userGroupManager.commands{
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.events.PersonEvent;
	import com.ortusSolutions.userGroupManager.events.RequestCompleteEvent;
	import com.ortusSolutions.userGroupManager.model.Person;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PersonDAO;
	import com.ortusSolutions.userGroupManager.vo.ResponseType;
	
	[Event(name="savePerson", type="com.ortusSolutions.userGroupManager.events.RequestCompleteEvent")]
	[Event(name="loadPeople", type="com.ortusSolutions.userGroupManager.events.ModelEvent")]
	
	public class SavePersonCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var personDAO:PersonDAO;
		
		[Command (selector="savePerson")]
		public function execute(event:PersonEvent):void{
			var person:Person = event.person;
			// TODO : looking into section 6.8 "Error Handlers" for handling errors inside a handler (instead of try/catch)
			try{
				personDAO.savePerson(person);
			}catch(error:Error){
				messageDispatcher( new RequestCompleteEvent(PersonEvent.SAVE, ResponseType.ERROR_OCCURRED, error) );
				return;
			}
			// announce that the save was completed successfully
			messageDispatcher( new RequestCompleteEvent(PersonEvent.SAVE, ResponseType.RESULT_OK, person) );
			// reload all the people data
			messageDispatcher( new ModelEvent(ModelEvent.LOAD_PEOPLE) );
		}// end execute method
		
	}// end SavePersonCommand
	
}// end package enclosure