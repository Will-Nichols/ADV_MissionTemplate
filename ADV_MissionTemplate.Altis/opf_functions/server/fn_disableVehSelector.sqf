﻿/*
Vehicle disabling selector by belbo
Ersetzt ein Fahrzeug durch ein anderes
vehicle = _this select 0
*/
if (!isServer) exitWith {};

private ["_vehicle"];

_vehicle = _this select 0;

//disables the vehicles
if (ADV_par_Assets_cars == 0) then {
	if (str _vehicle in ADV_opf_veh_light) then {
		[_vehicle] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_heavy == 0) then {
	if (str _vehicle in ADV_opf_veh_heavys) then {
		[_vehicle] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_tanks == 0) then {
	if (str _vehicle in ADV_opf_veh_tanks+ADV_opf_veh_artys) then {
		[_vehicle] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_helis == 0) then {
	if (str _vehicle in ADV_opf_veh_helis) then {
		[_vehicle] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_fixed == 0) then {
	if (str _vehicle in ADV_opf_veh_fixedWing) then {
		[_vehicle] call ADV_fnc_disableVeh;
	};
};
	
if (true) exitWith{};