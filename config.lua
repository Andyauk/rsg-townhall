Config = {}

-- blip settings
Config.Blip = {
    blipName = 'Town Hall', -- Config.Blip.blipName
    blipSprite = 'blip_town', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

Config.TownHallLocations = {
    -- town hall locations
    { name = 'Valentine Town Hall', location = 'valentine-townhall', coords = vector3(-262.87, 761.80, 118.16 -1), showblip = true, showmarker = false }, --valentine
    -- add more as required
}

Config.Jobs = { -- note job must be in : rsg-core -> shared -> jobs
    { job = 'farmer',     title = 'Farmer',     description = 'Farm hand to help around the farm' },
    { job = 'unemployed', title = 'Freelancer', description = 'Like to do your own thing' },
}
