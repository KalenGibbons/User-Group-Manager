package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	public class DataSyncEvent extends Event{
		
		public static const FETCH_DATA:String = 	"fetchData";
		public static const SYNC_DATA:String =		"syncData";
		public static const START_SESSION:String =	"startSyncSession";
		
		public function DataSyncEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}// end constructor
		
	}// end DataSyncEvent class
	
}// end package enclosure