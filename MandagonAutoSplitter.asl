state("Mandagon"){
	int runesCollected : "mono.dll", 0x002635C0, 0x98, 0x370, 0x38;
	int loading : "Mandagon.exe", 0x12A5B20;
	int roomID : "Mandagon.exe", 0x0125B5D8, 0x158, 0x10, 0x7e0, 0x4d0, 0x0;
	int blueGuy : "Mandagon.exe", 0x0125B5E8, 0x3d8, 0x7c0, 0x4a0, 0x5a8, 0x138;
}

init{
	vars.runeCount = current.runesCollected;
}

startup{
	settings.Add("settings", true, "Settings:");
	settings.Add("autoSplit", true, "Auto-Split?", "settings");
	settings.Add("categories", true, "Categories:");
	settings.Add("anyPercent", true, "Any%?", "categories");
}

split{
	if (settings["autoSplit"]){
		if (old.runesCollected + 1 == current.runesCollected){
			if (current.runesCollected != current.runeCount){
				current.runeCount = current.runesCollected;
				return true;
			}
		}
		
		if (old.blueGuy + 1 == current.blueGuy){
			return true;
		}
	}
	
	return false;
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