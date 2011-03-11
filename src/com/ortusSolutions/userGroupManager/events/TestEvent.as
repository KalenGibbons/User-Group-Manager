package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	
	public class TestEvent extends Event{
		
		public static const THIS_IS_A_TEST:String = "thisIsATestEvent";
		
		public function TestEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}// end TestEvent class
	
}// end package enclosure