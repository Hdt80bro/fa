---@meta

--- these rest are not hardcoded into the engine

---@alias UnitClassification
---| "RULEUC_Commander"
---| "RULEUC_CounterMeasure"
---| "RULEUC_Engineer"
---| "RULEUC_Factory"
---| "RULEUC_MilitaryAircraft"
---| "RULEUC_MilitaryShip"
---| "RULEUC_MilitarySub"
---| "RULEUC_MilitaryVehicle"
---| "RULEUC_MiscSupport"
---| "RULEUC_Resource"
---| "RULEUC_Sensor"
---| "RULEUC_Weapon"

---@alias UnitTechLevel
---| "RULEUTL_Basic"
---| "RULEUTL_Advanced"
---| "RULEUTL_Secret"
---| "RULEUTL_Experimental"
-- never implemented
---| "RULEUTL_Munition"

--- read more here: https://wiki.faforever.com/en/Blueprints
---@class UnitBlueprint: EntityBlueprint
---@field AI UnitBlueprintAI
---@field Air UnitBlueprintAir
---@field Adjacency UnitBlueprintAdjacency|string
---@field Audio UnitBlueprintAudio
---@field Buffs BlueprintBuff[]
---@field BuildIconSortPriority integer   set to an integer that describes the unit's position in the list of build icons.
---@field Defense UnitBlueprintDefense    Defense information for the unit.
---@field Description string              description of the unit. For example the description for the UEF tech 1 Tank MA12 Striker is '<LOC uel0201_desc>Medium Tank'. <LOC xxx_desc> is used for localisation which is defined in the strings_db.lua (in the file loc_XX.scd in the subdirectory \loc\XX; XX is the shortcut for the localised language). If the localisation part is not set, the description in tags will be used for any language, which would be "Medium Tank" for this example.
---@field Display UnitBlueprintDisplay
---@field Economy UnitBlueprintEconomy
---@field Enhancements UnitBlueprintEnhancements
---@field General UnitBlueprintGeneral
---@field Intel UnitBlueprintIntel
---@field Interface UnitBlueprintInterface
---@field Physics UnitBlueprintPhysics
---@field Transport UnitBlueprintTransport
---@field Veteran UnitBlueprintVeterancy
---@field Weapon WeaponBlueprint[]
---@field Wreckage UnitBlueprintWreckage

---@class UnitBlueprintAI
---@field AttackAngle number            Under what angle the unit attacks its target after getting an attack order
---@field AutoSurfaceToAttack boolean   Automatically surface to attack ground targets.
---@field BeaconName string             This is the beacon that this unit will create under some circumstances.
---@field GuardFormationName string     The formation name used for guarding this unit. Known formations: 'GuardFormation'
---@field GuardRadius number            How far a unit on patrol will look off it's patrol path to go attack.
---@field GuardReturnRadius number      Maximum range from the guarded unit before initiating return.
---@field GuardScanRadius number        Guard range for the unit.
---@field InitialAutoMode boolean       Initial auto mode behaviour for the unit.
---@field NeedUnpack boolean            Unit should unpack before firing weapon.
---@field RefuelingMultiplier number    This muliplier is applied when a staging platform is refueling an air unit.
---@field RefuelingRepairAmount number  This amount of repair per second offered to refueling air units.
---@field TargetBones string[]          Some target bones setup for other units to aim at instead of the default center pos.

