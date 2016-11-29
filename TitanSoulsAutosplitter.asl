state("TITAN"){ 
int killsCount : "TITAN.exe", 0x003165EC, 0x38; 
int frames : "TITAN.exe", 0x003165EC, 0x30; 
} 
start{ 
return (old.frames == 0 && old.frames < current.frames); 
} 
split{ 
return (old.killsCount + 1 == current.killsCount); 
}
