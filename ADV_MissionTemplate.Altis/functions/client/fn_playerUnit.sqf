﻿/*
ADV_fnc_playerUnit by Belbo

Possible call - has to be executed on each client at mission startup:
[object] call ADV_fnc_applyLoadout;

_this select 0 = object - target the loadout is applied to.
*/

params [
	["_target", player, [objNull]],
	"_object","_zeus","_prefix","_playerUnit"
];
_object = str _target;

if (side _target == sideLogic) exitWith {};

if (side _target == west) then {
	//_soldier = [];for "_x" from 1 to 20 do {_newGuy = format ["%1%2","soldier_",_x];_soldier pushback _newGuy};
	_zeus = ["z1","z2","z3","z4","z5"];
	
	_prefix = [_object,0,2] call BIS_fnc_trimString;
	_playerUnit = switch (toUpper (_prefix)) do {
		case "FT_": {"ADV_fnc_ftLeader"};
		case "LEA": {"ADV_fnc_leader"};
		case "LMG": {"ADV_fnc_LMG"};
		case "AR_": {"ADV_fnc_AR"};
		case "MMG": {"ADV_fnc_AR"};
		case "GRE": {"ADV_fnc_gren"};
		case "AT_": {"ADV_fnc_AT"};
		case "AA_": {"ADV_fnc_AA"};
		case "COM": {"ADV_fnc_command"};
		case "MED": {"ADV_fnc_medic"};
		case "SPE": {"ADV_fnc_spec"};
		case "MAR": {"ADV_fnc_marksman"};
		case "UAV": {"ADV_fnc_uavOP"};
		case "CLS": {"ADV_fnc_cls"};
		case "DRI": {"ADV_fnc_driver"};
		case "LOG": {"ADV_fnc_log"};
		case "PIL": {"ADV_fnc_pilot"};
		case "SNI": {"ADV_fnc_sniper"};
		case "SPO": {"ADV_fnc_spotter"};
		case "ABE": {"ADV_fnc_ABearer"};
		case "CSW": {"ADV_fnc_soldier"};	//crew served weapon
		case "MOR": {"ADV_fnc_soldier"};	//mortar gunner
		case "TOW": {"ADV_fnc_soldier"};	//TOW Gunner
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case (toUpper (_prefix) == "FTLEADER" || toUpper (_prefix) == "FTLEADER_"): {"ADV_fnc_ftLeader"};
				case (toUpper (_prefix) == "SOLDIER" || toUpper (_prefix) == "SOLDIER_"): {"ADV_fnc_soldier"};
				case (toUpper (_prefix) == "SOLDIERAT" || toUpper (_prefix) == "SOLDIERAT_"): {"ADV_fnc_soldierAT"};
				case (toUpper (_prefix) == "ASSAR" || toUpper (_prefix) == "ASSAR_" || toUpper (_prefix) == "ASSMMG" || toUpper (_prefix) == "ASSMMG_"): {"ADV_fnc_assAR"};
				case (toUpper (_prefix) == "ASSAT" || toUpper (_prefix) == "ASSAT_"): {"ADV_fnc_assAT"};
				case (toUpper (_prefix) == "ASSAA" || toUpper (_prefix) == "ASSAA_"): {"ADV_fnc_assAA"};
				case (toUpper (_prefix) == "DIVER" || toUpper (_prefix) == "DIVER_"): {"ADV_fnc_diver"};
				case (toUpper (_prefix) == "DIVER_MEDIC" || toUpper (_prefix) == "DIVER_MEDIC_"): {"ADV_fnc_diver_medic"};
				case (toUpper (_prefix) == "DIVER_SPEC" || toUpper (_prefix) == "DIVER_SPEC_"): {"ADV_fnc_diver_spec"};
				case (toUpper (_prefix) == "ASSCSW" || toUpper (_prefix) == "ASSCSW_"): { "ADV_fnc_soldier" };		//asst. crew served weapon
				case (toUpper (_prefix) == "ASSMORTAR" || toUpper (_prefix) == "ASSMORTAR_"): { "ADV_fnc_soldier" };	//asst. mortar gunner
				case (toUpper (_prefix) == "ASSTOW" || toUpper (_prefix) == "ASSTOW_"): { "ADV_fnc_soldier" };	//asst. mortar gunner
				case (_object in _zeus): {"ADV_fnc_zeus"};
				default {"ADV_fnc_nil"};
			};
		};	
	};
};