---@class UnitBlueprintAir
---@field AutoLandTime number Timer to automatically initiate landing on ground if idle.
---@field BankFactor number   How much aircraft banks in turns; negative to lean out.
---@field BankForward boolean True if aircraft banks forward/back as well as sideways.
---@field BombDropThreshold number  Distance from the target unit will start firing bombs.
---@field BreakOffDistance number   Distance to break off before turning around for another attack run.
---@field BreakOffTrigger number    Distance to target to trigger the breaking off attack.
---@field CanFly boolean    Is the unit capable of flight?
---@field CirclingDirChange boolean     Whether unit should ever change flight direction while circling.
---@field CirclingDirChangeFrequencySec number  How often will it change direction when it's attack motion is back and forth like a gunship.
---@field CirclingElevationChangeRatio number   Elevation change ratio of unit when circling.
---@field CirclingFlightChangeFrequency number  Frequency of flight pattern change for unit.
---@field CirclingRadiusChangeMaxRatio number   Max circling radius ratio for unit.
---@field CirclingRadiusChangeMinRatio number   Min circling radius ratio for unit.
---@field CirclingRadiusVsAirMult number  Multiplier to the circling radius when targeting another air unit.
---@field CirclingTurnMult number     Adjust turning ability when in circling mode.
---@field CombatTurnSpeed number      Maximum combat turn speed of the unit for special maneuvers.
---@field EngageDistance number       Distance to being engaging enemy target in attack task.
---@field FlyInWater boolean          Can this unit fly under water?
---@field HoverOverAttack boolean     Whether unit should hover over the target directly to attack. (Used for cases like the CZAR)
---@field KLift number            Controller proportional parameter for vertical motion.
---@field KLiftDamping number     Controller damping parameter for vertical motion
---@field KMove number            Controller proportional parameter for horizontal motion.
---@field KMoveDamping number     Controller damping parameter for horizontal motion.
---@field KRoll number            Controller proportional parameter for roll changes.
---@field KRollDamping number     Controller damping parameter for roll changes.
---@field KTurn number            Controller proportional parameter for heading changes.
---@field KTurnDamping number     Controller damping parameter for heading changes.
---@field LiftFactor number       How much altitude the unit can gain/loose per second.
---@field MaxAirspeed number      Maximum airspeed.
---@field MaxEngineThrust number  Max thrust for the engine. Directly influences speed and acceleration.
---@field MaxEngineTorque number
---@field MinAirspeed number      Minimum combat airspeed
---@field NeedToComputeBombDrop boolean
---@field PredictAheadForBombDrop number
---@field RandomBreakOffDistanceMult number      Random multiplier applied to break off distance for winged aircrafts.
---@field RandomMaxChangeCombatStateTime number  Random max time to switch combat state in seconds for winged aircrafts.
---@field RandomMinChangeCombatStateTime number  Random min time to switch combat state in seconds for winged aircrafts.
---@field StartTurnDistance number     Distance from target at which to start turning to align with it.
---@field TightTurnMultiplier number   Additional turning multiplier ability during a tight turn maneuver.
---@field TransportHoverHeight number  This transport will stay at this height when picking up and dropping off units.
---@field TurnSpeed number   Regular turn speed of the unit.
---@field Winged boolean     Does the unit use wings for forward flight?

---@class UnitBlueprintAdjacency
---@field EnergyBuildBonus UnitBlueprintAdjacencyBonus[]        Energy consumption reduction bestowed by energy production facilities.
---@field EnergyMaintenanceBonus UnitBlueprintAdjacencyBonus[]  Energy consumption (for maintenance i.e. shields intel etc.?) reduction bestowed by energy production facilities.
---@field EnergyProductionBonus UnitBlueprintAdjacencyBonus[]   Energy production increase bestowed by energy storage facilities.
---@field EnergyWeaponBonus UnitBlueprintAdjacencyBonus[]       Energy consumption (for weapons esp artilleries) reduction bestowed by energy production facilities.
---@field MassBuildBonus UnitBlueprintAdjacencyBonus[]          Mass consumption reduction bestowed by mass production facilities.
---@field MassProductionBonus UnitBlueprintAdjacencyBonus[]     Mass production increase bestowed by mass storage facilities.

---@class UnitBlueprintAdjacencyBonus
---@field Category UnparsedCategory | CategoryName
---@field Modifier number

