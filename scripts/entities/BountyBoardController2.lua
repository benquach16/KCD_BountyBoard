BountyBoardConstants2 = {
    -- all quests should have 1 objective.
    -- you could do more, but then you would have to build a 2D table
    cObjectiveName = "objective1",

    cCorpseTimer = 3000,
    cRewardFuzz = 50,
    cUseNormalAI = false,
    cEndRadius = 900,
    cAutoFailDistance = 10000
}

BountyBoardController2 = {
    -- will point to an entry in bountyboardquests
    currentQuestKey = nil,
    -- this will be our list of entities that we want to track for objectives
    targets = {},
    -- will be used for onload events
    needReload = false,
    -- used for escort mission targets
    startLocation = nil,
    endLocationName = nil,
    targetEntity = nil,
    -- reference to guy
    crier = nil
}

BountyBoardQuestTypes2 = {
    Escort = 0,
}

-- quest ideas
-- "Escort merchant to location"
BountyBoardQuests2 = {
    -- name MUST be quest name that is defined in xml. markerSoulId MUST be soul id defined in quest (so that we can track)
    { 
    name="quest_escort_merchant", 
    markerSoulId = "895dbf10-155c-4b91-abf3-dd48fe4967c6", 
    extraSoulIds = {}, 
    baseReward = 50 ,
    questType = BountyBoardQuestTypes2.Escort,
    }
}

-- grab one for starting, and another one that is different for ending
BountyBoardLocations2 = {
    { position = { x = 2060, y = 1307, z = 31.2 } , name="Ledetchko" },
    { position = {x =2558.429,y =463.0462,z = 68.1582} , name="Pirkstein Castle" },
    --{ position = {x =911.6,y =1703.476,z = 43.7582} , name="Sasau Monastary" },
    { position = {x =1635.6,y =2619.476,z = 126.8582} , name="Merhojed" },
    { position = {x =1138.585,y =2235.476,z = 71.5582} , name="Samopesh" },
}

BountyBoardLocations2test = {
    { position = { x = 20, y = 20, z = 33.2 } , name="test location" },
}

function BountyBoardController2:AssignActions(entity)
    entity.GetActions = function (user,firstFast)
        output = {}
        AddInteractorAction( output, firstFast, Action():hint("Get new contract"):action("use"):hintType( AHT_HOLD ):func(entity.OnUsed):interaction(inr_talk))
        return output
    end
    entity.Properties.controller = self
    entity.OnUsed = function (self, user)
        -- if no quest active, then assign new quest
        -- otherwise tell them no
        if self.Properties.controller.currentQuestKey == nil then
            self.Properties.controller:GenerateQuest()
            
            local message = "Here's a new contract!"
            message = message .. " Escort to " .. self.Properties.controller.endLocationName
            Game.SendInfoText(message,false,nil,10)
        else
            Game.SendInfoText("Finish your current contract first!",false,nil,10)
        end
        
    end
end

-- Spawn the town crier so you can talk to him and get quests
function BountyBoardController2:SpawnBountyBoard()
    local position = player:GetWorldPos()
    System.LogAlways("$5 attempting to spawn test.")
    
    local vec = { x=886.508, y=1193.0, z=25.9 }
    local spawnParams = {}
    spawnParams.class = "NPC"
    spawnParams.radius = 5
    spawnParams.name = "chaser"
    spawnParams.position=vec
    --spawnParams.position = position
    spawnParams.orientation = { x = 0.504, y = -0.86, z = 0 }
    spawnParams.properties = {} 
    spawnParams.properties.sharedSoulGuid = "836635bf-89dd-4c1a-8e27-59b440435ecb"
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    self:AssignActions(entity)
    self.crier = entity
end

