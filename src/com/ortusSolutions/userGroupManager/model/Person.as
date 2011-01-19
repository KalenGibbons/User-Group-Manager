package com.ortusSolutions.userGroupManager.model{
	
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
		[Inject(id="dateFormat")]
		public var dateFormat:String;
		public var isLoaded:Boolean = false;
		
		private var dateFormatter:DateFormatter;
		
		public function Person(){
			super();
		}// end constructor
		
		[Init]
		public function injectionHandler():void{
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "";
		}// end injectionHandler function
		
		public function get memberSince():String{
			return dateFormatter.format(this.createdDate);
		}// end memberSince function
		
	}// end Person class
	
}// end package enclosure