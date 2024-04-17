ESX = exports['es_extended']:getSharedObject()

CreateThread(function ()
    while true do Wait(50)
        if NetworkIsPlayerActive(PlayerId()) then 
            Wait( math.random(1500,2000) )
            CreateThread(function ()
                while true do sleep = 1000
                    local coords = GetEntityCoords(PlayerPedId())
                    for _, playerIndex in ipairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(playerIndex)
                        local pcoords = GetEntityCoords(ped)
                        local distanceToPed = #(pcoords - coords)
                        local IdServer = GetPlayerServerId(playerIndex)
                        if distanceToPed < 10.0 and DAX.isPlayerMuted(IdServer) then sleep = 0
                            ESX.Game.Utils.DrawText3D(pcoords + vector3(0, 0, 1.2),'🔇', 1.0)
                        end
                    end
                    Wait(sleep)
                end
            end)
            break
        end
    end
end)

RegisterCommand('mutemenu',function ()
    OpenMenu()
end)

OpenMenu = function ()
    local Elements = {}
    local ListMute = DAX.getMutedPlayers()
    table.insert(Elements, {label = "ใส่ไอดีผู้เล่น", active = "input"})
    for k,v in pairs(ListMute) do
        table.insert(Elements, {
            label = ("[%s] %s"):format( tonumber(k), GetPlayerName( GetPlayerFromServerId(tonumber(k)) ) ), 
            id = k,
            active = "remove"
        })
    end
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "aaaa", {
        title = "ปิดเสียงผู้เล่น",
        align    = 'center',
        elements = Elements
    }, function(data,menu)
        if data.current.active == "input" then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'ass', {
                title = 'ใส่ไอดีผู้เล่น',
            }, function(dataDislog, menuDialog)
                local value = dataDislog.value
                if value ~= nil then
                    DAX.toggleMutePlayer(tonumber(value))
                    ESX.UI.Menu.CloseAll()
                    menuDialog.close()
                else
                    menuDialog.close()
                end
            end, function(dataDislog, menuDialog)
                menuDialog.close()
            end)
            menu.close()
        elseif data.current.active == "remove" then
            DAX.toggleMutePlayer(tonumber(data.current.id))
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end
