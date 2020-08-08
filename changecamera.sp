#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "JPTRON"
#define PLUGIN_VERSION "1"

#include <sourcemod>
#include <sdktools>
#include <cstrike>

//#include <sdkhooks>

#pragma newdecls required

stock bool IsValidClient(int client)
{
    return (client >= 1 && client <= MaxClients && !IsFakeClient(client) && IsClientConnected(client) && IsClientInGame(client) && !IsClientSourceTV(client));
}

public Plugin myinfo = 
{
	name = "changecamera",
	author = PLUGIN_AUTHOR,
	description = "Muda a câmera entre Primeira e Terceira pessoa",
	version = PLUGIN_VERSION,
	url = ""
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_fp", cmd_firstperson, "Muda para primeira pessoa");
	RegConsoleCmd("sm_tp", cmd_thirdperson, "Muda para terceira pessoa");
	
	HookEvent("player_spawn", OnPlayerSpawned);
}

public Action OnPlayerSpawned(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	ClientCommand(client, "firstperson");
}

public Action cmd_firstperson(int client, int args)
{
	if(IsValidClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == CS_TEAM_T)
	{	
		ClientCommand(client, "firstperson");		
	}

	return Plugin_Handled;
}

public Action cmd_thirdperson(int client, int args)
{
	if(IsValidClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == CS_TEAM_T)
	{	
		ClientCommand(client, "thirdperson");		
	}
	
	return Plugin_Handled;
}