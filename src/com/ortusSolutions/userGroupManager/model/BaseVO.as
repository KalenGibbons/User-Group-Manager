package com.ortusSolutions.userGroupManager.model{
	
	import org.spicefactory.lib.reflect.ClassInfo;
	import org.spicefactory.lib.reflect.Property;
	
	public class BaseVO{
		
		public function BaseVO(){
		}// end constructor
		
		public function populate(object:Object):BaseVO{
			// we have to use the Reflection API because AS3 can't iterate over user-defined classes
			var classInfo:ClassInfo = ClassInfo.forInstance(this);
			var properties:Array = classInfo.getProperties();
			for each(var property:Property in properties){
				if(property.writable && this.hasOwnProperty(property.name)){
					if(object[property.name] != null){
						this[property.name] = object[property.name];
					}
				}
			}
			return this;
		}// end populate function
		
	}// end BaseVO class
	
}// end package enclosure