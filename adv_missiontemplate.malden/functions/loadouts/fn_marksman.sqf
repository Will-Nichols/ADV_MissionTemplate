﻿//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};
params ["_player",["_special",""]];
/*
 * Author: Belbo
 *
 * Loadout function
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_marksman;
 *
 * Public: No
 */

//clothing - (string)
_uniform = ["U_B_CombatUniform_mcam_vest"];
_vest = ["V_PlateCarrier2_rgr","V_PlateCarrier1_rgr"];
_headgear = ["H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_paint"];
_backpack = [""];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.2],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "srifle_EBR_F";

//primary weapon items - (array)
_optic = ["optic_SOS"];
_attachments = ["bipod_01_F_blk"];
if ( _par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( _par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "muzzle_snds_B";		//if silencer is added
//MarksmenDLC-objects:
if ( (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) && (missionNamespace getVariable ["adv_par_DLCContent",1]) > 0 ) then {
	_primaryWeapon = ["srifle_DMR_03_F"];
	switch (true) do {
		case ((toUpper worldname) in _var_aridMaps): {_primaryWeapon append ["srifle_DMR_03_tan_F"]; _optic = ["optic_AMS","optic_AMS_snd"];};
		case ((toUpper worldname) in _var_lushMaps): {_primaryWeapon append ["srifle_DMR_03_woodland_F","srifle_DMR_03_khaki_F"]; _optic = ["optic_AMS","optic_AMS_khk"];};
		default {_optic = ["optic_AMS"];};
	};
};

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [8,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//40mm Grenades - (integer)
_40mmHeGrenadesAmmo = 0;
_40mmSmokeGrenadesWhite = 0;
_40mmSmokeGrenadesYellow = 0;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 0;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 0;
_40mmFlareWhite = 0;
_40mmFlareYellow = 0;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "hgun_Pistol_heavy_01_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_acp";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Rangefinder";

//throwables - (integer)
_grenadeSet = 1;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = [""];			//depending on the custom loadout the colours may be merged. add like this: ["HE","HE","WHITE"] (adds two HE and one white smoke grenade).
_chemlights = [""];		//add like this: ["RED","RED","GREEN"] (adds two red and one green chemlight).
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
_MediKit = 0;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = [];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
_itemsLink = [
	"ItemWatch",
	"ItemCompass",
	"ItemMap",
	"NVGoggles_OPFOR"
];
		
//items added to any container - (array)
_items = [];

	//CustomMod items//
	
//TFAR or ACRE radios
_giveRiflemanRadio = true;
_givePersonalRadio = true;
_giveBackpackRadio = false;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//Adds a standard amount of medical items. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 0;
_ACE_elasticBandage = 0;
_ACE_packingBandage = 0;
_ACE_quikclot = 0;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 0;
_ACE_morphine = 0;
_ACE_tourniquet = 0;
_ACE_bloodIV = 0;
_ACE_bloodIV_500 = 0;
_ACE_bloodIV_250 = 0;
_ACE_plasmaIV = 0;
_ACE_plasmaIV_500 = 0;
_ACE_plasmaIV_250 = 0;
_ACE_salineIV = 0;
_ACE_salineIV_500 = 0;
_ACE_salineIV_250 = 0;
_ACE_bodyBag = 0;
_ACE_surgicalKit = 0;
_ACE_personalAidKit = 0;

_ACE_SpareBarrel = 0;
_ACE_EntrenchingTool = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 0;
_ACE_Cellphone = 0;
_ACE_FlareTripMine = 0;
_ACE_MapTools = 0;
_ACE_CableTie = 0;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 1;
_ACE_DAGR = 0;
_ACE_microDAGR = 0;
_ACE_RangeTable_82mm = 0;
_ACE_MX2A = 0;
_ACE_HuntIR_monitor = 0;
_ACE_HuntIR = 0;
_ACE_m84 = 0;
_ACE_HandFlare_Green = 0;
_ACE_HandFlare_Red = 0;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 0;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag","sc_mre"];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","","",""];

//Addon Content:
switch (_par_customWeap) do {
	case 1: {
		//BWmod 
		_primaryweapon = ["BWA3_G28_Standard"];
		_optic = ["BWA3_optic_Shortdot"];
		if ( _par_NVGs > 0 ) then { _attachments = ["BWA3_acc_VarioRay_irlaser"]; };
		_silencer = "BWA3_muzzle_snds_G28";
		_ace_gunbag = 0;
		_primaryweaponAmmo = [10,5];
		_handgun = "BWA3_P8";
		_itemsHandgun = [""];
		_handgunSilencer = "";		//if silencer is added
		//_itemsBackpack = ["BWA3_10Rnd_762x51_G28_Tracer","BWA3_10Rnd_762x51_G28_Tracer","BWA3_10Rnd_762x51_G28_Tracer","BWA3_10Rnd_762x51_G28_Tracer"];
	};
	case 2: {
		//RHS Army
		_primaryweapon = ["rhs_weap_sr25","rhs_weap_sr25_ec","rhs_weap_m14ebrri"];
		_optic = ["rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_LEUPOLDMK4"];
		call {
			if ((toUpper worldname) in _var_aridMaps) exitWith {
				_primaryWeapon append ["rhs_weap_sr25_d","rhs_weap_sr25_ec_d"];
			};
			if ((toUpper worldname) in _var_lushMaps) exitWith {
				_primaryWeapon append ["rhs_weap_sr25_wd","rhs_weap_sr25_ec_wd"];
			};
		};
		_attachments = ["rhsusf_acc_harris_bipod"];
		_silencer = "rhsusf_acc_SR25S";		//if silencer is added
		if ( _par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( _par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 3: {
		//RHS Marines
		_primaryweapon = ["rhs_weap_sr25","rhs_weap_sr25_ec"];
		_optic = ["rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_LEUPOLDMK4"];
		_attachments = ["rhsusf_acc_harris_bipod"];
		_silencer = "rhsusf_acc_SR25S";		//if silencer is added
		if ( _par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( _par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 4: {
		//RHS SOF
		_primaryweapon = ["rhs_weap_sr25","rhs_weap_sr25_ec"];
		_optic = ["rhsusf_acc_LEUPOLDMK4_2"];
		_attachments = ["rhsusf_acc_harris_bipod"];
		_silencer = "rhsusf_acc_SR25S";		//if silencer is added
		if ( _par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( _par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 5: {
		//SELmods CUP Mk16
		_primaryweapon = ["CUP_srifle_M110"];
		_optic = ["CUP_optic_LeupoldMk4_10x40_LRT_Desert"];
		_attachments = ["CUP_bipod_VLTOR_Modpod"];
		if ( _par_NVGs > 0 ) then { _attachments pushBack "CUP_acc_ANPEQ_15"; };
		_silencer = "CUP_muzzle_snds_M110";		//if silencer is added
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[""];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 6: {
		//SELmods CUP M4
		_primaryweapon = ["CUP_srifle_DMR"];
		_optic = ["CUP_optic_LeupoldMk4"];
		_attachments = ["bipod_02_F_blk"];
		_silencer = "";		//if silencer is added
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[""];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 7: {
		//BAF
		_primaryweapon = ["CUP_srifle_L129A1"];
		_optic = ["CUP_optic_SB_11_4x20_PM"];
		_attachments = ["CUP_optic_SB_11_4x20_PM","CUP_bipod_Harris_1A2_L"];
		_silencer = "muzzle_snds_B";		//if silencer is added
		_primaryweaponAmmo set [1,1];
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
		_handgunSilencer = "muzzle_snds_L";		//if silencer is added
	};
	case 8: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L129A1","UK3CB_BAF_L129A1_AFG","UK3CB_BAF_L129A1_FGrip","UK3CB_BAF_L129A1_Grippod"];
		_optic = ["optic_SOS"];
		if ( _par_NVGs > 0 ) then { _attachments = ["UK3CB_BAF_LLM_IR_Black"]; };
		_silencer = "UK3CB_BAF_Silencer_L115A3";
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
		_handgunSilencer = "muzzle_snds_L";
	};
	case 9: {
		_primaryWeapon = ["hlc_rifle_g3sg1"];
		_optic = ["HLC_Optic_ZFSG1"];
		_attachments = [""];
		_silencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = ["RH_m1911"];
			_itemsHandgun = [""];
			_handgunSilencer = "";
		};
	};
	case 20: {
		//APEX HK416
		_primaryWeapon = ["arifle_SPAR_03_blk_F"];
		switch (true) do {
			case ((toUpper worldname) in _var_aridMaps): {_primaryWeapon append ["arifle_SPAR_03_snd_F"]};
			case ((toUpper worldname) in _var_lushMaps): {_primaryWeapon append ["arifle_SPAR_03_khk_F"]};
			default {};
		};
	};
	default {};
};
switch (_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_uniform = ["BWA3_Uniform_idz_Tropen"];
		_vest = ["BWA3_Vest_Marksman_Tropen"];
		_headgear = ["BWA3_MICH_Tropen"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_uniform = ["PBW_Uniform1_tropen","PBW_Uniform3_tropen","PBW_Uniform3K_tropen"];
			_headgear = ["PBW_Helm4_tropen_HBO","PBW_Helm1_tropen_HBO"];
			_items pushback "PBW_muetze1_tropen";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_idz_Fleck"];
		_vest = ["BWA3_Vest_Marksman_Fleck"];
		_headgear = ["BWA3_MICH_Fleck"];
		if (isClass(configFile >> "CfgPatches" >> "PBW_German_Common")) then {
			_uniform = ["PBW_Uniform1_fleck","PBW_Uniform3_fleck","PBW_Uniform3K_fleck"];
			_vest = ["pbw_koppel_grpfhr","pbw_splitter_grpfhr"];
			_headgear = ["PBW_Helm4_fleck_HBO","PBW_Helm1_fleck_HBO"];
			_items pushback "PBW_muetze1_fleck";
		};
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
	};
	case 4: {
		//TFA Woodland
	};
	case 5: {
		//TFA Desert
	};
	case 6: {
		//CUP BAF
		switch (true) do {
			case ((toUpper worldname) in _var_aridMaps): {
				_uniform = ["CUP_U_B_BAF_DDPM_S2_UnRolled","CUP_U_B_BAF_DDPM_S1_RolledUp","CUP_U_B_BAF_DDPM_Tshirt"];
				_vest = ["CUP_V_BAF_Osprey_Mk2_DDPM_Soldier1","CUP_V_BAF_Osprey_Mk2_DDPM_Soldier2","CUP_V_BAF_Osprey_Mk2_DDPM_Officer","CUP_V_BAF_Osprey_Mk2_DDPM_Sapper"];
				_headgear = ["CUP_H_BAF_Helmet_1_DDPM","CUP_H_BAF_Helmet_Net_2_DDPM","CUP_H_BAF_Helmet_4_DDPM"];
			};
			case ((toUpper worldname) in _var_lushMaps): {
				_uniform = ["CUP_U_B_BAF_DPM_S2_UnRolled","CUP_U_B_BAF_DPM_S1_RolledUp","CUP_U_B_BAF_DPM_S1_RolledUp","CUP_U_B_BAF_DPM_Tshirt"];
				_vest = ["CUP_V_BAF_Osprey_Mk2_DPM_Soldier1","CUP_V_BAF_Osprey_Mk2_DPM_Soldier2","CUP_V_BAF_Osprey_Mk2_DPM_Officer","CUP_V_BAF_Osprey_Mk2_DPM_Sapper"];
				_headgear = ["CUP_H_BAF_Helmet_1_DPM","CUP_H_BAF_Helmet_Net_2_DPM","CUP_H_BAF_Helmet_4_DPM"];
			};
			default {
				_uniform = ["CUP_U_B_BAF_MTP_S2_UnRolled","CUP_U_B_BAF_MTP_S1_RolledUp","CUP_U_B_BAF_MTP_Tshirt","CUP_U_B_BAF_MTP_S3_RolledUp","CUP_U_B_BAF_MTP_S5_UnRolled","CUP_U_B_BAF_MTP_S6_UnRolled"];
				_vest = ["CUP_V_BAF_Osprey_Mk4_MTP_Grenadier","CUP_V_BAF_Osprey_Mk4_MTP_Rifleman","CUP_V_BAF_Osprey_Mk4_MTP_SquadLeader"];
				_headgear = ["CUP_H_BAF_Helmet_1_MTP","CUP_H_BAF_Helmet_Net_2_MTP","CUP_H_BAF_Helmet_4_MTP"];
			};
		};
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["CUP_NVG_HMNVS"];
	};
	case 7: {
		//RHS OCP
		_uniform = ["rhs_uniform_cu_ocp"];
		_vest = ["rhsusf_iotv_ocp_Rifleman"];
		_headgear = ["rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_headset_ocp","rhsusf_ach_helmet_ESS_ocp","rhsusf_ach_helmet_headset_ess_ocp",
			"rhsusf_mich_bare_tan","rhsusf_mich_bare_tan_headset","rhsusf_ach_bare_tan_ess","rhsusf_ach_bare_tan_headset_ess"];
		_items pushBack "rhsusf_patrolcap_ocp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_14"];
	};
	case 8: {
		//RHS UCP:
		_uniform = ["rhs_uniform_cu_ucp"];
		_vest = ["rhsusf_iotv_ucp_Rifleman"];
		_headgear = ["rhsusf_ach_helmet_ucp","rhsusf_ach_helmet_headset_ucp","rhsusf_ach_helmet_ESS_ucp","rhsusf_ach_helmet_headset_ess_ucp",
			"rhsusf_mich_bare_norotos_alt","rhsusf_mich_bare_headset","rhsusf_ach_bare_ess","rhsusf_ach_bare_headset_ess"];
		_items pushBack "rhsusf_patrolcap_ucp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_14"];
	};
	case 10: {
		//RHS MARPAT
		switch (true) do {
			case ((toUpper worldname) in _var_aridMaps): {
				_uniform = ["rhs_uniform_FROG01_d"];
				_headgear = ["rhsusf_lwh_helmet_marpatd","rhsusf_mich_helmet_marpatd","rhsusf_mich_helmet_marpatd_alt","rhsusf_mich_helmet_marpatd_norotos"];
				_items pushBack "rhs_Booniehat_marpatd";
			};
			default {
				_uniform = ["rhs_uniform_FROG01_wd"];
				_headgear = ["rhsusf_lwh_helmet_marpatwd","rhsusf_mich_helmet_marpatwd","rhsusf_mich_helmet_marpatwd_alt","rhsusf_mich_helmet_marpatwd_norotos"];
				_items pushBack "rhs_Booniehat_marpatwd";
			};
		};
		_vest = ["rhsusf_spc_squadleader"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};	
	case 11: {
	};
	case 9: {
		//Guerilla
		_uniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
		if (_par_customWeap == 0) then {
			//MarksmenDLC-objects:
			if ( (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) && (missionNamespace getVariable ["adv_par_DLCContent",1]) > 0 ) then {
				_primaryWeapon = ["srifle_DMR_06_olive_F","srifle_DMR_06_camo_F"];
				_optic = ["optic_KHS_old"];
				_attachments = ["bipod_02_F_blk"];
				_silencer = "";		//if silencer is added
			};
		};
		if (_par_customWeap == 3 || _par_customWeap == 4 || _par_customWeap == 5) then {
			_primaryWeapon = ["CUP_srifle_CZ550_rail"];
			_optic = ["optic_KHS_old"];
			_attachments = [""];
			_silencer = "";
		};
		_binocular = "Binocular";
		_giveRiflemanRadio = true;
		_givePersonalRadio = false;
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM"];
		_vest = ["UK3CB_BAF_V_Osprey_Marksman_A"];
		_headgear = ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D"];
		//_backpack = ["UK3CB_BAF_B_Bergen_MTP_Rifleman_H_A","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_B","UK3CB_BAF_B_Bergen_MTP_Rifleman_H_C"];
		_items pushBack "UK3CB_BAF_H_Beret_RM_Bootneck";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//CUP PMC
		_uniform = ["CUP_I_B_PMC_Unit_20","CUP_I_B_PMC_Unit_17","CUP_I_B_PMC_Unit_13","CUP_I_B_PMC_Unit_15","CUP_I_B_PMC_Unit_3"
			,"CUP_I_B_PMC_Unit_5","CUP_I_B_PMC_Unit_6","CUP_I_B_PMC_Unit_24","CUP_I_B_PMC_Unit_23","CUP_I_B_PMC_Unit_11"];
		_vest = ["V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier2_rgr_noflag_F"];
		_headgear = ["H_Cap_headphones","H_MilCap_blue","H_Cap_oli_hs","H_Cap_blk","",""
			,"CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Tan","CUP_H_C_TrackIR_01","CUP_H_PMC_Cap_EP_Grey","CUP_H_PMC_Cap_EP_Tan"
			,"CUP_H_PMC_Cap_Back_EP_Grey","CUP_H_PMC_Cap_Back_EP_Tan","CUP_H_FR_Cap_Headset_Green","CUP_H_FR_Headset","CUP_H_FR_Headset"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4","TRYK_U_B_PCUHsW","TRYK_U_B_PCUHsW5"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_woolhat_WH","TRYK_H_woolhat_WH",""];
		_backpack = ["TRYK_B_Belt_BLK"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH","",""];
	};
	case 20: {
		//APEX NATO
		_uniform = ["U_B_T_Soldier_SL_F","U_B_T_Soldier_F"];
		_vest = ["V_PlateCarrier1_tna_F","V_PlateCarrier2_tna_F"];
		_headgear = ["H_HelmetB_tna_F","H_HelmetB_Enh_tna_F","H_HelmetB_Light_tna_F"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["NVGoggles_tna_F"];
	};
	case 30: {
		//Vanilla CTRG
		_uniform = ["U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3"];
		_vest = ["V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG"];
		if (worldName == "TANOA") then {
			_uniform = ["U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_3_F"];
			_vest = ["V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier2_rgr_noflag_F"];
			_headgear = ["H_HelmetB_TI_tna_F"];
		};
	};
	case 31: {
		//adv_retex WDL
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			_uniform = ["adv_retex_u_CombatUniform_wdl_vest","adv_retex_u_CombatUniform_i_wdl_shortsleeve"];
			_headgear = ["H_HelmetIA_wdl"];
		};
	};
	default {};
};

///// No editing necessary below this line /////

[_player] call ADV_fnc_gear;

true;