package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	
	import mx.formatters.DateFormatter;
	
	[Bindable]
	[RemoteClass(alias="model.beans.Person")]
	[Entity]
	[Table(name="people")]
	public class Person extends BaseVO{
		
		// database fields
		[Id]
		[GeneratedValue(strategy="INCREMENT")]
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
			// set created date
			createdDate = new Date();
			// create date formatter instance
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = Settings.DATE_FORMAT;
		}// end constructor
		
		[Transient]
		public function get memberSince():String{
			return dateFormatter.format(this.createdDate);
		}// end memberSince getter
		
		[Transient]
		public function get fullName():String{
			return this.firstName + ' ' + this.lastName;
		}// end fullName getter
		
	}// end Person class
	
}// end package enclosure