if (side _target == east) then {
	_zeus = ["opf_z1","opf_z2","opf_z3","opf_z4","opf_z5"];
	
	_prefix = [_object,0,6] call BIS_fnc_trimString; 
	_playerUnit = switch (toUpper (_prefix)) do {
		case "OPF_FT_": {"ADV_opf_fnc_ftLeader"};
		case "OPF_LEA": {"ADV_opf_fnc_leader"};
		case "OPF_LMG": {"ADV_opf_fnc_LMG"};
		case "OPF_AR_": {"ADV_opf_fnc_AR"};
		case "OPF_MMG": {"ADV_opf_fnc_AR"};
		case "OPF_GRE": {"ADV_opf_fnc_gren"};
		case "OPF_AT_": {"ADV_opf_fnc_AT"};
		case "OPF_AA_": {"ADV_opf_fnc_AA"};
		case "OPF_COM": {"ADV_opf_fnc_command"};
		case "OPF_MED": {"ADV_opf_fnc_medic"};
		case "OPF_SPE": {"ADV_opf_fnc_spec"};
		case "OPF_MAR": {"ADV_opf_fnc_marksman"};
		case "OPF_UAV": {"ADV_opf_fnc_uavOP"};
		case "OPF_CLS": {"ADV_opf_fnc_cls"};
		case "OPF_DRI": {"ADV_opf_fnc_driver"};
		case "OPF_LOG": {"ADV_opf_fnc_log"};
		case "OPF_PIL": {"ADV_opf_fnc_pilot"};
		case "OPF_SNI": {"ADV_opf_fnc_sniper"};
		case "OPF_SPO": {"ADV_opf_fnc_spotter"};
		case "OPF_ABE": {"ADV_opf_fnc_ABearer"};
		case "OPF_CSW": {"ADV_opf_fnc_soldier"};	//crew served weapon
		case "OPF_ACS": {"ADV_opf_fnc_soldier"};	//asst. crew served weapon
		case "OPF_MOR": {"ADV_opf_fnc_soldier"};	//mortar gunner
		case "OPF_AMO": {"ADV_opf_fnc_soldier"};	//asst. mortar gunner
		case "OPF_TOW": {"ADV_opf_fnc_soldier"};	//TOW gunner
		case "OPF_ATO": {"ADV_opf_fnc_soldier"};	//asst. TOW gunner
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case (toUpper (_prefix) == "OPF_FTLEADER" || toUpper (_prefix) == "OPF_FTLEADER_"): {"ADV_opf_fnc_ftLeader"};
				case (toUpper (_prefix) == "OPF_SOLDIER" || toUpper (_prefix) == "OPF_SOLDIER_"): {"ADV_opf_fnc_soldier"};
				case (toUpper (_prefix) == "OPF_SOLDIERAT" || toUpper (_prefix) == "OPF_SOLDIERAT_"): {"ADV_opf_fnc_soldierAT"};
				case (toUpper (_prefix) == "OPF_ASSAR" || toUpper (_prefix) == "OPF_ASSAR_" || toUpper (_prefix) == "OPF_ASSMMG" || toUpper (_prefix) == "OPF_ASSMMG_"): {"ADV_opf_fnc_assAR"};
				case (toUpper (_prefix) == "OPF_ASSAT" || toUpper (_prefix) == "OPF_ASSAT_"): {"ADV_opf_fnc_assAT"};
				case (toUpper (_prefix) == "OPF_ASSAA" || toUpper (_prefix) == "OPF_ASSAA_"): {"ADV_opf_fnc_assAA"};
				case (toUpper (_prefix) == "OPF_DIVER" || toUpper (_prefix) == "OPF_DIVER_"): {"ADV_opf_fnc_diver"};
				case (toUpper (_prefix) == "OPF_DIVER_MEDIC" || toUpper (_prefix) == "OPF_DIVER_MEDIC_"): {"ADV_opf_fnc_diver_medic"};
				case (toUpper (_prefix) == "OPF_DIVER_SPEC" || toUpper (_prefix) == "OPF_DIVER_SPEC_"): {"ADV_opf_fnc_diver_spec"};
				case (_object in _zeus): {"ADV_fnc_zeus"};
				default {"ADV_fnc_nil"};
			};
		};	
	};
};

