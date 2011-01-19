package com.ortusSolutions.userGroupManager.model{
	
	public class BaseVO{
		
		public function BaseVO(){
		}// end constructor
		
		public function populate(object:Object):BaseVO{
			for(var key:String in object){
				if(this.hasOwnProperty(key)){
					this[key] = object[key];
				}
			}
			return this;
		}// end populate function
		
	}// end BaseVO class
	
}// end package enclosure