---@class UnitBlueprintAudio
---@field Activate SoundHandle
---@field ActiveLoop SoundHandle
---@field AirUnitWaterImpact SoundHandle
---@field AmbientMove SoundHandle
---@field AmbientMoveLand SoundHandle
---@field AmbientMoveWater SoundHandle
---@field BarrelLoop SoundHandle
---@field BarrelStart SoundHandle
---@field BarrelStop SoundHandle
---@field BeamLoop SoundHandle
---@field BeamStart SoundHandle
---@field BeamStop SoundHandle
---@field CaptureLoop SoundHandle
---@field ChargeStart SoundHandle
---@field Close SoundHandle
---@field CommanderArrival SoundHandle
---@field Construct SoundHandle
---@field ConstructLoop SoundHandle
---@field ConstructStart SoundHandle
---@field ConstructStop SoundHandle
---@field DeathExplosion SoundHandle
---@field Destroyed SoundHandle
---@field DoneBeingBuilt SoundHandle
---@field EnhanceEnd SoundHandle
---@field EnhanceFail SoundHandle
---@field EnhanceLoop SoundHandle
---@field EnhanceStart SoundHandle
---@field EnterWater SoundHandle
---@field Fire SoundHandle
---@field FireUnderWater SoundHandle
---@field FootFallGeneric SoundHandle
---@field FootFallGenericSeabed SoundHandle
---@field HoverKilledOnWater SoundHandle
---@field Killed SoundHandle
---@field Landed SoundHandle
---@field Landing SoundHandle
---@field Load SoundHandle
---@field MoveSharpTurn SoundHandle
---@field MuzzleChargeStart SoundHandle
---@field NuclearLaunchDetectedAeon SoundHandle
---@field NuclearLaunchDetectedCybran SoundHandle
---@field NuclearLaunchDetectedUEF SoundHandle
---@field NuclearMissileInterceptedAeon SoundHandle
---@field NuclearMissileInterceptedCybran SoundHandle
---@field NuclearMissileInterceptedUEF SoundHandle
---@field Open SoundHandle
---@field Pack SoundHandle
---@field ReclaimLoop SoundHandle
---@field Refueling SoundHandle
---@field ShieldOff SoundHandle
---@field ShieldOn SoundHandle
---@field StartCapture SoundHandle
---@field StartMove SoundHandle
---@field StartMoveAir SoundHandle
---@field StartMoveLand SoundHandle
---@field StartMoveWater SoundHandle
---@field StartReclaim SoundHandle
---@field StopMove SoundHandle
---@field StopMoveLand SoundHandle
---@field StopMoveWater SoundHandle
---@field SubmergeStart SoundHandle
---@field SurfaceStart SoundHandle
---@field TakeOff SoundHandle
---@field Thruster SoundHandle
---@field TransitionLand SoundHandle
---@field TransitionWater SoundHandle
---@field UISelection SoundHandle
---@field Unload SoundHandle
---@field Unpack SoundHandle

---@class UnitBlueprintDefense
---@field ArmorType ArmorType                The armor type name.
---@field Health number                      Starting health value for the unit.
---@field MaxHealth number                   Max health value for the unit. (It just could get higher through veteran buff or an enhancement)
---@field RegenRate number                   Amount of health to regenerate per second.
---@field Shield UnitBlueprintDefenseShield  When a unit has a shield here are settings defined; Shield attributes are:
---@field ThreatLevel number                 Amount of threat this poses to the enemy.

---@class UnitBlueprintDefenseShield
---@field OwnerShieldMesh string                Define the PersonalShield_mesh when PersonalShield = true
---@field PassOverkillDamage boolean
---@field PersonalShield boolean                Define a personal shield.
---@field ShieldEnergyDrainRechargeTime number  The amount of time the shield takes to come back online when its disabled due to insufficient energy
---@field ShieldMaxHealth number                The max health of the shield.
---@field ShieldRechargeTime number             The time it takes for the shield to come back online when powered down
---@field ShieldRegenRate number                The amount of health the shield regenerates per second when it's not taking damage
---@field ShieldRegenStartTime number           The delay after getting hit by ordinance the shield starts recharging
---@field ShieldSize number                     The radius of the shield.
---@field ShieldVerticalOffset number           How many supcom units the shield is moved up (or down if negative) from normal
---@field StartsOff boolean                     Appears to do nothing but seems to be meant to make the shield turned off by default
---@field StartOn boolean

