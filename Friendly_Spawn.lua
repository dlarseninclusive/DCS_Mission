-- Spawn function using MIST for aircraft at specified airfields
local function spawnAircraftWithMIST(airbaseName, airframe, count, countryId, side)
    local airbase = Airbase.getByName(airbaseName)
    local spawnPoint = airbase:getPoint()

    for i = 1, count do
        local groupName = string.format("%s_%s_%d", airbaseName, airframe, i)
        local unitName = string.format("%s_Unit_%d", airframe, i)
        
        local groupData = mist.dynAdd{
            country = countryId,
            category = 'airplane',
            name = groupName,
            payload = {}, -- Define the payload as needed or leave empty for default
            route = {}, -- Define the route as needed or leave empty for no waypoints
            units = {
                [1] = {
                    type = airframe,
                    name = unitName,
                    alt = spawnPoint.y,
                    speed = 0,
                    heading = 0,
                    x = spawnPoint.x + math.random(-50, 50), -- Adjust randomization as needed
                    y = spawnPoint.z + math.random(-50, 50),
                    skill = "Client",
                },
            },
        }

        -- Check if groupData was successfully added, then spawn the group
        if groupData then
            mist.dynAddGroup(groupData)
        else
            -- Handle the case where the groupData couldn't be added, possibly log or alert
            env.error("Failed to add group: " .. groupName)
        end
    end
end

-- Detailed spawn information
local spawnInfo = {
    {airbaseName = "Lar", airframe = "JF-17", count = 2, countryId = country.id.IRAN, side = coalition.side.RED},
    {airbaseName = "Jiroft", airframe = "F-14A", count = 2, countryId = country.id.IRAN, side = coalition.side.RED},
    -- Continue adding your aircraft and airfields here
}

-- Iterate and spawn aircraft using the spawn function
for _, info in ipairs(spawnInfo) do
    spawnAircraftWithMIST(info.airbaseName, info.airframe, info.count, info.countryId, info.side)
end