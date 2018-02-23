/window_connection
	var/list/zone/bordering_zones = list()
	var/list/obj/structure/window/shared_windows = list()
	var/curr_tick = 0
	var/last_check = 0

/window_connection/proc/process_differential()
	if(!bordering_zones || bordering_zones.len < 2)
		SSair.global_window_connections -= src
		shared_windows.len = 0
		return
	var/zone/A = bordering_zones[1]
	var/zone/B = bordering_zones[2]
	var/differential = abs(A.air.return_pressure() - B.air.return_pressure())
	if(differential)
		for(var/obj/structure/window/w in shared_windows)
			w.pressure_act(differential)

/window_connection/Destroy()
	for(var/zone/Z in bordering_zones)
		Z.window_connections -= src
	for(var/obj/structure/window/w in shared_windows)
		w.window_connections -= src
	bordering_zones.len = 0
	shared_windows.len = 0
	..()