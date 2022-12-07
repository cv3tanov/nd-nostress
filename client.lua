local NDCore = exports['nd-core']:GetCoreObject() 
local PlayerData = NDCore.Functions.GetPlayerData()
local stressed = false
local stress = 0

function StressCheck()
    NDCore.Functions.TriggerCallback('nd-nostress:playerStress', function(cb)
        if cb then
             stressed = true
             RelieveStress()
        end
    end)
end

function RelieveStress()
    if stressed then
        Citizen.Wait(Config.Time)
        TriggerServerEvent('hud:server:RelieveStress', 100)
    end
end

CreateThread(function()
    for k, v in pairs(Config.Bar) do
        local BreakZone = BoxZone:Create(vector4(vector4(v.zones.x, v.zones.y, v.zones.z, v.zones.w)), Config.Bar[k].length, Config.Bar[k].width, {
            name= Config.Bar[k].label,
			debugPoly = Config.DebugPolyzone,
            heading = v.zones.w,
            minZ = v.zones.z - 2,
            maxZ = v.zones.z + 2, 
        })

        BreakZone:onPlayerInOut(function(isPointInside)
			if isPointInside then
                inZone = Config.Bar[k].label
                if inZone ~= 0 then
                    StressCheck()
                    NDCore.Functions.Notify('Седнете отпуснете се и стреса ще си отиде...', "primary")  
                end
            else
                inZone = 0
                stressed = false
            end
		end)
    end
end)

RegisterCommand('addstress', function()
    if Config.Command == true then
        TriggerServerEvent('hud:server:GainStress', 90)
    end
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)


