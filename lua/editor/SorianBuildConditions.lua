--****************************************************************************
--**
--**  File     :  /lua/SorianBuildConditions.lua
--**  Author(s): Michael Robbins aka Sorian
--**
--**  Summary  : Generic AI Platoon Build Conditions
--**             Build conditions always return true or false
--**
--****************************************************************************
local AIUtils = import('/lua/ai/aiutilities.lua')
local SUtils = import('/lua/AI/sorianutilities.lua')
local MABC = import('/lua/editor/MarkerBuildConditions.lua')
local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')

---@param aiBrain AIBrain
---@param bool boolean
---@return boolean
function IsBadMap(aiBrain, bool)
    if not SUtils.CheckForMapMarkers(aiBrain) and bool then
        return true
    elseif SUtils.CheckForMapMarkers(aiBrain) and not bool then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param resTable string
---@return boolean
function CategoriesNotRestricted(aiBrain, resTable)
    local restrictions = ScenarioInfo.Options.RestrictedCategories
    if not restrictions then return false end
    for _, rescheck in resTable do
        for _, restriction in restrictions do
            if rescheck == restriction then
                return false
            end
        end
    end
    return true
end

---@param aiBrain AIBrain
---@param bool boolean
---@return boolean
function IsWaterMap(aiBrain, bool)
    local startX, startZ = aiBrain:GetArmyStartPos()
    local navalMarker = AIUtils.AIGetClosestMarkerLocation(aiBrain, 'Naval Area', startX, startZ)
    if navalMarker and bool then
        return true
    elseif not navalMarker and not bool then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param bool boolean
---@return boolean
function IsIslandMap(aiBrain, bool)
    local startX, startZ = aiBrain:GetArmyStartPos()
    local enemyX, enemyZ
    if aiBrain:GetCurrentEnemy() then
        enemyX, enemyZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
    else
        enemyX, enemyZ = SUtils.GetRandomEnemyPos(aiBrain)
    end
    local navalMarker = AIUtils.AIGetClosestMarkerLocation(aiBrain, 'Island', startX, startZ)
    local path, reason = false
    if enemyX then
        path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Land', {startX,0,startZ}, {enemyX,0,enemyZ}, 10)
    end
    if (navalMarker and not path) and bool then
        return true
    elseif (not navalMarker or path) and not bool then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param aitype string
---@param bool boolean
---@return boolean
function AIType(aiBrain, aitype, bool)
    local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
    if aitype == per and bool then
        return true
    elseif aitype != per and not bool then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param markerTypes string
---@param distance number
---@param checkForBad boolean
---@return boolean
function MarkerLessThan(aiBrain, locationType, markerTypes, distance, checkForBad)
    if checkForBad and not SUtils.CheckForMapMarkers(aiBrain) then
        return true
    end
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager then
        return false
    end
    local pos = engineerManager:GetLocationCoords()
    for k,v in markerTypes do
        local marker = AIUtils.AIGetClosestMarkerLocation(aiBrain, v, pos[1], pos[3])
        if marker and VDist2Sq(marker[1], marker[3], pos[1], pos[3]) < distance * distance then
            return true
        elseif not marker then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param num integer
---@return boolean
function GreaterThanGameTime(aiBrain, num)
    local time = GetGameTimeSeconds()
    local cheatmult = tonumber(ScenarioInfo.Options.CheatMult) or 2
    local buildmult = tonumber(ScenarioInfo.Options.BuildMult) or 2
    local cheatAdjustment = (cheatmult + buildmult) / 2
    if aiBrain.CheatEnabled and (num / cheatAdjustment) < time then
        return true
    elseif num < time then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param num integer
---@return boolean
function LessThanGameTime(aiBrain, num)
    return (not GreaterThanGameTime(aiBrain, num))
end

