package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.model.dataAccess.RaffleDAO;
	
	public class RaffleService{
		
		[Inject]
		public var raffleDAO:RaffleDAO;
		
		public function RaffleService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		[Init]
		public function initializeHandler():void{
			raffleDAO.createTables();
		}// end initializeHandler function
		
		public function getRaffles(meetingID:int):Array{
			var raffles:Array = [];
			
			return raffles;
		}// end getRaffles function
		
	}// end public class RaffleService
	
}// end package enclosure