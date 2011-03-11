package com.ortusSolutions.userGroupManager.events{
	
	import flash.events.Event;
	
	
	public class NotificationEvent extends Event{
		
		public static const SHOW:String = "showNotification";
		
		public var message:String;
		public var notificationType:int;
		
		public function NotificationEvent(type:String, message:String="", notificationType:int=0, bubbles:Boolean=false, cancelable:Boolean=false){
			this.message = message;
			this.notificationType = notificationType;
			super(type, bubbles, cancelable);
		}// end constructor
		
		override public function clone():Event{
			return new NotificationEvent(this.type, this.message, this.notificationType, this.bubbles, this.cancelable);
		}// end close override function
		
	}// end NotificationEvent class
	
}// end package enclosure