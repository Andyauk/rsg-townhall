local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------------------

-- prompts and blips
Citizen.CreateThread(function()
    for townhall, v in pairs(Config.TownHallLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-townhall:client:jobmenu',
            args = {},
        })
        if v.showblip == true then
            local TownhallBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(TownhallBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(TownhallBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, TownhallBlip, Config.Blip.blipName)
        end
    end
end)

-- draw marker if set to true in config
CreateThread(function()
    while true do
        local sleep = 1000

        for _, v in pairs(Config.TownHallLocations) do
            if v.showmarker then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local coord = v.coords
                local distance = #(coords - coord)

                if distance <= 10.0 then
                    sleep = 4

                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 215, 0, 155, false, false, false, 1, false, false, false)
                end
            end
        end

        Wait(sleep)
    end
end)

-----------------------------------------------------------------------------------

local options = {}

-- job menu
for _, v in ipairs(Config.Jobs) do
    table.insert(options, {
        title = 'Job Offer: '..v.title,
        description = v.description,
        icon = 'fa-solid fa-user',
        serverEvent = 'rsg-cityhall:server:ApplyJob',
        args = {
            job = v.job,
            title = v.title
        }
    })
end

RegisterNetEvent('rsg-townhall:client:jobmenu', function()
    lib.registerContext({
        id = 'job_menu',
        title = 'Job Menu',
        options = options
    })
    lib.showContext('job_menu')
end)

-----------------------------------------------------------------------------------
RegisterNetEvent('rsg-cityhall:client:NotifyJob')
AddEventHandler('rsg-cityhall:client:NotifyJob', function(title)
    -- Displaying a notification with the new job title
    lib.notify({ title = 'You are now a ' .. title, duration = 5000, type = 'success' })
end)
