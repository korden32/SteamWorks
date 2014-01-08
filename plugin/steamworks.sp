#pragma semicolon 1
#include <SteamWorks>
public Plugin:myinfo = {
	name        = "SteamWorks Tests",
	author      = "KyleS",
	description = "SteamWorks Tests",
	version     = "0.1",
	url         = "https://github.com/KyleSanderson/SteamWorks"
};
public OnPluginStart() 
{
	RegServerCmd("sm_steamworks_test", CmdTest);
	RegServerCmd("sm_steamworks_setgamedesc", CmdSetGameDesc);
	RegServerCmd("sm_steamworks_clearrules", CmdClearRules);
	RegServerCmd("sm_steamworks_setrule", CmdSetRule);
	RegServerCmd("sm_steamworks_forceheartbeat", CmdForceHeartbeat);
}
public Action:CmdTest(args)
{
	decl addr[4];
	new bool:bTmp,iTmp;
	PrintToServer("=========================");
	PrintToServer("SteamWorks extension test");
	bTmp = SteamWorks_IsVACEnabled();
	PrintToServer(" IsVACEnabled: %s", bTmp ? "True":"False");
	bTmp = SteamWorks_GetPublicIP(addr);
	PrintToServer(" PublicIP: %s, %d.%d.%d.%d", bTmp ? "True":"False", addr[0], addr[1], addr[2], addr[3]);
	iTmp = SteamWorks_GetPublicIPCell();
	PrintToServer(" PublicIPCell: %d", iTmp);
	bTmp = SteamWorks_IsLoaded();
	PrintToServer(" IsLoaded: %s", bTmp ? "True":"False");
	bTmp = SteamWorks_IsConnected();
	PrintToServer(" IsConnected: %s", bTmp ? "True":"False");
	PrintToServer("=========================");
	return Plugin_Handled;
}
public Action:CmdSetGameDesc(args)
{
	if (args != 1)
	{
		PrintToServer("Usage: sm_steamworks_setgamedesc <description>");
		return Plugin_Handled;
	}
	decl String:desc[64];
	GetCmdArg(1, desc, sizeof(desc));
	new bool:bTmp=SteamWorks_SetGameDescription(desc);
	PrintToServer("SetGameDescription: %s", bTmp ? "success":"fail");
	return Plugin_Handled;
}
public Action:CmdClearRules(args)
{
	new bool:bTmp=SteamWorks_ClearRules();
	PrintToServer("ClearRules: %s", bTmp ? "success":"fail");
	return Plugin_Handled;
}
public Action:CmdForceHeartbeat(args)
{
	new bool:bTmp=SteamWorks_ForceHeartbeat();
	PrintToServer("ForceHeartbeat: %s", bTmp ? "success":"fail");
	return Plugin_Handled;
}
public Action:CmdSetRule(args)
{
	if (args != 2)
	{
		PrintToServer("Usage: sm_steamworks_setrule <key> <value>");
		return Plugin_Handled;
	}
	decl String:key[64], String:value[64];
	GetCmdArg(1, key, sizeof(key));
	GetCmdArg(2, value, sizeof(value));
	new bool:bTmp=SteamWorks_SetRule(key, value);
	PrintToServer("SetRule: %s", bTmp ? "success":"fail");
	return Plugin_Handled;
}
public SW_OnValidateClient(OwnerID, ClientID)
{
	PrintToServer("[SteamWorks] OnValidateClient: OwnerID: %d (STEAM_0:%d:%d), ClientID: %d (STEAM_0:%d:%d)", OwnerID, OwnerID & 1, OwnerID >> 1, ClientID, ClientID & 1, ClientID >> 1);
}
public SteamWorks_SteamServersConnected()
{
	PrintToServer("[SteamWorks] Connected to Steam servers");
}
public SteamWorks_SteamServersConnectFailure(EResult:Result)
{
	PrintToServer("[SteamWorks] Lost connection to Steam servers, EResult is %d", EResult);
}
public SteamWorks_SteamServersDisconnected(EResult:Result)
{
	PrintToServer("[SteamWorks] Disconnected from Steam servers, EResult is %d", EResult);
}