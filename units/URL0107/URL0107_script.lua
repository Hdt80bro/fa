--****************************************************************************
--**
--**  File     :  /cdimage/units/URL0107/URL0107_script.lua
--**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--**
--**  Summary  :  Cybran Heavy Infantry Script
--**
--**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFLaserHeavyWeapon = CybranWeaponsFile.CDFLaserHeavyWeapon
--local CDFRocketIridiumWeapon = CybranWeaponsFile.CDFRocketIridiumWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')


---@class URL0107 : CWalkingLandUnit
URL0107 = Class(CWalkingLandUnit) {
    Weapons = {
        LaserArms = Class(CDFLaserHeavyWeapon) {},
        --RocketBackpack = Class(CDFRocketIridiumWeapon) {},
    },

    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        self.BuildEffectBones = self:GetBlueprint().General.BuildBones.BuildEffectBones
        if self.BuildEffectBones then
            self:SetupBuildBones()
        end
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
       EffectUtil.CreateCybranBuildBeamsOpti( self, { }, unitBeingBuilt, self.BuildEffectsBag, false)
    end,
    
}

TypeClass = URL0107
