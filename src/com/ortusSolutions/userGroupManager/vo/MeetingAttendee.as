package com.ortusSolutions.userGroupManager.vo{
	
	import com.ortusSolutions.userGroupManager.model.Person;
	
	public class MeetingAttendee{
		
		public var person:Person;
		public var isAttending:Boolean;
		
		public function MeetingAttendee(person:Person, isAttending:Boolean=false){
			this.person = person;
			this.isAttending = isAttending;
		}// end constructor
		
	}// end public class MeetingAttendee
	
}// end package enclosure