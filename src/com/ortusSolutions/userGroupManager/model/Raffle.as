package com.ortusSolutions.userGroupManager.model{
	
	public class Prize extends BaseVO{
		
		// database fields
		public var id:int;
		public var prize:String;
		public var winner:Person;
		
		public function Prize(){
			super();
		}// end constructor
		
	}// end Person class
	
}// end package enclosure