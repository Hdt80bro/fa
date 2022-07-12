---@meta

--- No clue what this does
---@param entityId number
---@param onTime number
---@param offTime number
---@param totalTime number
function AddBlinkyBox(entityId, onTime, offTime, totalTime)
end

---
---@param meshInfo MeshInfo
---@param duration number
function AddCommandFeedbackBlip(meshInfo,  duration)
end

---
---@param func fun(text: string): any
function AddConsoleOutputReciever(func)
end

---
---@param control Control
function AddInputCapture(control)
end

---
---@param selection Unit[]
function AddSelectUnits(selection)
end

--- Add unit to the session extra select list
---@param unit Unit
function AddToSessionExtraSelectList(unit)
end

--- Return true if there is anything currently on the capture stack
---@return boolean
function AnyInputCapture()
end

--- Set the audio language
---@param language Language
function AudioSetLanguage(language)
end

--- Clear and disable the build templates
function ClearBuildTemplates()
end

---
function ClearCurrentFactoryForQueueDisplay()
end

--- Destroy all controls in frame, `nil` head will clear all frames
---@param head number | nil
function ClearFrame(head)
end

--- Clear the session extra select list
function ClearSessionExtraSelectList()
end

--- Perform a console command
---@param command string
function ConExecute(command)
end

--- Perform a console command, saved to stack
---@param command string
function ConExecuteSave(command)
end

---comment
---@param text string
function ConTextMatches(text)
end

--- Copy the current replay to another file
---@param profile string
---@param newFilename string
function CopyCurrentReplay(profile, newFilename)
end

--- CreateUnitAtMouse
---@param blueprintId string
---@param ownerArmyIndex number
---@param offsetMouseWorldPosX number
---@param offsetMouseWorldPosZ number
---@param rotation number
---@return Unit
function CreateUnitAtMouse(blueprintId, ownerArmyIndex, offsetMouseWorldPosX, offsetMouseWorldPosZ, rotation)
end

--- Get the current time in seconds, counting from 0 at application start.
--- This is wall-clock time and is unaffected by gameplay.
---@return number
function CurrentTime()
end

--- Return `true` if debug facilities are enabled
---@return boolean
function DebugFacilitiesEnabled()
end

---
---@param queueIndex number
---@param count number
function DecreaseBuildCountInQueue(queueIndex, count)
end

---
---@param id unknown
function DeleteCommand(id)
end

---
function DisableWorldSounds()
end

--- Eject another client from your session
---@param clientIndex number
function EjectSessionClient(clientIndex)
end

---
function EnableWorldSounds()
end

--- Kill current UI and start main menu from top
function EngineStartFrontEndUI()
end

--- Kill current UI and start splash screens
function EngineStartSplashScreens()
end

--- Return true if a unit category contains this unit
---@param category moho.EntityCategory
---@param unit Unit
function EntityCategoryContains(category, unit)
end

--- Filter a list of units to only those found in the category
---@param category moho.EntityCategory
---@param units Unit[]
---@return Unit[]
function EntityCategoryFilterDown(category, units)
end

--- Filter a list of units to exclude those found in the category
---@param category moho.EntityCategory
---@param units Unit[]
---@return Unit[]
function EntityCategoryFilterOut(category, units)
end

--- Execute some lua code in the sim
---@param func function
---@param ... any this may actually be a comma-separated string of args instead of a vararg
---@return any
function ExecLuaInSim(func, ...)
end

--- Request that the application shut down
function ExitApplication()
end

--- Quit the sim, but not the app
function ExitGame()
end

--- Flush mouse/keyboard events
function FlushEvents()
end

--- Format a string displaying the time specified in seconds
---@param seconds number
---@return string
function FormatTime(seconds)
end

--- Get the current game time in ticks. The game time is the simulation time,
--- that stops when the game is paused.
---@return number
function GameTick()
end

--- Get the current game time in seconds. The game time is the simulation time,
--- that stops when the game is paused.
---@return number
function GameTime()
end

--- Generate and enable build templates from the current selection
function GenerateBuildTemplateFromSelection()
end