function BountyBoardController2:SpawnTarget(soulGuid, position)
    local spawnParams = {}
    spawnParams.class = "NPC"
    spawnParams.radius = 5
    spawnParams.name = "chaser"
    spawnParams.position=position
    spawnParams.properties = {} 
    spawnParams.orientation = { x = 0, y = math.random() - math.random(), z = 0 }
    spawnParams.properties.sharedSoulGuid = soulGuid
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    
    entity.soul:SetState("health", 200)
    entity.soul:AdvanceToStatLevel("str",30)
    entity.soul:AdvanceToStatLevel("agi",30)
    entity.soul:AdvanceToStatLevel("vit",30)
    entity.soul:AdvanceToSkillLevel("defense",30)
    --entity.soul:AdvanceToSkillLevel("fencing",15)
    entity.soul:AdvanceToSkillLevel("weapon_large",30)
    entity.soul:AdvanceToSkillLevel("weapon_sword",30)
    entity.soul:AdvanceToSkillLevel("weapon_mace",25)
    entity.soul:AdvanceToSkillLevel("weapon_axe",25)
    entity.soul:AdvanceToSkillLevel("weapon_bow",25)
    entity.soul:AdvanceToSkillLevel("weapon_unarmed",25)
    
    entity.soul:AddPerk(string.upper("d2da2217-d46d-4cdb-accb-4ff860a3d83e")) -- perfect block
    entity.soul:AddPerk(string.upper("ec4c5274-50e3-4bbf-9220-823b080647c4")) -- riposte
    entity.soul:AddPerk(string.upper("3e87c467-681d-48b5-9a8c-485443adcd42")) -- pommel strike
    entity.soul:AddPerk(string.upper("0f3cffa7-d80b-4688-934d-784a09269f60")) -- blood rush
    entity.soul:AddPerk(string.upper("7d124502-f7ac-42ad-bb27-cba085fb69be")) -- LS combo 4
    entity.soul:AddPerk(string.upper("550db16e-b917-4057-b3ac-39bf401d1157")) -- berserk 
    --entity.soul:AddPerk(string.upper("2cd86a68-776f-4d9b-ae3f-a0273dfff1f6")) -- last gasp
    entity.soul:AddPerk(string.upper("55ae0147-365e-43c5-ae42-8c6f04a5bb0f")) -- chain
    entity.soul:AddPerk(string.upper("47709bf7-3bd8-493f-aca3-05b005f166d8")) -- feint
    entity.soul:AddPerk(string.upper("bf886546-1e88-4ff8-b3ea-85386a8ace08")) -- furious
    entity.soul:AddPerk(string.upper("8f1af639-7e7f-49e3-ae25-e3cfefa2a054")) -- close shave
    
    return entity
end

function BountyBoardController2:OnSpawn()
    -- needed for OnUpdate callback
    self:Activate(1)
end

function BountyBoardController2:OnDestroy()
    for key,value in pairs(self.targets) do
        System.RemoveEntity(value.id)
        self.targets[key] = nil
    end
end

function BountyBoardController2:OnSave(tbl)
    tbl.currentQuestKey = self.currentQuestKey
    tbl.crier = self.crier:GetGUID()
    -- store the GUIDs, which will be fetched in OnLoad
    if self.targetEntity ~= nil then
        tbl.targetEntity = self.targetEntity:GetGUID()
    end
    tbl.targets = {}
    for key,value in pairs(self.targets) do
        table.insert(tbl.targets, value:GetGUID())
    end
    tbl.endLocationName = self.endLocationName
end

function BountyBoardController2:OnLoad(tbl)
    self.currentQuestKey = tbl.currentQuestKey
    self.crier = System.GetEntityByGUID(tbl.crier)
    self.crier:SetViewDistUnlimited()
    self.targetEntity = System.GetEntityByGUID(tbl.targetEntity)
    self.endLocationName = tbl.endLocationName
    for key,value in pairs(tbl.targets) do
        local ent = System.GetEntityByGUID(value)
        table.insert(self.targets, ent)

        System.LogAlways("found target")
    end
    self.needReload = true
    
end

