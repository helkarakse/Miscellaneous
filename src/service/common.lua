--[[

Service (Common)
Do not modify, copy or distribute without permission of author
Helkarakse 20131225

]]

-- Variables
local commandPrefix = "//"

-- References
local string = string

-- Functions
-- sends a chat message to a player
function sendMessage(map, username, message)
	local player = map.getPlayerByName(username)
	player.sendChat(message)
end

function stripPrefix(message)
	return string.sub(message, string.len(commandPrefix) + 1)
end