--- Get active build template back to Lua
---@return BuildTemplate
function GetActiveBuildTemplate()
end

---
---@return number[]
function GetAntiAliasingOptions()
end

---
--- Note that this is cached by `/lua/ui/lobbby/override/ArmiesTable.lua`
---@return ArmiesTable
function GetArmiesTable()
end

--- Return a table of avatar units for the army
---@return Unit[]
function GetArmyAvatars()
end

--- It is unknown where this number gets pulled from
---@param armyIndex number
---@return number
function GetArmyScore(armyIndex)
end

--- Get a list of units assisting me
---@param units Unit[]
---@return Unit[]
function GetAssistingUnitsList(units)
end

--- Get a list of units blueprint attached to transports
---@param units Unit[]
---@return Unit[]
function GetAttachedUnitsList(units)
end

--- Get the blueprint of an object
---@param obj Entity
---@return nil
---@overload fun(unit: UserUnit): UnitBlueprint
---@overload fun(weapon: Weapon): WeaponBlueprint
---@overload fun(unit: Prop): PropBlueprint
function GetBlueprint(obj)
end

---
---@param name string
---@return Camera
function GetCamera(name)
end

--- Gets the following arguments to a commandline option. For example, if `/arg flag key:value`
--- was passed to the commandline, then `GetCommandLineArg("/arg", 2)` would return
--- `{"flag", "key:value"}`
---@see GetCommandLineArgTable(option) for parsing key-values
---@param option string
---@param maxArgs number
---@return string[]?
function GetCommandLineArg(option, maxArgs)
end

--- Return 'splash', 'frontend', or 'game' depending on the current state of the UI
---@return 'splash' | 'frontend' | 'game'
function GetCurrentUIState()
end

---
---@return Cursor
function GetCursor()
end

---
---@return table
function GetEconomyTotals()
end

--- Get the right fire state for the units passed in
---@param units Unit[]
---@return boolean
function GetFireState(units)
end

---
---@return number
function GetFocusArmy()
end

--- Return the root UI frame for a given head
---@param head number
---@return Frame
function GetFrame(head)
end

---
---@param key string
---@return any
function GetFrontEndData(key)
end

--- Return the current game speed
---@return number
function GetGameSpeed()
end

--- Return a formatted string displaying the time the game has been played
---@return string
function GetGameTime()
end

--- Return game time in seconds
---@return number
function GetGameTimeSeconds()
end

--- Return a table of idle engineer units for the army
---@return Unit[]
function GetIdleEngineers()
end

--- Return a table of idle factory units for the army
---@return Unit[]
function GetIdleFactories()
end

--- Returns the current capture control, or nil if none
---@return Control | nil
function GetInputCapture()
end

--- See if anyone in the list is auto building
---@param units Unit[]
---@return boolean
function GetIsAutoMode(units)
end

--- See if anyone in the list is auto surfacing
---@param units Unit[]
---@return boolean
function GetIsAutoSurfaceMode(units)
end

--- Is anyone in this list builder paused?
---@param units Unit[]
---@return boolean
function GetIsPaused(units)
end

-- FIXME it doesn't like negative numbers

---@alias SubmergeStatus
---| -1 #submerged
---| 0 #unknown
---| 1 #not submerged

--- Determine if units are submerged
---@param units Unit[]
---@return SubmergeStatus
function GetIsSubmerged(units)
end

---
---@return Vector2
function GetMouseScreenPos()
end

---
---@return Vector
function GetMouseWorldPos()
end

---
---@return number
function GetMovieVolume()
end

--- Return the current number of root frames (typically one per head)
---@return number
function GetNumRootFrames()
end

---
---@param key string
---@return string[]
function GetOptions(key)
end

---
---@param string string
---@param default any?
---@return any
function GetPreference(string, default)
end

---
---@return boolean
function GetResourceSharing()
end

---
---@return RolloverInfo
function GetRolloverInfo()
end

--- Get the state for the script bit
---@param unit Unit
---@param bit number
---@return boolean
function GetScriptBit(unit, bit)
end

--- Return a table of the currently selected units
---@return table
function GetSelectedUnits()
end

