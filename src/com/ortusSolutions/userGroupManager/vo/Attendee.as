package com.ortusSolutions.userGroupManager.vo{
	
	import com.ortusSolutions.userGroupManager.model.Person;
	
	public class Attendee{
		
		public var person:Person;
		public var isAttending:Boolean;
		
		public function Attendee(person:Person, isAttending:Boolean=false){
			this.person = person;
			this.isAttending = isAttending;
		}// end constructor
		
	}// end public class Attendee
	
}// end package enclosure