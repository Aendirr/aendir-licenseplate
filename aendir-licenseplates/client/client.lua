local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('aendir-licenseplates:client:applyplate', function ()
    if Config.UseJob then
        if PlayerJob.name == Config.Job then
            UnScrewPlate()
        else
            QBCore.Functions.Notify('Bunu Yapamazsın. Yapabilecek Birini Bul', 'error', 4000)
        end
    else
        UnScrewPlate()
    end
end)

function UnScrewPlate()
    local player = PlayerPedId()
    local closevehicle, closestDistance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    if closevehicle ~= -1 and closestDistance < 3.5 then
        local playerpos = GetEntityCoords(player)
        local OriginalPlate = QBCore.Functions.GetPlate(closevehicle)
        local VehPos = GetOffsetFromEntityInWorldCoords(closevehicle, 0.0, -3.5, 0.5)
        local VehDist = GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, VehPos.x, VehPos.y, VehPos.z, true)
        if VehDist <= 1.5 then
            QBCore.Functions.Progressbar('unscrew_plate', 'Plaka Sökülüyor', math.random(8000, 9500), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                anim = 'machinic_loop_mechandplayer',
                flags = 1,
            }, {}, {}, function() -- Done
                QBCore.Functions.Progressbar('unscrew_plate', 'Yeni Plaka Takılıyor', math.random(8000, 9500), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('aendir-licenseplates:server:checkplateinfo',closevehicle, OriginalPlate)
                    ClearPedTasks(player)
                end, function() -- Cancel
                    ClearPedTasks(player)
                    QBCore.Functions.Notify('Cancelled', 'error')
                end)
            end, function() -- Cancel
                ClearPedTasks(player)
                QBCore.Functions.Notify('Cancelled', 'error')
            end)
        end
    end
end

RegisterNetEvent('aendir-licenseplates:client:setvehicleplate', function (closevehicle, NewPlate, OriginalPlate)
    SetVehicleNumberPlateText(closevehicle, NewPlate)
    TriggerEvent('vehiclekeys:client:SetOwner', NewPlate)
    TriggerServerEvent('aendir-licenseplates:giveoldlicenseplate', OriginalPlate, NewPlate)
end)