--- Return a table of the various clients in the current session
---@return table[]
function GetSessionClients()
end

---
---@return number
function GetSimRate()
end

---
---@return number
function GetSimTicksPerSecond()
end

--- Get information on a profile based file, `nil` if unable to find
---@param profileName string
---@param basename string
---@param type string
---@return table
function GetSpecialFileInfo(profileName, basename, type)
end

--- Given the base name of a special file, returns the complete path
---@param profilename string
---@param filename string
---@param type string
---@return string
function GetSpecialFilePath(profilename,  filename,  type)
end

--- Return a table of strings which are the names of files in special locations (currently SaveFile, Replay)
---@param type string
---@return table
function GetSpecialFiles(type)
end

---
---@param type string
---@return string
function GetSpecialFolder(type)
end

--- Return a formatted string displaying the System time
---@return string
function GetSystemTime()
end

--- Return System time in seconds
---@return number
function GetSystemTimeSeconds()
end

---
---@param filename string
---@param border number? defaults to 1
---@return number width
---@return number height
function GetTextureDimensions(filename,  border)
end

--- Get the alpha multiplier for 2D UI controls
---@return number
function GetUIControlsAlpha()
end

---
---@param id string
---@return Unit
function GetUnitById(id)
end

--- Given a set of units, get the union of orders and unit categories (for determining builds)
---@param unitSet any
---@return string[] orders
---@return OrderInfo[] availableToggles
---@return moho.EntityCategory[] buildableCategories
function GetUnitCommandData(unitSet)
end

--- Given a RULEUCC type command, return the equivalent UNITCOMMAND command
---@param rule string
---@return string
function GetUnitCommandFromCommandCap(rule)
end

--- Return a table of the currently selected units
---@return Unit[]
function GetValidAttackingUnits()
end

---
---@param category string
---@return number
function GetVolume(category)
end

---@return boolean
function GpgNetActive()
end

---@param cmd string
---@param ... any
function GpgNetSend(cmd, ...)
end

---
---@return boolean
function HasCommandLineArg(option)
end

---
---@param language Language
function HasLocalizedVO(language)
end

--- Add a set of key mappings
---@param keyMapTable table
function IN_AddKeyMapTable(keyMapTable)
end

--- Clear all key mappings
function IN_ClearKeyMap()
end

--- Remove the keys from the key map
---@param keyMapTable table
function IN_RemoveKeyMapTable(keyMapTable)
end

---
---@param queueIndex any
---@param count number
function IncreaseBuildCountInQueue(queueIndex, count)
end

--- For internal use by `Bitmap.__init()`
---@param bitmap Bitmap
---@param parent any
function InternalCreateBitmap(bitmap, parent)
end

--- For internal use by `Border.__init()`
---@param border Border
---@param parent Control
function InternalCreateBorder(border, parent)
end

--- For internal use by `CreateDiscoveryService()`
---@param serviceClass fa-class
---@return DiscoveryService
function InternalCreateDiscoveryService(serviceClass)
end

--- For internal use by `Dragger.__init()`
---@param dragger Dragger
function InternalCreateDragger(dragger)
end

--- For internal use by `Edit.__init()`
---@param edit Edit
---@param parent Control
function InternalCreateEdit(edit, parent)
end

--- For internal use by `Frame.__init()`
---@param frame Frame
function InternalCreateFrame(frame)
end

--- For internal use by `Group.__init()`
---@param group Group
---@param parent Control
function InternalCreateGroup(group, parent)
end

--- For internal use by `Histogram.__init()`
---@param histogram Histogram
---@param parent Control
function InternalCreateHistogram(histogram, parent)
end

--- For internal use by `ItemList.__init()`
---@param itemList ItemList
---@param parent Control
function InternalCreateItemList(itemList, parent)
end

--- For internal use by CreateLobbyComm()
---@param lobbyComClass fa-class
---@param protocol string
---@param localPort number
---@param maxConnections number
---@param playerName string
---@param playerUID string
---@param natTraversalProvider userdata
---@return LobbyComm
function InternalCreateLobby(lobbyComClass, protocol, localPort, maxConnections, playerName, playerUID, natTraversalProvider)
end