---@class UnitBlueprintDisplay
---@field Abilities string[]        Shows the abilities of the unit. Multiple abilities could be added like 'string1', 'string2', etc.
---@field AINames string[]          Names that the AI can use to name the unit, provided the AI is programmed to do this.
---@field AnimationActivate string  The animation that is played when the unit is completed (seen in experimentals, e.g. Megalith - XRL0403)
---@field AnimationBuild string     Animation that is played when the unit is building
---@field AnimationDeath UnitBlueprintAnimationDeath[]  Multiple animations could be added
---@field AnimationOpen string      Animation open file is linked here: '/units/UnitID/UnitID_aopen.sca'
---@field AnimationPermOpen any     The animation that is played when the unit is done building
---@field AnimationSurface any      The animation that is played when the unit surfaces.
---@field AnimationUpgrade string   The animation that is played when the unit is upgraded
---@field AnimationWalk string      Animation walk file is linked here: '/units/UnitID/UnitID_??.sca'
---@field AnimationWalkRate number  Controls the speed of the animation. Adjusting this number can cause or prevent "skating".
---@field BlinkingLights any
---@field BlinkingLightsFx any
---@field BuildAttachBone any
---@field DamageEffects any
---@field ForcedBuildSpin any
---@field IdleEffects table<Layer, UnitBlueprintEffects>         Effects displayed when the unit is idle (e.g. glow beneath hovering units), multiple layers can be used. The key should be the name of the layer where effects should be displayed.
---@field LayerChangeEffects table<Layer, UnitBlueprintEffects>  Effects displayed when the unit changes layers (e.g. when an aircraft lands or takes off). Defines for what transition the effects are created. 'string' is composed of 2 names of layers, first one is the old layer and the second is the new one. E.g.effects are needed for an aircraft landing, so the old layer is Air and the new one is Land, then the 'string' will be AirLand (LandAir would be the opposite - take off). Note: there is NO space between layer names.
---@field Mesh MeshBlueprint
---@field MeshBlueprint string
---@field MotionChangeEffects table<Layer, UnitBlueprintEffects>
---@field MovementEffects table<Layer, UnitBlueprintMovementEffects>   Effects displayed during movement of the unit. Key should be Name of the layer for which the effects are displayed.
---@field PlaceholderMeshName string
---@field SpawnRandomRotation boolean
---@field Tarmacs any
---@field UniformScale number     This is the scale of the unit size. This will only change the visual size, when changing this the collision hitbox should be adapted under SizeX, SizeY and SizeZ as well.

---@class UnitBlueprintAnimationDeath
---@field Animation string         animation death file is linked here: '/units/UnitID/UnitID_??.sca'
---@field AnimationRateMax number  the maximum speed this animation is played at
---@field AnimationRateMin number  the minimum speed this animation is played at
---@field Weight number            This number affects how often a death animation is used when there are more than one. This value is relative rather than absolute.

---@class UnitBlueprintEffects
---@field Effects UnitBlueprintEffect[]

---@class UnitBlueprintEffect
---@field Bones string[]  Names of bones to which the effect will be attached.
---@field Offset Vector   Controls position of the effect relatively to the bone it's attached to. n1, n2 and n3 are respectively x, y and z coordinates (0, 0, 0 by default).
---@field Scale number    Controls scale of the effect (1 by default).
---@field Type string     Defines what effect will be used.

---@class UnitBlueprintMovementEffects : UnitBlueprintEffects
---@field Contrails { Bones: string[] }  Contrails shown behind aircraft (in SupCom usually behind tips of wings). Bones are Names of the bones which will have the contrails attached.
---@field Treads UnitBlueprintTreads     For units with treads or wheels, e.g. tanks, UEF engineers.

---@class UnitBlueprintTreads
---@field ScrollTreads boolean     Should the treads be scrolled when unit is moving?
---@field TreadMarks UnitBlueprintTreadMarks

---@class UnitBlueprintTreadMarks
---@field BoneName string            Name of the bone to which the tread marks will be attached.
---@field TreadMarks string          Name of the tread marks to be used (e.g. light tank might have different than a heavier one).
---@field TreadMarksInterval number  Defines how often should they be created on the ground.
---@field TreadMarksSizeX number     Defines how big/stretched should the tread marks be on the X axis.
---@field TreadMarksSizeZ number     Defines how big/stretched should the tread marks be on the Z axis.
---@field TreadOffset Vector         Defines the offset of tread marks to bone defined in BoneName. 'n1', 'n2', 'n3' are respectively x, y and z coordinates.

