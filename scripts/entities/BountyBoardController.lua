BountyBoardConstants = {
    -- all quests should have 1 objective.
    -- you could do more, but then you would have to build a 2D table
    cObjectiveName = "objective1",
    cKnight = 0,
    cManAtArms = 1,
    cBandit = 2,
    cCorpseTimer = 60000,
    cRewardFuzz = 200,
    cUseNormalAI = false,
}

BountyBoardController = {
    -- will point to an entry in bountyboardquests
    currentQuestKey = nil,
    -- this will be our list of entities that we want to track for objectives
    targets = {},
    -- will be used for onload events
    needReload = false,
    -- used for escort mission targets
    escortDestination = nil,
    -- reference to guy in rattay
    crier = nil
}

BountyBoardArmorPresets = {
}
BountyBoardArmorPresets[BountyBoardConstants.cKnight] = {
    "45f37e64-ec6c-fff6-5394-b54f2a8ac1ab", -- knight
    "4e6bad1a-b67e-34ad-a947-20a7f9656386", -- knight
    "494998a6-52aa-77d7-e802-ae79f08fcb8e", -- knight
    "49f530ba-3063-fb5e-bd05-802b54ad0ea9", -- knight
}
BountyBoardArmorPresets[BountyBoardConstants.cManAtArms] = {
    "4f5d68d5-adf8-6324-01b5-2acd4929509c", -- manatarms
    "46683925-7d7f-4910-9edc-7887d9647d8f", -- manatarms
    "48a855c5-8304-f9f2-90ba-8367f9bf1d9e", -- manatarms
}
BountyBoardArmorPresets[BountyBoardConstants.cBandit] = {
    "4f5db99b-7f11-f924-1be2-2a9943b9fb98", -- bandit
    "478dd60a-826c-3b38-a06f-8620898ee5ba", -- bandit
    "44b8b363-9ebf-b595-9de0-52f1a5fc3e8a", -- bandit
}

BountyBoardWeaponPresets = {
}
BountyBoardWeaponPresets[BountyBoardConstants.cKnight] = {
    "4b3e6785-b67d-e259-82f6-799df28696a5", -- lucerne
    "4a8568fa-eecb-9e2b-4cc1-246efffad3ac", -- warhammer
    "42b5972a-2042-1e52-9443-8207849c74a5", -- shortsword
    "480a47e2-1106-2e83-e14c-bd1e834642b3", -- halberd
    "4b2289ad-1a5e-96ab-5c9d-6c885924a593", -- ls
}

BountyBoardWeaponPresets[BountyBoardConstants.cBandit] = {
    "4a8568fa-eecb-9e2b-4cc1-246efffad3ac", -- warhammer
    "42b5972a-2042-1e52-9443-8207849c74a5", -- shortsword
    "4b2289ad-1a5e-96ab-5c9d-6c885924a593", -- ls
}

BountyBoardQuestTypes = {
    Kill = 0,
    Escort = 1,
}

-- quest ideas
-- "Duel this knight/mercenary because they have done something bad to me"
-- "Clear band of mercenaries"
-- "Clear band of bandits"
-- "Clear band of cumans"
-- "Kill specific wanderer/bandit leader/mercenary leader/cuman leader/hostile knight"
-- "Escort merchant to location"
BountyBoardQuests = {
    -- name MUST be quest name that is defined in xml. markerSoulId MUST be soul id defined in quest (so that we can track)
    { 
    name="quest_bounty_duel", 
    markerSoulId = "3acb7822-1ea2-42e5-a385-ae9ed84a1908", 
    extraSoulIds = {}, 
    baseReward = 500 ,
    questType = BountyBoardQuestTypes.Kill,
    },
    { 
    name="quest_bounty_kill", 
    markerSoulId = "45f25146-83b4-42b5-a3c9-047b1b7a35e3", 
    extraSoulIds = {}, 
    baseReward = 500,
    questType = BountyBoardQuestTypes.Kill,
    },
    { 
    name="quest_bounty_kill_mercenaries", 
    markerSoulId = "45f25146-83b4-42b5-a3c9-047b1b7a35e3", 
    extraSoulIds = {"45f25146-83b4-42b5-a3c9-047b1b7a35e3"}, 
    baseReward = 1100,
    questType = BountyBoardQuestTypes.Kill,
    },
    { 
    name="quest_bounty_kill_bandits", 
    markerSoulId = "498bda22-f132-47bc-b41c-5a27446597a4", 
    extraSoulIds = {"498bda22-f132-47bc-b41c-5a27446597a4", "498bda22-f132-47bc-b41c-5a27446597a4", "498bda22-f132-47bc-b41c-5a27446597a4"}, 
    baseReward = 1200,
    questType = BountyBoardQuestTypes.Kill,
    }
}

