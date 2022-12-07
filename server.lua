local NDCore = exports['nd-core']:GetCoreObject()
local ResetStress = false 

NDCore.Functions.CreateCallback('nd-nostress:playerStress', function(source, cb)
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)

    if Player.PlayerData.metadata['stress'] > 0 then
        cb(true)
    else
        cb(false)
    end
    print(json.encode(Player.PlayerData.metadata['stress']))
end)

RegisterNetEvent('nd-nostress:server:RelieveStress', function(amount)
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
       newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
end)