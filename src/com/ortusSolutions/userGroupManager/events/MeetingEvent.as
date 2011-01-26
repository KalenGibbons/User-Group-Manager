package com.ortusSolutions.userGroupManager.events{
	
	import com.ortusSolutions.userGroupManager.model.Meeting;
	import com.ortusSolutions.userGroupManager.model.Person;
	
	import flash.events.Event;
	
	public class MeetingEvent extends Event{
		
		public static const SAVE:String =	"saveMeeting";
		
		public var meeting:Meeting;
		
		public function MeetingEvent(type:String, meeting:Meeting=null, bubbles:Boolean=false, cancelable:Boolean=false){
			this.meeting = meeting;
			super(type, bubbles, cancelable);
		}// end constructor
	
		override public function clone():Event{
			return new MeetingEvent(this.type, this.meeting, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end MeetingEvent class
	
}// end package enclosure