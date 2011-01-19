package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	public class ModelEvent extends Event{
		
		public static const PRELOAD_ALL:String = 	"preloadAll";
		public static const LOAD_PEOPLE:String = 	"loadPeople";
		public static const PEOPLE_LOADED:String = 	"peopleLoaded";
		public static const LOAD_EVENTS:String = 	"loadEvents";
		public static const EVENTS_LOADED:String =	"eventsLoaded";
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}// end constructor
		
		override public function clone():Event{
			return new ModelEvent(this.type, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end ModelEvent class

}// end package enclosure