--- For internal use by `MapPreview.__init()`
---@param mapPreview MapPreview
---@param parent Control
function InternalCreateMapPreview(mapPreview, parent)
end

--- For internal use by `Mesh.__init()`
---@param mesh Mesh
---@param parent Control
function InternalCreateMesh(mesh, parent)
end

--- For internal use by `Movie.__init()`
---@param movie Movie
---@param parent Control
function InternalCreateMovie(movie, parent)
end

--- For internal use by `ScrollBar.__init()`
---@param scrollBar Scrollbar
---@param parent Control
---@param axis "Vert"|"Horz" found in `/lua/scrollbar.lua#ScrollAxis`
function InternalCreateScrollbar(scrollBar, parent, axis)
end

--- For internal use by `Text.__init()`
---@param text Text
---@param parent Control
function InternalCreateText(text, parent)
end

--- For internal use by `WldUIProvider.__init()`
---@param wldUIProvider WldUIProvider
function InternalCreateWldUIProvider(wldUIProvider)
end

--- For internal use by `WorldMesh.__init()`
---@param worldMesh WorldMesh
function InternalCreateWorldMesh(worldMesh)
end

--- Save the current session
---@param filename string
---@param friendlyname string
---@param oncompletion fun(worked: boolean, errmsg: string)
function InternalSaveGame(filename, friendlyname, oncompletion)
end

---
---@param army1 number
---@param army2 number
---@return boolean
function IsAlly(army1, army2)
end

---
---@param army1 number
---@param army2 number
---@return boolean
function IsEnemy(army1, army2)
end

---
---@param keyCode string
---@return boolean
function IsKeyDown(keyCode)
end

---
---@param army1 number
---@param army2 number
---@return boolean
function IsNeutral(army1, army2)
end

---
---@param playerId string
---@return boolean
function IsObserver(playerId)
end

---
---@param command string
---@param blueprintid string
---@param count number
---@param clear boolean? defaults to false
function IssueBlueprintCommand(command, blueprintid, count, clear)
end

---
---@param command any
---@param string any?
---@param clear boolean?
function IssueCommand(command, string, clear)
end

---
---@param clear boolean
function IssueDockCommand(clear)
end

---
---@param unitList Unit[]
---@param command string
---@param string string?
---@param clear boolean?
function IssueUnitCommand(unitList, command, string, clear)
end

--- Given a MS Windows char code, returns the Maui char code
---@param charcode number
---@return number
function KeycodeMSWToMaui(charcode)
end

--- Given a char code from a key event, returns the MS Windows char code
---@param charcode number
---@return number
function KeycodeMauiToMSW(charcode)
end

---@deprecated
--- Will not work
function LaunchGPGNet()
end

--- Starts a replay of a given file, returns false if unable to launch
---@param filename string
---@return boolean
function LaunchReplaySession(filename)
end

--- Launch a new single player session
---@param sessionInfo UIScenarioInfo
function LaunchSinglePlayerSession(sessionInfo)
end

---
---@param filename string
---@return boolean
function LoadSavedGame(filename)
end

---
---@param blueprintId string
function MapBorderAdd(blueprintId)
end

---
function MapBorderClear()
end

--- Open the default browser window to the specified URL
---@param url string
function OpenURL(url)
end

--- Parse a string to generate a new entity category
---@param cat string
---@return moho.EntityCategory
function ParseEntityCategory(cat)
end

---
---@param category string
---@param pause boolean
function PauseSound(category, pause)
end

---
---@param category string
---@param pause boolean
function PauseVoice(category, pause)
end

---
---@param sound BpSoundResult
---@param prepareOnly? boolean
---@return moho.sound_methods
function PlaySound(sound, prepareOnly)
end

---
---@param params any
function PlayTutorialVO(params)
end

---
---@param sound BpSoundResult
---@param duck? boolean
---@return moho.sound_methods
function PlayVoice(sound, duck)
end

--- Make `dragger` the active dragger from a particular frame.
--- You can pass nil to cancel the current dragger.
---@param originFrame Frame
---@param keycode string
---@param dragger Dragger | nil
function PostDragger(originFrame, keycode, dragger)
end

