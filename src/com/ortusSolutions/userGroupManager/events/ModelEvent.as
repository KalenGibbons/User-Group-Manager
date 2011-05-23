package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	public class ModelEvent extends Event{
		
		public static const PRELOAD_ALL:String = 	"preloadAll";
		public static const LOAD_PEOPLE:String = 	"loadPeople";
		public static const LOAD_MEETINGS:String = 	"loadMeetings";
		public static const LOAD_RAFFLES:String = 	"loadRaffles";
		
		public static const FETCH_DATA:String = 	"fetchData";
		public static const SYNC_DATA:String =		"syncData";
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}// end constructor
		
		override public function clone():Event{
			return new ModelEvent(this.type, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end ModelEvent class

}// end package enclosure