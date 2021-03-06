/*
    This file is part of SourcePawn SteamWorks.

    SourcePawn SteamWorks is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SourcePawn SteamWorks is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SourcePawn SteamWorks.  If not, see <http://www.gnu.org/licenses/>.
	
	Author: Kyle Sanderson (KyleS).
*/
#include "swgamedata.h"

SteamWorksGameData::SteamWorksGameData()
{
	char buffer[1];
	pGameConf = NULL;
	gameconfs->LoadGameConfigFile("steamworks", &pGameConf, buffer, sizeof(buffer));
}

SteamWorksGameData::~SteamWorksGameData()
{
	if (pGameConf != NULL)
	{
		gameconfs->CloseGameConfigFile(pGameConf);
		pGameConf = NULL;
	}
}

bool SteamWorksGameData::HasGameData(void) const
{
	return (pGameConf != NULL);
}

IGameConfig *SteamWorksGameData::GetGameData(void) const
{
	return pGameConf;
}
