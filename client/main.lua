local QBCore = exports['qb-core']:GetCoreObject()

local loaded = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    loaded = true
    SendNUIMessage(
        {
            type = "toggle",
            value = true
        }
    )
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    loaded = false
    SendNUIMessage(
        {
            type = "toggle",
            value = false
        }
    )
end)

CreateThread(
    function()
        while true do
            Wait(1000)

            if loaded and not IsPauseMenuActive() then
                QBCore.Functions.TriggerCallback(
                    "core_logohud:getInfo",
                    function(job, money, bank, online)
                        SendNUIMessage(
                            {
                                type = "update",
                                online = online or 0,
                                id = GetPlayerServerId(PlayerId()) or 0,
                                money = ("$" .. money) or "0",
                                bank = ("$" .. bank) or "0",
                                job = string.upper(job) or ""
                            }
                        )
                    end
                )
            else
                SendNUIMessage(
                    {
                        type = "toggle",
                        value = false
                    }
                )
            end
        end
    end
)
