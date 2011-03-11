package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.model.Presentor;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresentorDAO;
	
	public class PresentorService{
		
		[Inject]
		public var presentorDAO:PresentorDAO;
		
		public function PresentorService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		[Init]
		public function initializeHandler():void{
			presentorDAO.createTables();
		}// end initializeHandler function
		
		public function getPresentors(meetingID:int):Array{
			var presentors:Array = [];
			var presentorRecords:Array = presentorDAO.getPresentors(meetingID);
			var presentor:Presentor;
			for(var i:int=0; i < presentorRecords.length; i++){
				presentor = new Presentor();
				presentor.populate(presentorRecords[i]);
				presentors.push(presentor);
			}
			return presentors;
		}// end getPresentors function
		
		public function addPresentors(meetingID:int, presentors:Array):void{
			for each(var presentor:Presentor in presentors){
				presentorDAO.addPresentor(meetingID, presentor.id);
			}
		}// end addPresentors function
		
		public function removeAllPresentors(meetingID:int):void{
			presentorDAO.removeAllPresentors(meetingID);
		}// end removeAllPresentors function
		
		
	}// end public class PresentorService
	
}// end package enclosure