package com.ortusSolutions.userGroupManager.model{
	
	import flash.data.SQLConnection;
	import flash.errors.IllegalOperationError;
	import flash.filesystem.File;
	
	public class BaseDAO{
		
		[Inject(id="databaseName")]
		public var databaseName:String;
		protected var _sqlConnection:SQLConnection;
		
		public function BaseDAO(){
		}// end constructor
		
		protected function get sqlConnection():SQLConnection{
			if(_sqlConnection == null){
				openDatabase(File.documentsDirectory.resolvePath(this.databaseName));
			}
			return _sqlConnection;
		}// end sqlConnection getter
		
		protected function openDatabase(file:File):void{
			var fileExists:Boolean = file.exists;
			trace('exists: ' + fileExists);
			_sqlConnection = new SQLConnection();
			_sqlConnection.open(file);
			if(!fileExists){
				trace('creating table');
				createDatabase();
			}
		}// end openDatebase function
		
		/*
		 * Abstract method : must be overridden 
		*/
		protected function createDatabase():void{
			throw new IllegalOperationError("The createDatabase method must be overriden by its subclass");
		}// end createDatabase function
		
	}// end BaseDAO class
	
}// end package enclosure