--- Start a background load with the given map and mods.
--- If `hipri` is true, this will interrupt any previous loads in progress.
---@param mapname string
---@param mods ModInfo[]
---@param hipri? boolean
function PrefetchSession(mapname, mods, hipri)
end

--- Generate a random number between `min` and `max`
---@param min number defaults to 0
---@param max number defaults to 1
---@return number
---@overload fun(max: number): number
---@overload fun(): number
function Random(min, max)
end

---
---@param handler function
function RemoveConsoleOutputReciever(handler)
end

--- Remove unit from the session extra select list
---@param unit Unit
function RemoveFromSessionExtraSelectList(unit)
end

--- Remove the control from the capture array (always first from back)
---@param control Control
function RemoveInputCapture(control)
end

--- Remove the profile directory and all special files
---@param profile string
function RemoveProfileDirectories(profile)
end

--- Remove a profile based file from the disc
---@param profilename string
---@param basename string
---@param type string
function RemoveSpecialFile(profilename, basename, type)
end

---
---@param render boolean
function RenderOverlayEconomy(render)
end

---
---@param render boolean
function RenderOverlayIntel(render)
end

---
---@param render boolean
function RenderOverlayMilitary(render)
end

--- Restart the current mission/skirmish/etc
function RestartSession()
end

---
function SavePreferences()
end

--- Select the specified units
---@param units Unit[]
function SelectUnits(units)
end

--- Return true iff the active session can be restarted
---@return boolean
function SessionCanRestart()
end

--- End the current game session.
--- The session says active, we just disconnect from everyone else and freeze play.
function SessionEndGame()
end

--- Return a table of command sources
---@return string[]
function SessionGetCommandSourceNames()
end

--- Return the local command source, or `0` if the local client can't issue commands
---@return number
function SessionGetLocalCommandSource()
end

--- Return the table of scenario info that was originally passed to the sim on launch
---@return UIScenarioInfo
function SessionGetScenarioInfo()
end

--- Return true iff there is a session currently running
---@return boolean
function SessionIsActive()
end

--- Return true iff the active session is a being recorded
---@return boolean
function SessionIsBeingRecorded()
end

--- Return true iff the session has been won or lost yet
---@return boolean
function SessionIsGameOver()
end

--- Return true iff the active session is a multiplayer session
---@return boolean
function SessionIsMultiplayer()
end

--- Return true iff observing is allowed in the active session
---@return boolean
function SessionIsObservingAllowed()
end

--- Return true iff the session is paused
---@return boolean
function SessionIsPaused()
end

--- Return true iff the active session is a replay session
---@return boolean
function SessionIsReplay()
end

--- Pause the world simulation
function SessionRequestPause()
end

--- Resume the world simulation
function SessionResume()
end
 
---
---@param client? number | number[] client or clients
---@param message string
function SessionSendChatMessage(client, message)
end

--- Set this as an active build template
---@param template BuildQueue
function SetActiveBuildTemplate(template)
end

--- Set if anyone in the list is auto building
---@param units Unit[]
---@param mode boolean
function SetAutoMode(units, mode)
end

--- Set if anyone in the list is auto surfacing
---@param units Unit[]
---@param mode boolean
function SetAutoSurfaceMode(units, mode)
end

---
---@param unit Unit
---@return BuildQueue
function SetCurrentFactoryForQueueDisplay(unit)
end

---
---@param cursor Cursor
function SetCursor(cursor)
end

--- Set the specific fire state for the units passed in
---@param units Unit[]
---@param fireState FireState
function SetFireState(units, fireState)
end

---
---@param armyIndex number index or -1
function SetFocusArmy(armyIndex)
end

---
---@param key string
---@param data any
function SetFrontEndData(key, data)
end

--- Set the desired game speed
---@param speed number
function SetGameSpeed(speed)
end

---
---@param volume number 0.0 - 2.0
function SetMovieVolume(volume)
end