-- easy way to get new locations: open editor, go to someplace cool, copy the coordinates here
BountyBoardLocations = {
    { x = 2838.639, y = 770.5074, z = 91.8731 },
    { x = 2228.57, y = 732.102, z = 29.8 },
    { x = 3203.417, y = 736.6588, z = 103.1231 },
    { x = 3273.173, y = 1979.708, z = 155.2231 },
    { x = 628.0364, y = 1142.354, z = 17.8591 },
    { x = 944.8499, y = 1981.125, z = 32.15 },
    { x = 822.6176, y = 2320.137, z = 31.3534 },
    { x = 1263.678, y = 2389.309, z = 101.0432 },
    { x = 1719.569, y = 776.1462, z = 73.5632 },
    { x = 782.1455, y = 2562.987, z = 20.5632 },
    { x = 692.8655, y = 2543.887, z = 16.9 },
    { x = 2382.904, y = 1023.902, z = 66.1 },
    { x = 1736.274, y = 2401.052, z = 132.1 },
}

-- grab one for starting, and another one that is different for ending
BountyBoardEscortLocations = {
    { position = { x = 2060, y = 1307, z = 31.2 } , name="Ledetchko" },
    { position = {x =2558.429,y =463.0462,z = 68.1582} , name="Pirkstein Castle" },
    { position = {x =911.6,y =1703.476,z = 43.7582} , name="Sasau Monastary" },
}

function BountyBoardController:AssignActions(entity)
    entity.GetActions = function (user,firstFast)
        output = {}
        AddInteractorAction( output, firstFast, Action():hint("Get new bounty"):action("use"):hintType( AHT_HOLD ):func(entity.OnUsed):interaction(inr_talk))
        return output
    end
    entity.Properties.controller = self
    entity.OnUsed = function (self, user)
        -- if no quest active, then assign new quest
        -- otherwise tell them no
        if self.Properties.controller.currentQuestKey == nil then
            Game.SendInfoText("Here's a new bounty!",false,nil,10)
            self.Properties.controller:GenerateQuest()
        else
            Game.SendInfoText("Finish your current bounty first!",false,nil,10)
        end
        
    end
end

-- Spawn the town crier so you can talk to him and get quests
function BountyBoardController:SpawnBountyBoard()
    local position = player:GetWorldPos()
    System.LogAlways("$5 attempting to spawn test.")
    
    local vec = { x=2637.618, y=621.0297, z=90.6986 }
    local spawnParams = {}
    spawnParams.class = "NPC"
    spawnParams.radius = 5
    spawnParams.name = "chaser"
    spawnParams.position=vec
    --spawnParams.position = position
    spawnParams.orientation = { x = 0, y = 90, z = 0 }
    spawnParams.properties = {} 
    spawnParams.properties.sharedSoulGuid = "f6dab705-f008-4605-aa2d-53b18148a6da"
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    self:AssignActions(entity)
    self.crier = entity
end

function BountyBoardController:SpawnTarget(soulGuid, position)
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
    
    entity.soul:SetState("health", 700)
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

function BountyBoardController:OnSpawn()
    -- needed for OnUpdate callback
    self:Activate(1)
end

function BountyBoardController:OnDestroy()
    for key,value in pairs(self.targets) do
        System.RemoveEntity(value.id)
        self.targets[key] = nil
    end
end

function BountyBoardController:OnSave(tbl)
    tbl.currentQuestKey = self.currentQuestKey
    tbl.crier = self.crier:GetGUID()
    -- store the GUIDs, which will be fetched in OnLoad()
    tbl.targets = {}
    for key,value in pairs(self.targets) do
        table.insert(tbl.targets, value:GetGUID())
    end
end

function BountyBoardController:OnLoad(tbl)
    self.currentQuestKey = tbl.currentQuestKey
    self.crier = System.GetEntityByGUID(tbl.crier)
    self.crier:SetViewDistUnlimited()
    for key,value in pairs(tbl.targets) do
        local ent = System.GetEntityByGUID(value)
        table.insert(self.targets, ent)
        ent:SetViewDistUnlimited()
        System.LogAlways("found target")
    end
    self.needReload = true
end

