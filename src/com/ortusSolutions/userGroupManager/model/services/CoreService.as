package com.ortusSolutions.userGroupManager.model.services{
	
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	/**
	 * 
	 * DEPRECATED CLASS - PLEASE DELETE AFTER NEXT STABLE BUILD
	 * 
	 */	
	
	public class CoreService{
		
		private var databaseName:String;
		
		protected var sqlConnection:SQLConnection;
		
		public function CoreService(databaseName:String){
			this.databaseName = databaseName;
		}// end constructor
		
		public function getBaseConnection():SQLConnection{
			if(this.sqlConnection == null){
				openConnection(File.applicationStorageDirectory.resolvePath(this.databaseName));
			}
			return this.sqlConnection;
		}// end getBaseConnection function
			
		protected function openConnection(file:File):void{
			var fileExists:Boolean = file.exists;
			this.sqlConnection = new SQLConnection();
			this.sqlConnection.open(file);
		}// end openDatebase function
		
	}// end CoreService class
	
}// end package enclosure