---@param aiBrain AIBrain
---@param num integer
---@return boolean
function EnemyToAllyRatioLessOrEqual(aiBrain, num)
    local enemies = 0
    local allies = 0
    for k,v in ArmyBrains do
        if v.Result ~= "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsEnemy(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            enemies = enemies + 1
        elseif v.Result ~= "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsAlly(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            allies = allies + 1
        end
    end
    if enemies / allies <= num then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param threatValue integer
---@param threatType string
---@param rings integer
---@return boolean
function EnemyThreatLessThanValueAtBase(aiBrain, locationType, threatValue, threatType, rings)
    local testRings = rings or 10
    local FactoryManager = aiBrain.BuilderManagers[locationType].FactoryManager
    if not FactoryManager then
        return false
    end
    local position = FactoryManager:GetLocationCoords()
    if aiBrain:GetThreatAtPosition(position, testRings, true, threatType or 'Overall') < threatValue then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locType string
---@param threatValue integer
---@param threatType string
---@param rings integer
---@return boolean
function ReclaimablesInArea(aiBrain, locType, threatValue, threatType, rings)
    if aiBrain:GetEconomyStoredRatio('MASS') > .5 and aiBrain:GetEconomyStoredRatio('ENERGY') > .5 then
        return false
    end

    local testRings = rings or 0

    local ents = AIUtils.AIGetReclaimablesAroundLocation(aiBrain, locType)
    if not ents or table.empty(ents) then
        return false
    end
    for k,v in ents do
        if not aiBrain.BadReclaimables[v] and aiBrain:GetThreatAtPosition(v:GetPosition(), testRings, true, threatType or 'Overall') <= threatValue then
            return true
        end
    end

    return false
end

---@param aiBrain AIBrain
---@param distance integer
---@return boolean
function ClosestEnemyLessThan(aiBrain, distance)
    local startX, startZ = aiBrain:GetArmyStartPos()
    local closest
    for k,v in ArmyBrains do
        if v.Result ~= "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsEnemy(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            local estartX, estartZ = v:GetArmyStartPos()
            local tempDistance = VDist2Sq(startX, startZ, estartX, estartZ)
            if not closest or tempDistance < closest then
                closest = tempDistance
            end
        end
        if closest and closest < distance * distance then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param locationtype string
---@return boolean
function DamagedStructuresInArea(aiBrain, locationtype)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end
    local Structures = AIUtils.GetOwnUnitsAroundPoint(aiBrain, categories.STRUCTURE - (categories.TECH1 - categories.FACTORY), engineerManager:GetLocationCoords(), engineerManager.Radius)
    for k,v in Structures do
        if not v.Dead and v:GetHealthPercent() < .8 then
        --LOG('*AI DEBUG: DamagedStructuresInArea return true')
            return true
        end
    end
    --LOG('*AI DEBUG: DamagedStructuresInArea return false')
    return false
end

---@param aiBrain AIBrain
---@param markerType string
---@param distance integer
---@param threatMin integer
---@param threatMax integer
---@param threatRings integer
---@param threatType string
---@param startX integer
---@param startZ integer
---@return boolean
function MarkerLessThanDistance(aiBrain, markerType, distance, threatMin, threatMax, threatRings, threatType, startX, startZ)
    if not startX and not startZ then
         startX, startZ = aiBrain:GetArmyStartPos()
    end
    local loc
    if threatMin and threatMax and threatRings then
        loc = AIUtils.AIGetClosestThreatMarkerLoc(aiBrain, markerType, startX, startZ, threatMin, threatMax, threatRings, threatType)
    else
        loc = AIUtils.AIGetClosestMarkerLocation(aiBrain, markerType, startX, startZ)
    end
    if loc and loc[1] and loc[3] then
        if VDist2(startX, startZ, loc[1], loc[3]) < distance and aiBrain:CanBuildStructureAt('ueb1102', loc) then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param distance integer
---@param threatMin integer
---@param threatMax integer
---@param threatRings integer
---@param threatType string
---@param maxNum integer
---@return boolean
function CanBuildOnHydroLessThanDistance(aiBrain, locationType, distance, threatMin, threatMax, threatRings, threatType, maxNum)
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager then
        return false
    end
    local position = engineerManager:GetLocationCoords()

    local markerTable = AIUtils.AIGetSortedHydroLocations(aiBrain, maxNum, threatMin, threatMax, threatRings, threatType, position)
    if markerTable[1] and VDist3(markerTable[1], position) < distance then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param markerType string
