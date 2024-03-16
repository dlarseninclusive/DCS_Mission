local spawnInfo = {
    -- Example for Khasab with multiple airframes
    ["Khasab"] = {
        {airframe = "F-5E", count = 3},
        {airframe = "MiG-21bis", count = 3},
        {airframe = "Su-25T", count = 2},
    },
    -- Additional airbases can be added following the same structure
}
function spawnAircraft(airbaseName, airframe, count)
    for i = 1, count do
        local groupName = string.format("%s_%s_%d", airbaseName, airframe, i)
        local countryId = country.id.RUSSIA -- Adjust based on airframe's coalition
        local airbase = Airbase.getByName(airbaseName)
        local spawnPoint = airbase:getPoint()
        
        local groupData = {
            ["visible"] = false,
            ["tasks"] = {},
            ["uncontrollable"] = false,
            ["route"] = {points = {}},
            ["groupId"] = mist.generateGroupId(),
            ["hidden"] = false,
            ["units"] = {
                [1] = {
                    ["alt"] = spawnPoint.y,
                    ["type"] = airframe,
                    ["name"] = groupName,
                    ["unitId"] = mist.generateUnitId(),
                    ["heading"] = 0,
                    ["skill"] = "Client",
                    ["x"] = spawnPoint.x + math.random(-100, 100), -- Randomize a bit to prevent spawning at the exact same point
                    ["y"] = spawnPoint.z + math.random(-100, 100),
                    ["payload"] = {},
                    ["playerCanDrive"] = true,
                },
            },
            ["name"] = groupName,
            ["task"] = "Nothing",
            ["category"] = "plane",
            ["country"] = countryId,
        }

        -- Spawn the group
        coalition.addGroup(countryId, Group.Category.AIR, groupData)
    end
end
for airbaseName, aircraftList in pairs(spawnInfo) do
    for _, aircraftInfo in ipairs(aircraftList) do
        spawnAircraft(airbaseName, aircraftInfo.airframe, aircraftInfo.count)
    end
end