---@class UnitBlueprintEconomy
---@field AdjacentEnergyProductionMod number
---@field AdjacentMassProductionMod number
---@field AdjacentStructureEnergyMod number
---@field BuildableCategory CategoryName[]  This define what units could be produced.
---@field BuildCostEnergy number            Energy cost to build this unit.
---@field BuildCostMass number              Mass cost to build this unit.
---@field BuildRate number                  How fast this unit build other units.
---@field BuildTime number                  The needed time when producing this unit; This is only a factor of time, not the real time to produce the unit.
---@field InitialRallyX number              Default rally point X for the factory.
---@field InitialRallyZ number              Default rally point Z for the factory.
---@field MaintenanceConsumptionPerSecondEnergy number  Amount that define which amount of energy the unit is consuming per second; Used for Shields.
---@field MaxBuildDistance number           Maximum build range of the unit. The target must be within this range before the builder can perform operation.
---@field MaxEnergyUse number               The maximum Amount of Energy the Unit can produce (see PARAGON xab1401)
---@field MaxMassUse number                 The maximum Amount of Mass the Unit can produce (see PARAGON xab1401)
---@field MinBuildTime number
---@field NaturalProducer boolean           Produces resource naturally and does not consume anything.
---@field NeedToFaceTargetToBuild boolean   Builder needs to face target before it can build/repair.
---@field ProductionPerSecondEnergy number  Amount of energy produced per second.
---@field ProductionPerSecondMass number    Amount of mass produced per second.
---@field RebuildBonusIds string[]          You will get bonus if you rebuild this unit over the wreckage of these wreckages. Multible BonusID's could be added.
---@field SacrificeMassMult number          Builder will kill self but provide this amount of health to the unit it is helping.
---@field SacrificeEnergyMult number        Builder will kill self but provide this amount of health to the unit it is helping.
---@field StorageEnergy number              Energy storage capacity provided by this unit; This gets added to the main resource pool and is not stored in the unit itself.
---@field StorageMass number                Mass storage capacity provided by this unit; This gets added to the main resource pool and is not stored in the unit itself.
---@field TeleportEnergyMod number          Multiply by the unit's energy cost to get the energy per tick cost of teleporting.
---@field TeleportMassMod number            Multiply by the unit's mass cost to get the mass per tick cost of teleporting.
---@field TeleportTimeMod number            Multiply by the unit's build time to get the time required to teleport.

---@class UnitBlueprintEnhancements

---@class UnitBlueprintGeneral
---@field CapCost number               Cost of the unit towards unit cap (default is 1.0)
---@field Category string
---@field Classification UnitClassification
---@field CommandCaps table<CommandCap, boolean>  Command capability flags for this unit;
---@field FactionName string           Faction the unit belongs to. Factions are 'Aeon', 'Cybran' and 'UEF'.
---@field QuickSelectPriority integer  Indicates unit has it's own avatar button in the quick select interface, and it's sorting priority.
---@field TarmacDecal any
---@field TarmacGlowDecal any
---@field TechLevel UnitTechLevel      This define the tech level. 'RULEUTL_Basic' for tech 1, 'RULEUTL_Advanced' for tech 2, 'RULEUTL_Secret' for tech 3 and 'RULEUTL_Experimental' for experimental.
---@field UnitName string              The name of the unit.
---@field UnitWeight number
---@field UpgradesFrom string          What unit, if any, was this unit upgrade from.
---@field UpgradesTo string            What unit, if any, does this unit upgrade to.

---@class UnitBlueprintIntel
---@field Cloak boolean                   Single unit cloaking.
---@field CloakFieldRadius number         How far our cloaking goes.
---@field FreeIntel boolean               The intel is free. Without this the unit will try drain energy for it's intelligence (radar, sonar, etc) and turn off if you run out.
---@field JamRadius {Max: number, Min: number}  How far we create fake blips.
---@field JammerBlips number              How many blips does a jammer produce
---@field OmniRadius number               How far our omni coverage goes.
---@field RadarRadius number              How far our radar coverage goes.
---@field RadarStealth boolean            Single unit radar stealth.
---@field RadarStealthFieldRadius number  How far our radar stealth goes.
---@field ReactivateTime number           When you run out of power, how long until this unit turns back on.
---@field ShowIntelOnSelect boolean       Show intel radius of unit if selected.
---@field SonarRadius number              How far radar coverage goes.
---@field SonarStealth boolean            Single unit sonar stealth.
---@field SonarStealthFieldRadius number  How far our sonar stealth goes.
---@field SpoofRadius {Max: number, Min: number}  How far off displace blip.
---@field VisionRadius number             How far we can see above water (and land?).
---@field WaterVisionRadius number        How far we can see underwater.

---@class UnitBlueprintInterface
---@field HelpText string