---@param distance integer
---@param threatMin integer
---@param threatMax integer
---@param threatRings integer
---@param threatType string
---@param startX integer
---@param startZ integer
---@return boolean
function NoMarkerLessThanDistance(aiBrain, markerType, distance, threatMin, threatMax, threatRings, threatType, startX, startZ)
    return not MABC.MarkerLessThanDistance(aiBrain, markerType, distance, threatMin, threatMax, threatRings, threatType, startX, startZ)
end

---@param aiBrain AIBrain
---@param sizeX integer
---@param sizeZ integer
---@return boolean
function MapGreaterThan(aiBrain, sizeX, sizeZ)
    local mapSizeX, mapSizeZ = GetMapSize()
    if mapSizeX > sizeX or mapSizeZ > sizeZ then
        --LOG('*AI DEBUG: MapGreaterThan returned True SizeX: ' .. sizeX .. ' sizeZ: ' .. sizeZ)
        return true
    end
    --LOG('*AI DEBUG: MapGreaterThan returned False SizeX: ' .. sizeX .. ' sizeZ: ' .. sizeZ)
    return false
end

---@param aiBrain AIBrain
---@param sizeX integer
---@param sizeZ integer
---@return boolean
function MapLessThan(aiBrain, sizeX, sizeZ)
    local mapSizeX, mapSizeZ = GetMapSize()
    if mapSizeX < sizeX and mapSizeZ < sizeZ then
        --LOG('*AI DEBUG: MapLessThan returned True SizeX: ' .. sizeX .. ' sizeZ: ' .. sizeZ)
        return true
    end
    --LOG('*AI DEBUG: MapLessThan returned False SizeX: ' .. sizeX .. ' sizeZ: ' .. sizeZ)
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param ucat EntityCategory
---@param ttype string
---@param uttype string
---@param divideby integer
---@return boolean
function PoolThreatGreaterThanEnemyBase(aiBrain, locationType, ucat, ttype, uttype, divideby)
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    local divby = divideby or 1
    if not engineerManager then
        return false
    end

    if aiBrain:GetCurrentEnemy() then
        enemy = aiBrain:GetCurrentEnemy()
        enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
    else
        return false
    end
    local StartX, StartZ = enemy:GetArmyStartPos()
    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager.Radius

    local enemyThreat = aiBrain:GetThreatAtPosition({StartX, 0, StartZ}, 1, true, ttype or 'Overall', enemyIndex)
    local Threat = pool:GetPlatoonThreat(uttype or 'Overall', ucat, position, radius)
    if SUtils.Round((Threat / divby), 1) > enemyThreat then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param ttype string
---@param number integer
---@return boolean
function LessThanThreatAtEnemyBase(aiBrain, ttype, number)
    if aiBrain:GetCurrentEnemy() then
        enemy = aiBrain:GetCurrentEnemy()
        enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
    else
        return false
    end

    local StartX, StartZ = enemy:GetArmyStartPos()

    local enemyThreat = aiBrain:GetThreatAtPosition({StartX, 0, StartZ}, 1, true, ttype or 'Overall', enemyIndex)
    if number < enemyThreat then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param ttype string
---@param number integer
---@return boolean
function GreaterThanThreatAtEnemyBase(aiBrain, ttype, number)
    return not LessThanThreatAtEnemyBase(aiBrain, ttype, number)
end

---@param aiBrain AIBrain
---@param locationtype string
---@param numUnits integer
---@param unitCat EntityCategory
---@param radius integer
---@return boolean
function GreaterThanEnemyUnitsAroundBase(aiBrain, locationtype, numUnits, unitCat, radius)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end
    if type(unitCat) == 'string' then
        unitCat = ParseEntityCategory(unitCat)
    end
    local Units = aiBrain:GetNumUnitsAroundPoint(unitCat, engineerManager:GetLocationCoords(), radius, 'Enemy')
    if Units > numUnits then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param category EntityCategory
