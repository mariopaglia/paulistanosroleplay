------------------------------------------------------------
------------------------------------------------------------
---- Author: Dylan 'Itokoyamato' Thuillier              ----
----                                                    ----
---- Email: itokoyamato@hotmail.fr                      ----
----                                                    ----
---- Resource: tokovoip_script                          ----
----                                                    ----
---- File: s_main.lua                                   ----
------------------------------------------------------------
------------------------------------------------------------

--------------------------------------------------------------------------------
--	Server: radio functions
--------------------------------------------------------------------------------

local channels = TokoVoipConfig.channels;

function addPlayerToRadio(channelId, playerServerId)
	if (not channels[channelId]) then
		channels[channelId] = {id = channelId, name = "Em Chamada", subscribers = {}};
	end
	if (not channels[channelId].id) then
		channels[channelId].id = channelId;
	end

	channels[channelId].subscribers[playerServerId] = playerServerId;
	--print("Added [" .. playerServerId .. "] " .. (GetPlayerName(playerServerId) or "") .. " to channel " .. channelId);
	TriggerClientEvent("nation_hud:updateRadio", playerServerId, channelId) -- HUD NATION
	for _, subscriberServerId in pairs(channels[channelId].subscribers) do
		if (subscriberServerId ~= playerServerId) then
			TriggerClientEvent("TokoVoip:onPlayerJoinChannel", subscriberServerId, channelId, playerServerId);
		else
			-- Send whole channel data to new subscriber
			TriggerClientEvent("TokoVoip:onPlayerJoinChannel", subscriberServerId, channelId, playerServerId, channels[channelId]);
		end
	end
end
RegisterServerEvent("TokoVoip:addPlayerToRadio");
AddEventHandler("TokoVoip:addPlayerToRadio", addPlayerToRadio);

function removePlayerFromRadio(channelId, playerServerId)
	if (channels[channelId] and channels[channelId].subscribers[playerServerId]) then
		channels[channelId].subscribers[playerServerId] = nil;
		if (channelId > 1300) then
			if (tablelength(channels[channelId].subscribers) == 0) then
				channels[channelId] = nil;
			end
		end
		--print("Removed [" .. playerServerId .. "] " .. (GetPlayerName(playerServerId) or "") .. " from channel " .. channelId);

		-- Tell unsubscribed player he's left the channel as well
		TriggerClientEvent("TokoVoip:onPlayerLeaveChannel", playerServerId, channelId, playerServerId);
		TriggerClientEvent("nation_hud:updateRadio", playerServerId, 0) -- HUD NATION

		-- Channel does not exist, no need to update anyone else
		if (not channels[channelId]) then return end

		for _, subscriberServerId in pairs(channels[channelId].subscribers) do
			TriggerClientEvent("TokoVoip:onPlayerLeaveChannel", subscriberServerId, channelId, playerServerId);
		end
	end
end
RegisterServerEvent("TokoVoip:removePlayerFromRadio");
AddEventHandler("TokoVoip:removePlayerFromRadio", removePlayerFromRadio);

function removePlayerFromAllRadio(playerServerId)
	for channelId, channel in pairs(channels) do
		if (channel.subscribers[playerServerId]) then
			removePlayerFromRadio(channelId, playerServerId);
		end
	end
end
RegisterServerEvent("TokoVoip:removePlayerFromAllRadio");
AddEventHandler("TokoVoip:removePlayerFromAllRadio", removePlayerFromAllRadio);

AddEventHandler("playerDropped", function()
	removePlayerFromAllRadio(source);
end);

function printChannels()
	for i, channel in pairs(channels) do
		RconPrint("Channel: " .. channel.name .. "\n");
		for j, player in pairs(channel.subscribers) do
			RconPrint("- [" .. player .. "] " .. GetPlayerName(player) .. "\n");
		end
	end
end

function removeAllPlayerFromRadio(channelIdPlayers)
	-- print(channelIdPlayers)
	-- print('channelId')
	for channelId, channel in pairs(channels) do
		if (channelId == channelIdPlayers) then
			for playerServerId, subs in pairs(channel.subscribers) do
				removePlayerFromRadio(channelIdPlayers, playerServerId);
			end
		end
	end
end

RegisterServerEvent("TokoVoip:removeAllPlayerFromRadio");
AddEventHandler("TokoVoip:removeAllPlayerFromRadio", removeAllPlayerFromRadio);

AddEventHandler("playerDropped", function()
	removePlayerFromAllRadio(source);
end);