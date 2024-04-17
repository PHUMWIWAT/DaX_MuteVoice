DAX = DAX or {}

--@ functions
DAX.isPlayerMuted = function (src)
    return exports['pma-voice']:isPlayerMuted(src)
end

DAX.getMutedPlayers = function ()
    return exports['pma-voice']:getMutedPlayers()
end

DAX.toggleMutePlayer = function (src)
    return exports['pma-voice']:toggleMutePlayer(src)
end