---@return boolean
function UnfinishedUnits(aiBrain, locationType, category)
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager then
        return false
    end
    local unfinished = aiBrain:GetUnitsAroundPoint(category, engineerManager:GetLocationCoords(), engineerManager.Radius, 'Ally')
    for num, unit in unfinished do
        donePercent = unit:GetFractionComplete()
        if donePercent < 1 and SUtils.GetGuards(aiBrain, unit) < 1 then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@return boolean
function ShieldDamaged(aiBrain, locationType)
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager then
        return false
    end
    local shields = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.SHIELD, engineerManager:GetLocationCoords(), engineerManager.Radius, 'Ally')
    for num, unit in shields do
        if not unit.Dead and unit:ShieldIsOn() then
            shieldPercent = (unit.MyShield:GetHealth() / unit.MyShield:GetMaxHealth())
            if shieldPercent < 1 and SUtils.GetGuards(aiBrain, unit) < 3 then
                return true
            end
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param timeLeft number
---@return boolean
function NoRushTimeCheck(aiBrain, timeLeft)
    if ScenarioInfo.Options.NoRushOption and ScenarioInfo.Options.NoRushOption != 'Off' then
        if tonumber(ScenarioInfo.Options.NoRushOption) * 60 < GetGameTimeSeconds() + timeLeft then
            return true
        else
            return false
        end
    elseif ScenarioInfo.Options.NoRushOption and ScenarioInfo.Options.NoRushOption == 'Off' then
        return true
    end
    return true
end

---@param aiBrain AIBrain
---@return boolean
function NoRush(aiBrain)
    if ScenarioInfo.Options.NoRushOption and ScenarioInfo.Options.NoRushOption != 'Off' then
        if tonumber(ScenarioInfo.Options.NoRushOption) * 60 > GetGameTimeSeconds() then
            return true
        else
            return false
        end
    elseif ScenarioInfo.Options.NoRushOption and ScenarioInfo.Options.NoRushOption == 'Off' then
        return false
    end
    return false
end

---@param aiBrain AIBrain
---@param greater integer
---@param myCategory string
---@param eCategory string
---@param alliance string
---@return boolean
function HaveComparativeUnitsWithCategoryAndAlliance(aiBrain, greater, myCategory, eCategory, alliance)
    if type(eCategory) == 'string' then
        eCategory = ParseEntityCategory(eCategory)
    end
    if type(myCategory) == 'string' then
        myCategory = ParseEntityCategory(myCategory)
    end
    local myUnits = aiBrain:GetCurrentUnits(myCategory)
    local numUnits = aiBrain:GetNumUnitsAroundPoint(eCategory, Vector(0,0,0), 100000, alliance)
    if alliance == 'Ally' then
        numUnits = numUnits - aiBrain:GetCurrentUnits(myCategory)
    end
    if numUnits > myUnits and greater then
        return true
    elseif numUnits < myUnits and not greater then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param less integer
---@param ratio number
---@param myCategory string
---@param eCategory string
---@param alliance string
---@return boolean
function HaveRatioUnitsWithCategoryAndAlliance(aiBrain, less, ratio, myCategory, eCategory, alliance)
    if type(eCategory) == 'string' then
        eCategory = ParseEntityCategory(eCategory)
    end
    if type(myCategory) == 'string' then
        myCategory = ParseEntityCategory(myCategory)
    end
    local myUnits = aiBrain:GetCurrentUnits(myCategory)
    local numUnits = aiBrain:GetNumUnitsAroundPoint(eCategory, Vector(0,0,0), 100000, alliance)
    if alliance == 'Ally' then
        numUnits = numUnits - aiBrain:GetCurrentUnits(myCategory)
    end
    if numUnits / myUnits <= ratio and less then
        return true
    elseif numUnits / myUnits >= ratio and not less then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locationtype string