function BountyBoardController:GenerateRandomKey(tbl)
    local keyset = {}
    for k in pairs(tbl) do
        table.insert(keyset, k)
    end
    local key = math.random(#keyset)
    return keyset[key]
end

function BountyBoardController:Outfit(entity, quest)
    if math.random(2) == 2 then
        if quest.name == "quest_bounty_duel" then
            local key = self:GenerateRandomKey(BountyBoardArmorPresets[BountyBoardConstants.cKnight])
            entity.actor:EquipClothingPreset(BountyBoardArmorPresets[BountyBoardConstants.cKnight][key])
        elseif quest.name == "quest_bounty_kill" then
            local key = self:GenerateRandomKey(BountyBoardArmorPresets[BountyBoardConstants.cManAtArms])
            entity.actor:EquipClothingPreset(BountyBoardArmorPresets[BountyBoardConstants.cManAtArms][key])
            key = self:GenerateRandomKey(BountyBoardWeaponPresets[BountyBoardConstants.cKnight])
            entity.actor:EquipWeaponPreset(BountyBoardWeaponPresets[BountyBoardConstants.cKnight][key])
        elseif quest.name == "quest_bounty_kill_mercenaries" then
            local key = self:GenerateRandomKey(BountyBoardArmorPresets[BountyBoardConstants.cManAtArms])
            entity.actor:EquipClothingPreset(BountyBoardArmorPresets[BountyBoardConstants.cManAtArms][key])
            key = self:GenerateRandomKey(BountyBoardWeaponPresets[BountyBoardConstants.cKnight])
            entity.actor:EquipWeaponPreset(BountyBoardWeaponPresets[BountyBoardConstants.cKnight][key])
        elseif quest.name == "quest_bounty_kill_bandits" then
            local key = self:GenerateRandomKey(BountyBoardArmorPresets[BountyBoardConstants.cBandit])
            entity.actor:EquipClothingPreset(BountyBoardArmorPresets[BountyBoardConstants.cBandit][key])
            key = self:GenerateRandomKey(BountyBoardWeaponPresets[BountyBoardConstants.cBandit])
            entity.actor:EquipWeaponPreset(BountyBoardWeaponPresets[BountyBoardConstants.cBandit][key])
        end
    end
end

function BountyBoardController:InitializeEntityForQuest(entity, quest)
    if quest.name == "quest_bounty_duel" then
        local initmsg = Utils.makeTable('skirmish:init',{controller=player.this.id,isEnemy=false,oponentsNode=player.this.id,useQuickTargeting=true,targetingDistance=5.0, useMassBrain=BountyBoardConstants.cUseNormalAI})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:init',initmsg);
        entity.GetActions = function (self,user,firstFast)
            output = {}
            if self.actor:GetHealth() > 0 and self.actor:IsUnconscious() == false then
                AddInteractorAction( output, firstFast, Action():hint("Request Duel"):action("use"):hintType( AHT_HOLD ):func(entity.Duel):interaction(inr_talk))
            end
            return output
        end
        entity.Duel = function (self, user)
            Game.SendInfoText("I accept your duel!",false,nil,10)
            local initmsg2 = Utils.makeTable('skirmish:command',{type="attack",target=player.this.id})
            XGenAIModule.SendMessageToEntityData(self.this.id,'skirmish:command',initmsg2);
        end
    elseif quest.name == "quest_escort_merchant" then
        local initmsg = Utils.makeTable('skirmish:init',{controller=player.this.id,isEnemy=false,oponentsNode=player.this.id,useQuickTargeting=true,targetingDistance=5.0, useMassBrain=BountyBoardConstants.cUseNormalAI})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:init',initmsg);
        entity.GetActions = function (self,user,firstFast)
            output = {}
            if self.actor:GetHealth() > 0 and self.actor:IsUnconscious() == false then
                AddInteractorAction( output, firstFast, Action():hint("I'm ready."):action("use"):hintType( AHT_HOLD ):func(entity.Duel):interaction(inr_talk))
            end
            return output
        end
        entity.Duel = function (self, user)
            Game.SendInfoText("Let's go!",false,nil,10)
        end
    else -- kill bandits, mercenaries, or single mercenary
        local initmsg = Utils.makeTable('skirmish:init',{controller=player.this.id,isEnemy=false,oponentsNode=player.this.id,useQuickTargeting=true,targetingDistance=5.0, useMassBrain=BountyBoardConstants.cUseNormalAI})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:init',initmsg);
        System.LogAlways("ordered")
        -- setting hostile to player too early has issues
        local initmsg2 = Utils.makeTable('skirmish:command',{type="turnOnPlayer",target=player.this.id, immediate=true})
        XGenAIModule.SendMessageToEntityData(entity.this.id,'skirmish:command',initmsg2);
    end
end

function BountyBoardController.getrandomposnear(position, radius)
    -- deep copy
    local ret = {}
    ret.x = position.x
    ret.y = position.y
    ret.z = position.z
    ret.x = position.x + (math.random() * 2) - (math.random() * 2) + math.random(0, radius) - math.random(0, radius)
    ret.y = position.y + (math.random() * 2) - (math.random() * 2) + math.random(0, radius) - math.random(0, radius)
    return ret
end

function BountyBoardController:GenerateQuest()
    -- assert(self.currentQuestKey == nil)
    self.currentQuestKey = self:GenerateRandomKey(BountyBoardQuests)
    local currentQuest = BountyBoardQuests[self.currentQuestKey]
    
    -- choose random location to spawn souls
    local locationKey = self:GenerateRandomKey(BountyBoardLocations)
    --local location = player:GetWorldPos()
    --location.x = location.x + 15
    local location = BountyBoardLocations[locationKey]
    
    if currentQuest.name == "quest_escort_merchant" then
    end
    
    local markerlocation = self.getrandomposnear(location, 0.5)
    local marker = self:SpawnTarget(currentQuest.markerSoulId, markerlocation)
    --local marker = self:SpawnTarget(currentQuest.markerSoulId, pos)
    self:InitializeEntityForQuest(marker, currentQuest)
    self:Outfit(marker, currentQuest)
    table.insert(self.targets, marker)
    
    for key,value in pairs(currentQuest.extraSoulIds) do
        local entlocation = self.getrandomposnear(location, 2.0)
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

function BountyBoardController.RemoveCorpse(entity)
    entity:DestroyPhysics()
    --entity:DeleteThis()
    System.RemoveEntity(entity.id)
end

function BountyBoardController:TrackTargets()
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

function BountyBoardController:FinishQuest()
   Game.SendInfoText("You completed the bounty!",false,nil,10)
   local currentQuest = BountyBoardQuests[self.currentQuestKey]
   -- self.targets is empty, complete objective
   QuestSystem.CompleteObjective(currentQuest.name, BountyBoardConstants.cObjectiveName)
   -- give reward
   local reward = currentQuest.baseReward + math.random(0, BountyBoardConstants.cRewardFuzz)
   AddMoneyToInventory(player,reward * 10)
   -- reset state
   self.currentQuestKey = nil
end

function BountyBoardController:FinishQuestFailure()
    Game.SendInfoText("You failed your mission!",false,nil,10)
    local currentQuest = BountyBoardQuests[self.currentQuestKey]
   -- self.targets is empty, complete objective
   QuestSystem.CompleteObjective(currentQuest.name, BountyBoardConstants.cObjectiveName)
   self.currentQuestKey = nil
end

function BountyBoardController:HandleKillQuest()
    self:TrackTargets()
    -- if self.targets is empty, we completed the quest
    if next(self.targets) == nil then
        self:FinishQuest()
    end
end

function BountyBoardController:HandleEscortQuest()
    self:TrackTargets()
    -- if self.targets is empty, guy died and we failed the quest
    if next(self.targets) == nil then
        self:FinishQuestFailure()
    end
end


function BountyBoardController:cheat()
    for key,value in pairs(self.targets) do
        value.soul:DealDamage(200,200)
    end
end


function BountyBoardController:OnUpdate(delta)
    if self.needReload == true then
        -- initialization must be sent after OnLoad() because the entities may not have been loaded
        -- at that time
        self:AssignActions(self.crier)
        if self.currentQuestKey ~= nil then
            local currentQuest = BountyBoardQuests[self.currentQuestKey]
            for key,value in pairs(self.targets) do
                self:InitializeEntityForQuest(value, currentQuest)
                value:SetViewDistUnlimited()
            end
        end
        self.needReload = false
    else
        if self.currentQuestKey ~= nil then
            local currentQuest = BountyBoardQuests[self.currentQuestKey]
            if currentQuest.name == "quest_bounty_duel" then
                self:HandleKillQuest()
            end
            if currentQuest.name == "quest_bounty_kill" then
                self:HandleKillQuest()
            end
            if currentQuest.name == "quest_bounty_kill_mercenaries" then
                self:HandleKillQuest()
            end
            if currentQuest.name == "quest_bounty_kill_bandits" then
                self:HandleKillQuest()
            end
        end
    end
end