---
---@param overlay string
---@param categories moho.EntityCategory
---@param normalColor string
---@param selectColor string
---@param rolloverColor string
---@param inner1 number
---@param inner2 number
---@param outer1 number
---@param outer2 number
function SetOverlayFilter(overlay, categories, normalColor, selectColor, rolloverColor, inner1, inner2, outer1, outer2)
end

---
---@param list RangeOverlay[]
---@see `/lua/ui/game/RangeOverlayParams.lua`
function SetOverlayFilters(list)
end

--- Pause builders in this list
---@param selection Unit[]
---@param paused boolean
function SetPaused(selection, paused)
end

---
---@param key string
---@param obj any
function SetPreference(key, obj)
end

--- Set the alpha multiplier for 2D UI controls
---@param alpha number
function SetUIControlsAlpha(alpha)
end

---
---@param category string
---@param volume number 0.0 - 2.0
function SetVolume(category, volume)
end

--- Performs a callback with the given identifier from `/lua/sim/simcallbacks.lua`.
--- Optionally appends the unit selection to the arguments.
---@param callback {Func: string, Args: table} where Func represents the callback functions and Args additional data
---@param addUnitSelection? boolean toggles appending the unit selection to the callback
function SimCallback(callback, addUnitSelection)
end

-- Something got messed up with whatever imported these functions, and not only did it
-- mix up comments and function names, it got them off by one
-- This means that I have no idea what function this goes to:
--       If bool is specified and true, sends the current selection with the command

---
---@param handle moho.sound_methods
---@return boolean
function SoundIsPrepared(handle)
end

---
---@param handle moho.sound_methods
function StartSound(handle)
end

---
function StopAllSounds()
end

---
---@param handle moho.sound_methods
---@param immediate? boolean defaults to false
function StopSound(handle, immediate)
end

---
---@param region Rectangle
function SyncPlayableRect(region)
end

---
---@param mode boolean
function TeamColorMode(mode)
end

-- TODO do these kinds of functions (that duplicate in `Unit.lua`) also accept single units
-- like some of the other functions alude to?

--- Set the right fire state for the units passed in
---@param units Unit[]
---@param fireState FireState
function ToggleFireState(units, fireState)
end

---
---@param units Unit[]
---@param bit number
---@param state boolean
function ToggleScriptBit(units, bit, state)
end

---
---@param userunit Unit
---@param seconds? number
function UISelectAndZoomTo(userunit, seconds)
end

--- Select units based on a category expression
---@param expression string
---@param addToCurSel boolean
---@param inViewFrustum boolean
---@param nearestToMouse boolean
---@param mustBeIdle boolean
function UISelectionByCategory(expression, addToCurSel, inViewFrustum, nearestToMouse, mustBeIdle)
end

---
---@param units Unit[]
---@param seconds? number
function UIZoomTo(units, seconds)
end

---
---@param self WorldView maybe?
---@param point Vector2
---@return Vector
function UnProject(self, point)
end

---
---@param ipaddr string
---@return string
function ValidateIPAddress(ipaddr)
end

--- Validate a list of units
---@param units Unit[]
---@return Unit[]
function ValidateUnitsList(units)
end

---
---@return boolean
function WorldIsLoading()
end

---
---@return boolean
function WorldIsPlaying()
end

--- For internal use by `Cursor.__init()`
---@param cursor Cursor
---@param spec any
function _c_CreateCursor(cursor, spec)
end

--- For internal use by `UserDecal.__init()`
---@param decal UserDecal
---@param spec any
function _c_CreateDecal(decal, spec)
end

--- For internal use by `PathDebugger.__init()`
---@param pathDebugger PathDebugger
---@param spec any
function _c_CreatePathDebugger(pathDebugger, spec)
end

------
-- New functions from engine patch:
------

---@alias PatchedDepositType
---| 0 #all
---| 1 #mass
---| 2 #hydrocarbon

---@class PatchedDepositResult
---@field X1 number
---@field X2 number
---@field Z1 number
---@field Z2 number
---@field Type PatchedDepositType
---@field Dist number

--- Return list of deposits around a point of type
---@param x number
---@param z number
---@param radius number
---@param type PatchedDepositType
---@return PatchedDepositResult[]
function GetDepositsAroundPoint(x, z, radius, type)
end
