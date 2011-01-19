package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	public class RequestCompleteEvent extends Event{
		
		public var responseType:int;
		public var data:Object;
		
		public function RequestCompleteEvent(type:String, responseType:int, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false){
			this.responseType = responseType;
			this.data = data;
			super(type, bubbles, cancelable);
		}// end constructor
		
		override public function clone():Event{
			return new RequestCompleteEvent(this.type, this.responseType, this.data, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end RequestCompleteEvent function
	
}// end package enclosure