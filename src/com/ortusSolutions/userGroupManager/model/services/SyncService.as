package com.ortusSolutions.userGroupManager.model.services{
	
	import coldfusion.air.SessionToken;
	import coldfusion.air.SyncManager;
	import coldfusion.air.events.ConflictEvent;
	import coldfusion.air.events.SessionFaultEvent;
	import coldfusion.air.events.SessionResultEvent;
	
	import flash.filesystem.File;
	
	/**
	 * 
	 * DEPRECATED CLASS - PLEASE DELETE AFTER NEXT STABLE BUILD
	 * 
	 */	
	
	import mx.rpc.Responder;
	
	public class SyncService{
		
		private var syncManager:SyncManager;
		
		public function SyncService(dbFile:File){
			createSyncConnection();
			startSyncSession(dbFile);
		}// end constructor
		
		protected function createSyncConnection():void{
			syncManager = 			new SyncManager();
			// use Settings for all these values
			syncManager.cfPort = 	8500;
			syncManager.cfServer = 	"dev.usergroupmanager.org";
			syncManager.syncCFC =	"";
			syncManager.autoCommit = true;
			
			syncManager.addEventListener(ConflictEvent.CONFLICT, syncConflictHandler);
		}// end createSyncConnection function
		
		protected function startSyncSession(dbFile:File):void{
			var sessionToken:SessionToken = syncManager.openSession(dbFile, 191919);
			sessionToken.addResponder( new Responder(syncResultHandler, syncFaultHandler) );
		}// end startSyncSession function
		
		/* TODO : figure out a better architecture - these handlers belong in a command or something */
		
		protected function syncConflictHandler(event:ConflictEvent):void{
			trace('conflicts are bad mmm kay');
		}// end syncConflictHandler function
		
		protected function syncResultHandler(event:SessionResultEvent):void{
			trace('sync complete');
		}// end syncResultHandler function
		
		protected function syncFaultHandler(event:SessionFaultEvent):void{
			trace('sync fault');
		}// end syncFaultHandler function
			
		
	}// end SyncService class
	
}// end package enclosure