---@param greater integer
---@param myCategory string
---@param eCategory string
---@param alliance string
---@return boolean
function HaveComparativeUnitsWithCategoryAndAllianceAtLocation(aiBrain, locationtype, greater, myCategory, eCategory, alliance)
    if type(eCategory) == 'string' then
        eCategory = ParseEntityCategory(eCategory)
    end
    if type(myCategory) == 'string' then
        myCategory = ParseEntityCategory(myCategory)
    end
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end
    local myUnits = table.getn(AIUtils.GetOwnUnitsAroundPoint(aiBrain, myCategory, engineerManager:GetLocationCoords(), engineerManager.Radius))
    local numUnits = aiBrain:GetNumUnitsAroundPoint(eCategory, Vector(0,0,0), 100000, alliance)
    if alliance == 'Ally' then
        numUnits = numUnits - aiBrain:GetCurrentUnits(myCategory)
    end
    if numUnits > myUnits and greater then
        return true
    elseif numUnits < myUnits and not greater then
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param upgrade string
---@param has boolean
---@return boolean
function CmdrHasUpgrade(aiBrain, upgrade, has)
    local units = aiBrain:GetListOfUnits(categories.COMMAND, false)
    for k,v in units do
        if v:HasEnhancement(upgrade) and has then
            return true
        elseif not v:HasEnhancement(upgrade) and not has then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param upgrade string
---@return boolean
function SCUNeedsUpgrade(aiBrain, upgrade)
    local units = aiBrain:GetListOfUnits(categories.SUBCOMMANDER, false)
    local needsUpgrade = false
    for k,v in units do
        if v:IsUnitState('Upgrading') then
            return false
        end
        if not v:HasEnhancement(upgrade) then
            needsUpgrade = true
        end
    end
    return needsUpgrade
end

---@param aiBrain AIBrain
---@param t4types string
---@param t4cats EntityCategory
---@return boolean
function T4ThreatExists(aiBrain, t4types, t4cats)
    for k,v in t4types do
        if aiBrain.T4ThreatFound[v] then
            return true
        end
    end
    if type(t4cats) == 'string' then
        t4cats = ParseEntityCategory(t4cats)
    end
    if aiBrain:GetNumUnitsAroundPoint(categories.EXPERIMENTAL * t4cats, Vector(0,0,0), 100000, 'Enemy') > 0 then
        for k,v in t4types do
            aiBrain.T4ThreatFound[v] = true
        end
        aiBrain:ForkThread(aiBrain.T4ThreatMonitorTimeout, t4types)
        return true
    end
    return false
end

---@param aiBrain AIBrain
---@param locationType string
---@param radius integer
---@param markerType string
---@param tMin integer
---@param tMax integer
---@param tRings integer
---@param tType string
---@param maxUnits integer
---@param unitCat EntityCategory
---@param markerRadius integer
---@return boolean
function CanBuildFirebase(aiBrain, locationType, radius, markerType, tMin, tMax, tRings, tType, maxUnits, unitCat, markerRadius)
    local ref, refName = AIUtils.AIFindFirebaseLocationSorian(aiBrain, locationType, radius, markerType, tMin, tMax, tRings, tType, maxUnits, unitCat, markerRadius)
    if not ref then
        return false
    end
    return true
end

---@param aiBrain AIBrain
---@param numReq integer
---@param category EntityCategory
---@return boolean
function TargetHasLessThanUnitsWithCategory(aiBrain, numReq, category)
    local testCat = category
    local enemyBrain = aiBrain:GetCurrentEnemy()
    local count = 0
    if not enemyBrain then
        return false
    end
    local enemyIndex = enemyBrain:GetArmyIndex()
    if type(category) == 'string' then
        testCat = ParseEntityCategory(category)
    end
    local eUnits = aiBrain:GetUnitsAroundPoint(testCat, Vector(0,0,0), 100000, 'Enemy')
    for k,v in eUnits do
        if v:GetAIBrain():GetArmyIndex() == enemyIndex then
            count = count + 1
        end
        if count > numReq then
            return false
        end
    end
    return true
