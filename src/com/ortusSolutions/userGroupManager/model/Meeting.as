package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	public class Meeting extends BaseVO{
		
		// database fields
		public var id:int;
		public var topic:String;
		public var date:Date;
		
		public var presentors:ArrayCollection;
		public var attendees:ArrayCollection;
		public var raffles:ArrayCollection;
		
		// custom properties
		private var dateFormatter:DateFormatter;
		
		public function Meeting(){
			super();
			date = new Date();
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = Settings.DATE_FORMAT_LONG;
		}// end constructor
		
		public function get formattedDate():String{
			return dateFormatter.format(this.date);
		}// end formattedDate getter
		
	}// end Person class
	
}// end package enclosure