function BountyBoardController2:GenerateRandomKey(tbl)
    local keyset = {}
    for k in pairs(tbl) do
        table.insert(keyset, k)
    end
    local key = math.random(#keyset)
    return keyset[key]
end

function BountyBoardController2:Outfit(entity, quest)
    if math.random(2) == 2 then
    end
end

function BountyBoardController2:InitializeEntityForQuest(entity, quest)
    entity.Properties.controller = self
    if quest.name == "quest_escort_merchant" then
        local initmsg = Utils.makeTable('skirmish:init',{controller=player.this.id,isEnemy=false,oponentsNode=player.this.id,useQuickTargeting=true,targetingDistance=5.0, useMassBrain=BountyBoardConstants.cUseNormalAI})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:init',initmsg);
        local initmsg = Utils.makeTable('skirmish:barkSetup',{ metarole="UDELEJ_TO_NENASILNE", cooldown="10s", once=false, command="*", forceSubtitles = false})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:barkSetup',initmsg);
        entity.GetActions = function (self,user,firstFast)
            output = {}
            if self.actor:GetHealth() > 0 and self.actor:IsUnconscious() == false then
                AddInteractorAction( output, firstFast, Action():hint("I'm ready."):action("use"):func(entity.Go):interaction(inr_talk))
                AddInteractorAction( output, firstFast, Action():hint("Let's stop and rest a bit."):action("use"):hintType( AHT_HOLD ):func(entity.Stop):interaction(inr_talk))
            end
            return output
        end
        entity.Go = function (self, user)
            local initmsg3 = Utils.makeTable('skirmish:command',{type="attackMove",target=self.Properties.controller.targetEntity.this.id, randomRadius=0.5, movementSpeed="AlertedWalk", clearQueue=true, immediate=true})
            XGenAIModule.SendMessageToEntityData(self.soul:GetId(),'skirmish:command',initmsg3);

            local message = "Let's go!"
            message = message .. " I am headed to " .. self.Properties.controller.endLocationName
            Game.SendInfoText(message,false,nil,10)
        end
        entity.Stop = function (self, user)
            if self.actor:GetHealth() < 80 and self.actor:IsUnconscious() == false then
                local initmsg2 = Utils.makeTable('skirmish:command',{type="holdGround", clearQueue=true, immediate=true})
                XGenAIModule.SendMessageToEntityData(self.Follower.this.id,'skirmish:command',initmsg2);
                self.soul:SetState( "health", 100 )
                --self.soul:SetState( "stamina", 100 );
                self.soul:SetState( "exhaust", 100 )
                self.soul:SetState( "hunger", 100 )
                self.soul:HealBleeding(1, 1)
                self.soul:HealBleeding(1, 2)
                self.soul:HealBleeding(1, 3)
                self.soul:HealBleeding(1, 4)
                self.soul:HealBleeding(1, 5)
                self.soul:HealBleeding(1, 6)
                Game.SendInfoText("OK. But we shouldn't waste too much time.",false,nil,5)
            else
                Game.SendInfoText("We don't need to rest right now.",false,nil,5)
            end
        end
    end
end

function BountyBoardController2.getrandomposnear(position, radius)
    -- deep copy
    local ret = {}
    ret.x = position.x
    ret.y = position.y
    ret.z = position.z
    ret.x = position.x + (math.random() * 2) - (math.random() * 2) + math.random(0, radius) - math.random(0, radius)
    ret.y = position.y + (math.random() * 2) - (math.random() * 2) + math.random(0, radius) - math.random(0, radius)
    return ret
end

function BountyBoardController2:GenerateQuest()
    -- assert(self.currentQuestKey == nil)
    self.currentQuestKey = self:GenerateRandomKey(BountyBoardQuests2)
    local currentQuest = BountyBoardQuests2[self.currentQuestKey]
    
    -- choose random location to spawn souls
    --local startLocation = player:GetWorldPos()
    --location.x = location.x + 15
    local startLocation = { x = 942.3702, y = 1228.0, z = 26.2 }
    local markerlocation = self.getrandomposnear(startLocation, 0.5)
    local marker = self:SpawnTarget(currentQuest.markerSoulId, markerlocation)
    --local marker = self:SpawnTarget(currentQuest.markerSoulId, pos)
    self:InitializeEntityForQuest(marker, currentQuest)
    self:Outfit(marker, currentQuest)
    table.insert(self.targets, marker)

    local locationKey = self:GenerateRandomKey(BountyBoardLocations2)
    local endLocation = BountyBoardLocations2[locationKey]
    self.targetEntity = self:CreateAITagPoint(endLocation.position)
    self.endLocationName = endLocation.name
    for key,value in pairs(currentQuest.extraSoulIds) do
        local entlocation = self.getrandomposnear(startLocation, 2.0)
        local entity = self:SpawnTarget(value, entlocation)
        --local marker = self:SpawnTarget(currentQuest.markerSoulId, pos)
        self:InitializeEntityForQuest(entity, currentQuest)
        self:Outfit(entity, currentQuest)
        table.insert(self.targets, entity)
    end
    
    -- must start quest after spawning marker soul
    QuestSystem.ResetQuest(currentQuest.name)
    QuestSystem.ActivateQuest(currentQuest.name)
    QuestSystem.StartQuest(currentQuest.name)
end

function BountyBoardController2.RemoveCorpse(entity)
    entity:DestroyPhysics()
    --entity:DeleteThis()
    System.RemoveEntity(entity.id)
end

function BountyBoardController2:TrackTargets()
    for key,value in pairs(self.targets) do
        if value.soul:GetState("health") < 1 then
            System.LogAlways("killed")
            -- if we spawned this we have to manually delete the corpse ourselves
            Script.SetTimer(BountyBoardConstants.cCorpseTimer, self.RemoveCorpse, value)
            -- has been killed, remove it from targets
            self.targets[key] = nil
        end
    end
end

function BountyBoardController2.RemoveTargets(self)
    System.RemoveEntity(self.targetEntity.id)
    self.targetEntity = nil
    for key,value in pairs(self.targets) do
        System.RemoveEntity(value.id)
        self.targets[key] = nil
    end
end

function BountyBoardController2:FinishQuest()
    Game.SendInfoText("You completed the contract!",false,nil,10)
    local currentQuest = BountyBoardQuests2[self.currentQuestKey]
    -- self.targets is empty, complete objective
    QuestSystem.CompleteObjective(currentQuest.name, BountyBoardConstants2.cObjectiveName)
    -- give reward
    local reward = currentQuest.baseReward + math.random(0, BountyBoardConstants2.cRewardFuzz)
    local dist = DistanceVectors(self.targetEntity:GetWorldPos(), { x = 942.3702, y = 1228.0, z = 26.2 })
    reward = reward + (dist * 0.5)
    AddMoneyToInventory(player,reward * 10)
    -- reset state
    Script.SetTimer(20000, self.RemoveTargets, self)
    self.currentQuestKey = nil

    self.endLocation = nil
    self.startLocation = nil
end

function BountyBoardController2:FinishQuestFailure()
    Game.SendInfoText("You failed your mission!",false,nil,10)
    local currentQuest = BountyBoardQuests2[self.currentQuestKey]
    -- self.targets is empty, complete objective
    --QuestSystem.CancelObjective(currentQuest.name)
    QuestSystem.CompleteObjective(currentQuest.name, BountyBoardConstants2.cObjectiveName)
    self.currentQuestKey = nil
    self.endLocation = nil

    self.startLocation = nil
    self.RemoveTargets(self)
end

function BountyBoardController2:HandleEscortQuest()
    self:TrackTargets()
    -- if self.targets is empty, guy died and we failed the quest
    if next(self.targets) == nil then
        self:FinishQuestFailure()
    end
    
    local position = self.targetEntity:GetWorldPos()
    --Dump(position)
    for key,value in pairs(self.targets) do
        local dist = DistanceSqVectors(value:GetWorldPos(), position)
        if dist < BountyBoardConstants2.cEndRadius then
            self:FinishQuest()
        end
        local playerDist = DistanceSqVectors(value:GetWorldPos(), player:GetWorldPos())
        if playerDist > BountyBoardConstants2.cAutoFailDistance then
            self:FinishQuestFailure()
        end
    end
end

function BountyBoardController2:CreateAITagPoint(location)
    local spawnParams = {}
    spawnParams.class = "Grunt"
    spawnParams.name = "locationpoint"
    spawnParams.position=location
    spawnParams.properties = {}
    spawnParams.properties.bWH_PerceptibleObject = 0
    local entity = System.SpawnEntity(spawnParams)
    return entity
end

function BountyBoardController2:OnUpdate(delta)
    if self.needReload == true then
        -- initialization must be sent after OnLoad() because the entities may not have been loaded
        -- at that time
        self:AssignActions(self.crier)
        if self.currentQuestKey ~= nil then
            local currentQuest = BountyBoardQuests2[self.currentQuestKey]
            for key,value in pairs(self.targets) do
                self:InitializeEntityForQuest(value, currentQuest)
                value:SetViewDistUnlimited()
            end
        end
        self.needReload = false
    else
        if self.currentQuestKey ~= nil then
            local currentQuest = BountyBoardQuests2[self.currentQuestKey]
            --Dump(currentQuest.name)
            if currentQuest.name == "quest_escort_merchant" then
                self:HandleEscortQuest()
            end
        end
    end
end
