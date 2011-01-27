package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	
	import mx.formatters.DateFormatter;
	
	public class Person extends BaseVO{
		
		// database fields
		public var id:int;
		public var firstName:String = "";
		public var lastName:String = "";
		public var email:String = "";
		public var phone:String = "";
		public var twitter:String = "";
		public var facebook:String = "";
		public var createdDate:Date;
		
		// custom properties
		private var dateFormatter:DateFormatter;
		
		public function Person(){
			super();
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = Settings.DATE_FORMAT;
		}// end constructor
		
		public function get memberSince():String{
			return dateFormatter.format(this.createdDate);
		}// end memberSince getter
		
		public function get fullName():String{
			return this.firstName + ' ' + this.lastName;
		}// end fullName getter
		
	}// end Person class
	
}// end package enclosure