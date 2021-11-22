local QBCore = exports['qb-core']:GetCoreObject()

local loaded = false

CreateThread(
    function()
        loaded = true
        Wait(1000)
        SendNUIMessage(
            {
                type = "toggle",
                value = true
            }
        )
    end
)

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
