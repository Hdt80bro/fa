# /mods/CampaignBranch/ExtractMPBlueprints.lua
#
# Run this script with ExtractMPBlueprints.bat

local datadir = '../../'
local outfile = 'Unit_Properties.txt'
local current_id

local all_blueprints = {}


dofile(datadir..'lua/system/repr.lua')
dofile(datadir..'lua/system/utils.lua')

function LOC(s)
    return (string.gsub(s, '^<[^>]*>', ''))
end

#===================================================================
# Define constructors that get called from the Blueprint files
#-------------------------------------------------------------------
function Sound(t)
    return t
end

function RPCSound(t)
    return t
end

function UnitBlueprint(bp)
    bp.BlueprintId = current_id
    all_blueprints[current_id] = bp
end


#===================================================================
# Generate the partial blueprint file
#-------------------------------------------------------------------
function LoadAllBlueprints()
    for i,d in io.dir(datadir .. 'units/*.*') do
        current_id = string.lower(d)

        local filename = string.format('%sunits/%s/%s_unit.bp', datadir, d, d)
        local ok,msg = pcall(dofile, filename)
        if not ok and not string.find(msg,'cannot read.*: No such file or directory') then
            error(msg)
        end
    end
end


function dump(bp, file)
    file:write(string.format('%s - %s (%s)\n', bp.BlueprintId, LOC(bp.Description) or '', bp.General.FactionName or 'no faction'))
    file:write('  Tech level: ', string.gsub(bp.General.TechLevel or 'None', 'RULEUTL_', ''),' \n')


    if bp.Economy then
        file:write('Economy\n')
        file:write(' Build Cost Energy:  ',bp.Economy.BuildCostEnergy,' \n')
        file:write(' Build Cost Mass:  ',bp.Economy.BuildCostMass,' \n')
        file:write(' Build Rate:  ',bp.Economy.BuildRate,' \n')
        file:write(' Build Time:  ',bp.Economy.BuildTime,' \n')
        file:write(' Min Build Time:  ',bp.Economy.MinBuildTime,' \n')
        
        file:write(' Max Energy Use:  ',bp.Economy.MaxEnergyUse,' \n')
        file:write(' Max Mass Use:  ',bp.Economy.MaxMassUse,' \n')
        file:write(' Storage Energy:  ',bp.Economy.StorageEnergy,' \n')
        file:write(' Storage Mass:  ',bp.Economy.StorageMass,' \n')
        
        file:write(' Production Per Second Energy:  ',bp.Economy.ProductionPerSecondEnergy,' \n')  
        file:write(' Production Per Second Mass:  ',bp.Economy.ProductionPerSecondMass,' \n')  

        file:write(' Maintenance Consuption Per Second Energy:  ',bp.Economy.MaintenanceConsumptionPerSecondEnergy,' \n')  
        file:write(' Maintenance Consuption Per Second Mass:  ',bp.Economy.MaintenanceConsumptionPerSecondMass,' \n')     
        
        file:write(' Adjacent Structure Energy Mod:  ',bp.Economy.AdjacentStructureEnergyMod,' \n')
        file:write(' Adjacent Energy Production Mod:  ',bp.Economy.AdjacentEnergyProductionMod,' \n')
        file:write(' Adjacent Mass Production Mod:  ',bp.Economy.AdjacentMassProductionMod,' \n')
        
        file:write(' Teleport Energy Mod:  ',bp.Economy.TeleportEnergyMod,' \n')
        file:write(' Teleport Mass Mod:  ',bp.Economy.TeleportMassMod,' \n')
        file:write(' Teleport Time Mod:  ',bp.Economy.TeleportTimeMod,' \n')
    end
    

    if bp.Defense then
        file:write('Defense\n')
        file:write(' Armor Type:  ',bp.Defense.ArmorType,' \n')
        file:write(' Health:  ',bp.Defense.Health,' \n')
        file:write(' Max Health:  ',bp.Defense.MaxHealth,' \n')
        file:write(' RegenRate:  ',bp.Defense.RegenRate,' \n')
    end
    
    
    if bp.Intel then
        file:write('Intel\n')
        file:write(' Vision Radius:  ',bp.Intel.VisionRadius,' \n')
        file:write(' Radar Radius:  ',bp.Intel.RadarRadius,' \n')
        file:write(' Radar Stealth Field Radius:  ',bp.Intel.RadarStealthFieldRadius,' \n')
        file:write(' Sonar Radius:  ',bp.Intel.SonarRadius,' \n')
        file:write(' Sonar Stealth Field Radius:  ',bp.Intel.SonarStealthFieldRadius,' \n')
        file:write(' Water Vision Radius:  ',bp.Intel.WaterVisionRadius,' \n')
    end
    file:write('\n')
end


function WriteAllBlueprints()
    local n = 0
    local file = io.open(outfile, "w")
    file:write("# Generated by ExtractMPBlueprints.lua (", os.date(), " ", os.getenv "USERNAME", ")\n")

    for id,bp in sortedpairs(all_blueprints) do

        dump(bp, file)
        n = n+1
    end
    file:close()

    print('Wrote '..n..' blueprints to '..outfile)
end


LoadAllBlueprints()
WriteAllBlueprints()
