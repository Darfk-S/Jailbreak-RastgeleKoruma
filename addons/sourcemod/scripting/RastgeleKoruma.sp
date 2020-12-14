#include <sourcemod>
#include <overlays>
#include <sdktools>
#include <warden>
#include <cstrike>

public Plugin myinfo = {
	name			= "Rastgele bir Koruma seçer.",
	author			= "Darfk",
	description		= "Komutçu kişi !rastgelekoruma yazarak Mahkum takımından rastgele bir oyuncuyu CT Takımına atar.",
	version			= "1.00",
	url				= "https://github.com/Darfk-S/Jailbreak-RastgeleKoruma"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_rastgelekoruma", CMD_RastgeleKoruma);
	RegConsoleCmd("sm_rsk", CMD_RastgeleKoruma);
}

public void OnMapStart()
{
	AddFileToDownloadsTable("materials/Darfk/rsk/korumaoldun.vmt");
	AddFileToDownloadsTable("materials/Darfk/rsk/korumaoldun.vtf");
}

public Action CMD_RastgeleKoruma(int client, int args)
{
	if (warden_iswarden(client))
	{
		new SecilenKoruma = GetRandomPlayer(3);
		
		CS_SwitchTeam(SecilenKoruma, CS_TEAM_CT);
		PrintToChatAll(" \x04[SM] \x06Rastgele koruma olarak \x10 %N \x06seçildi", SecilenKoruma);
		
		ShowOverlay(SecilenKoruma, "Darfk/rsk/korumaoldun", 2.3);
	}
	else {
		PrintToChat(client, " \x04[SM] \x06Bu komutu sadece \x0BKomutçu \x06kullanabilir.");
	}
}

stock GetRandomPlayer(team) {
    new clients[MaxClients+1], clientCount;
    for (new i = 1; i <= MaxClients; i++)
        if (IsClientInGame(i) && (GetClientTeam(i) == 2))
            clients[clientCount++] = i;
    return (clientCount == 0) ? -1 : clients[GetRandomInt(0, clientCount-1)];
}
