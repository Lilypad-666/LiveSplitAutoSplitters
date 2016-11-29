state("Mandagon"){
	int runesCollected : "Mandagon.exe", 0x01347E40, 0x448, 0x10, 0x98, 0x380, 0x38;
	int roomID : "Mandagon.exe", 0x01296C50, 0x3C0, 0x548, 0x0, 0x770, 0x7D0;
	int loading : "Mandagon.exe", 0x1343E70;
}

init{
	vars.runeCount = current.runesCollected;
}

startup{
	settings.Add("settings", true, "Settings:");
	settings.Add("autoSplit", true, "Auto-Split?", "settings");
	
	settings.Add("categories", true, "Categories: (Only Select One Please!)");
	settings.Add("anyPercent", true, "Any%?", "categories");
	settings.Add("1tablet", false, "1 Tablet?", "categories");
	settings.Add("2tablet", false, "2 Tablets?", "categories");
	settings.Add("3tablet", false, "3 Tablets?", "categories");
	
}

split{
	if (settings["autoSplit"]){
		if (old.runesCollected + 1 == current.runesCollected){
			if (current.runesCollected != current.runeCount){
				current.runeCount = current.runesCollected;
				return true;
			}
		}
		
		if (settings["1tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 1);
			}
		}
		
		if (settings["2tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 2);
			}
		}
		
		if (settings["3tablet"]){
			if (old.roomID == 2 && current.roomID == 5){
				System.Threading.Thread.Sleep(10);
				return (current.runeCount == 3);
			}
		}
	}
	
	return false;
}

reset{
	return (old.roomID - 1 == current.roomID && current.roomID == 2);
}

isLoading{
	return (current.loading != 0);
}


start{
	if (timer.CurrentPhase == TimerPhase.NotRunning){
		current.runeCount = current.runesCollected;
	}
	
	return (old.roomID + 1 == current.roomID);
}
