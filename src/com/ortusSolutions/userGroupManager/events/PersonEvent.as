package com.ortusSolutions.userGroupManager.events{
	
	import com.ortusSolutions.userGroupManager.model.Person;
	
	import flash.events.Event;
	
	public class PersonEvent extends Event{
		
		public static const SAVE:String =	"savePerson";
		
		public var person:Person;
		
		public function PersonEvent(type:String, person:Person=null, bubbles:Boolean=false, cancelable:Boolean=false){
			this.person = person;
			super(type, bubbles, cancelable);
		}// end constructor
	
		override public function clone():Event{
			return new PersonEvent(this.type, this.person, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end PersonEvent class
	
}// end package enclosure