end

---@param aiBrain AIBrain
---@param numReq integer
---@param category EntityCategory
---@return boolean
function TargetHasGreaterThanUnitsWithCategory(aiBrain, numReq, category)
    local testCat = category
    local enemyBrain = aiBrain:GetCurrentEnemy()
    local count = 0
    if not enemyBrain then
        return false
    end
    local enemyIndex = enemyBrain:GetArmyIndex()
    if type(category) == 'string' then
        testCat = ParseEntityCategory(category)
    end
    local eUnits = aiBrain:GetUnitsAroundPoint(testCat, Vector(0,0,0), 100000, 'Enemy')
    for k,v in eUnits do
        if v:GetAIBrain():GetArmyIndex() == enemyIndex then
            count = count + 1
        end
        if count > numReq then
            return true
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param locationtype string
---@param inrange boolean
---@return boolean
function EnemyInT3ArtilleryRange(aiBrain, locationtype, inrange)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end

    local start = engineerManager:GetLocationCoords()
    local factionIndex = aiBrain:GetFactionIndex()
    local radius = 0
    local offset = 0
    if factionIndex == 1 then
        radius = 825 + offset
    elseif factionIndex == 2 then
        radius = 825 + offset
    elseif factionIndex == 3 then
        radius = 825 + offset
    elseif factionIndex == 4 then
        radius = 825 + offset
    end
    for k,v in ArmyBrains do
        if v.Result ~= "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsEnemy(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            local estartX, estartZ = v:GetArmyStartPos()
            if (VDist2Sq(start[1], start[3], estartX, estartZ) <= radius * radius) and inrange then
                return true
            elseif (VDist2Sq(start[1], start[3], estartX, estartZ) > radius * radius) and not inrange then
                return true
            end
        end
    end
    return false
end

---@param aiBrain AIBrain
---@param bool boolean
---@return boolean
function AIOutnumbered(aiBrain, bool)
    local cheatmult = tonumber(ScenarioInfo.Options.CheatMult) or 2
    local buildmult = tonumber(ScenarioInfo.Options.BuildMult) or 2
    local cheatAdjustment = (cheatmult + buildmult) * .75
    local myTeam = ScenarioInfo.ArmySetup[aiBrain.Name].Team
    --LOG('*AI DEBUG: '..aiBrain.Nickname..' I am on team '..myTeam)
    local largestEnemyTeam = false
    local teams = {0,0,0,0,0,0,0,0}

    if aiBrain.CheatEnabled then
        teams[myTeam] = teams[myTeam] + (1 * cheatAdjustment)
    else
        teams[myTeam] = teams[myTeam] + 1
    end

    for k,v in ArmyBrains do
        if v.Result ~= "defeat" and aiBrain:GetArmyIndex() ~= v:GetArmyIndex() and not ArmyIsCivilian(v:GetArmyIndex()) then
            local armyTeam = ScenarioInfo.ArmySetup[v.Name].Team
            --LOG('*AI DEBUG: '..v.Nickname..' is on team '..armyTeam)
            if v.CheatEnabled then
                teams[armyTeam] = teams[armyTeam] + (1 * cheatAdjustment)
            else
                teams[armyTeam] = teams[armyTeam] + 1
            end
        end
    end
    for x,z in teams do
        if z ~= myTeam and not largestEnemyTeam or z > largestEnemyTeam then
            largestEnemyTeam = z
        end
    end

    --LOG('*AI DEBUG: '..v.Nickname..' Larget enemy team is '..z..' strength')

    if largestEnemyTeam == 0 then
        return false
    elseif largestEnemyTeam > teams[myTeam] and bool then
        return true
    elseif largestEnemyTeam < teams[myTeam] and not bool then
        return true
    end
    return false
end


-- Moved Unused Imports to bottom for mod support
local ScenarioFramework = import('/lua/scenarioframework.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local Utils = import('/lua/utilities.lua')