---@class UnitBlueprintPhysics
---@field AttackElevation number    Preferred attack height when attacking ground targets. (used by dive bombers)>
---@field BackUpDistance number     Distance that the unit will just back up if it is easier to do so.
---@field BankingSlope number       How much the unit banks in corners (negative to lean outwards).
---@field BuildOnLayerCaps table<LayerEnum, boolean>  Unit may be built on these layers (only applies to structures); Subcategories are:
---@field BuildRestriction UnitBuildRestriction       Special build restrictions (mass deposit, thermal vent, etc).
---@field CatchUpAcc number         Acceleration to allow unit to catch up to the target when it starts to drift.
---@field DragCoefficient number
---@field Elevation number          Prefferred height above (-below) land or water surface.
---@field FlattenSkirt boolean      If true, terrain under building's skirt will be flattened.
---@field FuelRechargeRate number   Unit fuels up at this rate per second.
---@field FuelUseTime number        Unit has fuel for this number of seconds.
---@field LayerChangeOffsetHeight number An offset to the layer change height used during the transition between seabed/water and land.
---@field LayerTransitionDuration number Transition time in seconds when going from water/land and land/water.
---@field MaxAcceleration number     Maximum acceleration for the unit.
---@field MaxBrake number            Maximum braking acceleration for the unit.
---@field MaxGroundVariation number  Maximum elevation difference across skirt for build site.
---@field MaxSpeed number            Maximum speed for the unit.
---@field MaxSpeedReverse number     Maximum speed for the unit in reverse.
---@field MaxSteerForce number       Maximum steer force magnitude that can be applied to acceleration.
---@field MeshExtentsX number
---@field MeshExtentsY number
---@field MeshExtentsZ number
---@field MinSpeedPercent number
---@field MotionType UnitMotionType  Method of locomotion.
---@field OccupyRects string         Set up the occupy rectangles of the unit that will override the footprint.
---@field RaisedPlatforms table<number> Raised platform definition for ground units to move on.
---@field RollDamping number         How much damping there is against rolling motion (1 = no motion at all).
---@field RollStability number       How stable the unit is against rolling (0 to 1).
---@field RollOffPoints UnitRollOffPoint[]
---@field RotateBodyWhileMoving boolean  Ability to rotate body to aim weapon slaved to body while in still in motion.
---@field RotateOnSpot boolean       This unit can tries to rotate on the spot.
---@field SkirtOffsetX number        Offset of left edge of skirt from left edge of footprint. (Should be     = 0)
---@field SkirtOffsetZ number        Offset of top edge of skirt from left edge of footprint. (Should be     = 0)
---@field SkirtSizeX number          Unit construction pad Size X for building.
---@field SkirtSizeZ number          Unit construction pad Size Z for building.
---@field StandUpright boolean       Stands upright regardless of terrain,
---@field TurnFacingRate number      Turn facing damping for the unit, usually used for hover units only.
---@field TurnRadius number          Turn radius for the unit, in wolrd units.
---@field TurnRate number            Turn radius for the unit, in degrees per second.
---@field WobbleFactor number        How much wobbling for the unit while hovering.
---@field WobbleSpeed number         How fast is the wobble, The faster the less stable looking.

---@class UnitRollOffPoint
---@field UnitSpin integer
---@field X number
---@field Y number
---@field Z number

---@class UnitBlueprintTransport
---@field AirClass boolean              These define that the unit can only land on air staging platforms.
---@field CanFireFromTransport boolean  Define if the unit can fire out of a transport.
---@field Class2AttachSize integer      Number of class 1 attach points this affects.
---@field Class3AttachSize integer      Number of class 1 attach points this affects.
---@field Class4AttachSize integer      Number of class 1 attach points this affects.
---@field ClassGenericUpTo integer      Generic slots up to the specified class.
---@field ClassSAttachSize integer      Number of class 1 attach points this affects.
---@field RepairRate number             Repairs units attached to me at this % of max health per second.
---@field StorageSlots integer          How many internal storage slots avaible for the transport on top of attach points.
---@field TransportClass integer        Type of attach points required on transports.

---@class UnitBlueprintVeterancy
---@field Level1 integer  Define how much kills are required for reaching veteran level 1
---@field Level2 integer  Define how much kills are required for reaching veteran level 2
---@field Level3 integer  Define how much kills are required for reaching veteran level 3
---@field Level4 integer  Define how much kills are required for reaching veteran level 4
---@field Level5 integer  Define how much kills are required for reaching veteran level 5

---@class UnitBlueprintWreckage
---@field Blueprint string
---@field EnergyMult number  the amount of energy you get when reclaiming expressed as a multiplier of the energy cost when it was alive>
---@field HealthMult number  the amount of health this wreck has so it can take damage from weapons that do area damage>
---@field MassMult number    the amount of mass you get when reclaiming expressed as a multiplier of the mass cost when it was alive>
---@field ReclaimTimeMultiplier number  the time it takes to reclaim this wreck expressed as a multiplier of the build time>
---@field WreckageLayers table<Layer, boolean>