if (side _target == independent) then {
	_zeus = ["ind_z1","ind_z2","ind_z3","ind_z4","ind_z5"];
	
	_prefix = [_object,0,6] call BIS_fnc_trimString; 
	_playerUnit = switch (toUpper (_prefix)) do {
		case "IND_FT_": {"ADV_ind_fnc_ftLeader"};
		case "IND_LEA": {"ADV_ind_fnc_leader"};
		case "IND_LMG": {"ADV_ind_fnc_LMG"};
		case "IND_AR_": {"ADV_ind_fnc_AR"};
		case "IND_MMG": {"ADV_ind_fnc_AR"};
		case "IND_GRE": {"ADV_ind_fnc_gren"};
		case "IND_AT_": {"ADV_ind_fnc_AT"};
		case "IND_AA_": {"ADV_ind_fnc_AA"};
		case "IND_COM": {"ADV_ind_fnc_command"};
		case "IND_MED": {"ADV_ind_fnc_medic"};
		case "IND_SPE": {"ADV_ind_fnc_spec"};
		case "IND_MAR": {"ADV_ind_fnc_marksman"};
		case "IND_UAV": {"ADV_ind_fnc_uavOP"};
		case "IND_CLS": {"ADV_ind_fnc_cls"};
		case "IND_LOG": {"ADV_ind_fnc_log"};
		case "IND_DRI": {"ADV_ind_fnc_driver"};
		case "IND_PIL": {"ADV_ind_fnc_pilot"};
		case "IND_SNI": {"ADV_ind_fnc_sniper"};
		case "IND_SPO": {"ADV_ind_fnc_spotter"};
		case "IND_ABE": {"ADV_ind_fnc_ABearer"};
		case "IND_CSW": {"ADV_ind_fnc_soldier"};	//crew served weapon
		case "IND_ACS": {"ADV_ind_fnc_soldier"};	//asst. crew served weapon
		case "IND_MOR": {"ADV_ind_fnc_soldier"};	//mortar gunner
		case "IND_AMO": {"ADV_ind_fnc_soldier"};	//asst. mortar gunner
		case "IND_TOW": {"ADV_ind_fnc_soldier"};	//TOW gunner
		case "IND_ATO": {"ADV_ind_fnc_soldier"};	//asst. TOW gunner
		default {
			_prefix = [_object,0,-2] call BIS_fnc_trimString;
			switch true do {
				case (toUpper (_prefix) == "IND_FTLEADER" || toUpper (_prefix) == "IND_FTLEADER_"): {"ADV_ind_fnc_ftLeader"};
				case (toUpper (_prefix) == "IND_SOLDIER" || toUpper (_prefix) == "IND_SOLDIER_"): {"ADV_ind_fnc_soldier"};
				case (toUpper (_prefix) == "IND_SOLDIERAT" || toUpper (_prefix) == "IND_SOLDIERAT_"): {"ADV_ind_fnc_soldierAT"};
				case (toUpper (_prefix) == "IND_ASSAR" || toUpper (_prefix) == "IND_ASSAR_" || toUpper (_prefix) == "IND_ASSMMG" || toUpper (_prefix) == "IND_ASSMMG_"): {"ADV_ind_fnc_assAR"};
				case (toUpper (_prefix) == "IND_ASSAT" || toUpper (_prefix) == "IND_ASSAT_"): {"ADV_ind_fnc_assAT"};
				case (toUpper (_prefix) == "IND_ASSAA" || toUpper (_prefix) == "IND_ASSAA_"): {"ADV_ind_fnc_assAA"};
				case (toUpper (_prefix) == "IND_DIVER" || toUpper (_prefix) == "IND_DIVER_"): {"ADV_ind_fnc_diver"};
				case (toUpper (_prefix) == "IND_DIVER_MEDIC" || toUpper (_prefix) == "IND_DIVER_MEDIC_"): {"ADV_ind_fnc_diver_medic"};
				case (toUpper (_prefix) == "IND_DIVER_SPEC" || toUpper (_prefix) == "IND_DIVER_SPEC_"): {"ADV_ind_fnc_diver_spec"};
				case (_object in _zeus): {"ADV_fnc_zeus"};
				default {"ADV_fnc_nil"};
			};
		};	
	};
};

_target setVariable ["ADV_var_playerUnit",_playerUnit];
_playerUnit;

//if (true) exitWith {};