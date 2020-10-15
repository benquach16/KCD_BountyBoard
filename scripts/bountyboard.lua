Bounty_Mod = {
    cUniqueIdName="uniqueIdBountyBoard",
    cUniqueIdName2="uniqueIdBountyBoard2",
    controllers = {}
}

function Bounty_Mod.CheckBounty1()
    allcontrollers = System.GetEntitiesByClass("BountyBoardController")
    local key, value = next(allcontrollers)
    local entity = value
    if entity == nil then
        Bounty_Mod.create()
    else
        System.LogAlways("Found existing BountyBoardController")
        table.insert(Bounty_Mod.controllers, entity)
    end
end

function Bounty_Mod.CheckBounty2()
    allcontrollers = System.GetEntitiesByClass("BountyBoardController2")
    local key, value = next(allcontrollers)
    local entity = value
    if entity == nil then
        Bounty_Mod.create2()
    else
        System.LogAlways("Found existing BountyBoardController2")
        table.insert(Bounty_Mod.controllers, entity)
    end
end

function Bounty_Mod.FG_Init()
    Bounty_Mod.CheckBounty1()
    Bounty_Mod.CheckBounty2()
    System.LogAlways("$5 Started BountyBoardMod")
end

function Bounty_Mod.cheat()
    Bounty_Mod.currController:cheat()
end

function Bounty_Mod.create()
    local position = player:GetWorldPos()
    System.LogAlways("$5 attempting to spawn bounty board controller.")
    
    local vec = { x=2637.618, y=621.0297, z=90.6986 }
    local spawnParams = {}
    spawnParams.class = "BountyBoardController"
    spawnParams.radius = 5
    spawnParams.name = Bounty_Mod.cUniqueIdName
    spawnParams.position=vec
    spawnParams.properties = {} 
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    entity:SpawnBountyBoard()
    table.insert(Bounty_Mod.controllers, entity)
end

function Bounty_Mod.create2()
    local position = player:GetWorldPos()
    System.LogAlways("$5 attempting to spawn bounty board controller 2.")
    
    local vec = { x = 942.3702, y = 1228.0, z = 26.2 }
    local spawnParams = {}
    spawnParams.class = "BountyBoardController2"
    spawnParams.radius = 5
    spawnParams.name = Bounty_Mod.cUniqueIdName2
    spawnParams.position=vec
    spawnParams.properties = {} 
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    entity:SpawnBountyBoard()
    table.insert(Bounty_Mod.controllers, entity)
end

function Bounty_Mod.uninstall()
    local entities = System.GetEntitiesByClass("BountyBoardController")
    for key, value in pairs(entities) do
        System.RemoveEntity(value.id)
    end
end

System.AddCCommand("bountymod_uninstall", "Bounty_Mod.uninstall()", "[Debug] test follower")
System.AddCCommand("bountymod", "Bounty_Mod.create2()", "[Debug] test follower")
System.AddCCommand("bountymod_cheat", "Bounty_Mod.cheat()", "[Debug] test follower")