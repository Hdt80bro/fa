
-- The global sync table is copied from the sim layer every time the main and sim threads are
-- synchronized on the sim beat (which is like a tick but happens even when the game is paused)
Sync = {}

-- The PreviousSync table holds just what you'd expect it to, the sync table from the previous
-- beat.
PreviousSync = {}

-- Unit specific data that's been sync'd. Data changes are accumulated by merging
-- the Sync.UnitData table into this table each sync (if there's new data)
UnitData = {}

local utils = import('/lua/system/utils.lua')
local UIUtil = import('/lua/ui/uiutil.lua')
local reclaim = import('/lua/ui/game/reclaim.lua')
local UpdateReclaim = reclaim.UpdateReclaim
local sendEnhancementMessage = import('/lua/ui/notify/notify.lua').sendEnhancementMessage
local SetPlayableArea = reclaim.SetPlayableArea

--- Whether or not a game result (for rated games) has been seen already. Note that messing with
-- this value with mods is forbidden.
local hasSeenResult = false

-- Here's an opportunity for user side script to examine the Sync table for the new tick
function OnSync()

    if Sync.ArmyTransfer then 
        local army = GetFocusArmy()
        for k, transfer in Sync.ArmyTransfer do 
            local other = GetArmiesTable().armiesTable[transfer.from].nickname 
            if transfer.to == army then 
                local primary = "Fullshare"
                local secondary = LOCF('<LOC fullshare_announcement>%s\'s units have been transferred to you', other)
                local control = nil
                UIUtil.CreateAnnouncementStd(primary, secondary, control)
            end
        end
    end

    if Sync.ProfilerData then
        import("/lua/ui/game/Profiler.lua").ReceiveData(Sync.ProfilerData)
    end

    if Sync.BenchmarkModules then
        import("/lua/ui/game/Profiler.lua").ReceiveBenchmarkModules(Sync.BenchmarkModules)
    end

    if Sync.BenchmarkOutput then
        import("/lua/ui/game/Profiler.lua").ReceiveBenchmarkOutput(Sync.BenchmarkOutput)
    end

    if Sync.BenchmarkProgress then
        import("/lua/ui/game/Profiler.lua").ReceiveBenchmarkProgress(Sync.BenchmarkProgress)
    end

    if Sync.GameHasAIs ~= nil then 
        import("/lua/ui/game/gamemain.lua").GameHasAIs = Sync.GameHasAIs
    end

    if Sync.RequestingExit then
        ExitGame()
    end

    if not table.empty(Sync.UnitData) then
        UnitData = table.merged(UnitData,Sync.UnitData)
    end

    for id, v in Sync.ReleaseIds do
        UnitData[id] = nil
    end

    --Play Sounds
    for k, v in Sync.Sounds do
        PlaySound(Sound{ Bank=v.Bank, Cue=v.Cue })
    end

    if Sync.ToggleGamePanels then
        ConExecute('UI_ToggleGamePanels')
    end

    if Sync.ToggleLifeBarsOff then
        ConExecute('UI_RenderUnitBars false')
    end

    if Sync.ToggleLifeBarsOn then
        ConExecute('UI_RenderUnitBars true')
    end

    if not table.empty(Sync.AIChat) then
        for k, v in Sync.AIChat do
            import('/lua/AIChatSorian.lua').AIChat(v.group, v.text, v.sender)
        end
    end

    if Sync.UserConRequests then
        for num, execRequest in Sync.UserConRequests do
            ConExecute(execRequest)
        end
    end

    if Sync.NukeLaunchData then
        import('/lua/ui/game/nukelaunchping.lua').DoNukePing(Sync.NukeLaunchData)
    end

    -- Each sync, update the user-side data for any prop created, damaged, or destroyed
    if not table.empty(Sync.Reclaim) then
        UpdateReclaim(Sync.Reclaim)
    end

    if Sync.EnhanceMessage and not table.empty(Sync.EnhanceMessage) then
        for _, messageTable in Sync.EnhanceMessage do
            sendEnhancementMessage(messageTable)
        end
    end

    if Sync.NewPlayableArea then
        SetPlayableArea(Sync.NewPlayableArea)
    end

    if Sync.StartPositions then
        import('/lua/ui/game/worldview.lua').MarkStartPositions(Sync.StartPositions)
    end

    if Sync.LobbyOptions then 
        import('/lua/ui/game/gamemain.lua').LobbyOptions = table.deepcopy(Sync.LobbyOptions)
    end

    if Sync.MassFabs then
        import('/lua/ui/game/massfabs.lua').Update(table.deepcopy(Sync.MassFabs))
    end

    import('/lua/UserCamera.lua').ProcessCameraRequests(Sync.CameraRequests)

    if Sync.FocusArmyChanged then
        import('/lua/ui/game/avatars.lua').FocusArmyChanged()
        import('/lua/ui/game/multifunction.lua').FocusArmyChanged()
        import('/lua/ui/notify/notify.lua').focusArmyChanged()
    end

    if Sync.CampaignMode then
        import('/lua/ui/campaign/campaignmanager.lua').campaignMode = Sync.CampaignMode
    end

    if Sync.PlayMFDMovie then
        import('/lua/ui/game/missiontext.lua').PlayMFDMovie(Sync.PlayMFDMovie, Sync.VideoText)
    end
    if Sync.UserUnitEnhancements then
        import('/lua/enhancementcommon.lua').SetEnhancementTable(Sync.UserUnitEnhancements)
    end

    if Sync.ObjectivesTable and next(Sync.ObjectivesTable) then
        import('/lua/ui/game/objectives2.lua').AddObjectives(Sync.ObjectivesTable)
    end

    if Sync.ObjectivesUpdateTable and next(Sync.ObjectivesUpdateTable) then
        import('/lua/ui/game/objectives2.lua').UpdateObjectivesTable(Sync.ObjectivesUpdateTable)
    end

    if Sync.ObjectiveTimer then
        if Sync.ObjectiveTimer != false then
            import('/lua/ui/game/timer.lua').SetTimer(Sync.ObjectiveTimer)
        else
            import('/lua/ui/game/timer.lua').ResetTimer()
        end
    end

    --Play Voices
    if not import('/lua/ui/game/missiontext.lua').IsHeadPlaying() then
        for k, v in Sync.Voice do
            PlayVoice(Sound{ Bank=v.Bank, Cue=v.Cue }, true)
        end
    end

    if Sync.AddTransmissions then
        import('/lua/ui/game/transmissionlog.lua').OnPostLoad(Sync.AddTransmissions)
    end

    if Sync.EnhanceRestrict then
        import('/lua/enhancementcommon.lua').RestrictList(Sync.EnhanceRestrict)
    end
    if Sync.Restrictions then
        import('/lua/game.lua').SetRestrictions(Sync.Restrictions)
    end

    if Sync.NISVideo then
        import('/lua/ui/game/missiontext.lua').PlayNIS(Sync.NISVideo)
    end

    if Sync.EndGameMovie then
        import('/lua/ui/game/missiontext.lua').PlayEndGameMovie(Sync.EndGameMovie)
    end

    if Sync.HelpPrompt then
        import('/lua/ui/game/helptext.lua').AddHelpTextPrompt(Sync.HelpPrompt)
    end

    if Sync.MPTaunt then
        local msg = {}
        msg.tauntid = Sync.MPTaunt[1]
        msg.taunthead = Sync.MPTaunt[2]
        SessionSendChatMessage(msg)
    end

    if Sync.Ping then
        import('/lua/ui/game/ping.lua').DisplayPing(Sync.Ping)
    end

    if Sync.MaxPingMarkers then
        import('/lua/ui/game/ping.lua').MaxMarkers = Sync.MaxPingMarkers
    end

    if not table.empty(Sync.Score) then
        import('/lua/ui/game/score.lua').currentScores = Sync.Score
    end

    if Sync.PausedBy then
        if not PreviousSync.PausedBy then
            import('/lua/ui/game/gamemain.lua').OnPause(Sync.PausedBy, Sync.TimeoutsRemaining)
        end
    else
        if PreviousSync.PausedBy then
            import('/lua/ui/game/gamemain.lua').OnResume()
        end
    end

    if Sync.Paused != PreviousSync.Paused then
        import("/lua/ui/game/gamemain.lua").OnPause(Sync.Paused);
    end

    if Sync.PlayerQueries then
        import('/lua/UserPlayerQuery.lua').ProcessQueries(Sync.PlayerQueries)
    end

    if Sync.QueryResults then
        import('/lua/UserPlayerQuery.lua').ProcessQueryResults(Sync.QueryResults)
    end

    if Sync.OperationComplete then
        if Sync.OperationComplete.success then
            GpgNetSend('OperationComplete', Sync.OperationComplete.allPrimary, Sync.OperationComplete.allSecondary, GetGameTime())
        end
        import('/lua/ui/campaign/campaignmanager.lua').OperationVictory(Sync.OperationComplete)
    end

    if Sync.Cheaters then
        --Ted, this is where you would hook in better cheater reporting.
        local names = ''
        local isare = LOC('<LOC cheating_fragment_0000>is')
        local srcs = SessionGetCommandSourceNames()
        for k,v in ipairs(Sync.Cheaters) do
            if names != '' then
                names = names .. ', '
                isare = LOC('<LOC cheating_fragment_0001>are')
            end
            names = names .. (srcs[v] or '???')
        end
        local msg = names .. ' ' .. isare
        if Sync.Cheaters.CheatsEnabled then
            msg = msg .. LOC('<LOC cheating_fragment_0002> cheating!')
        else
            msg = msg .. LOC('<LOC cheating_fragment_0003> trying to cheat!')
        end
        print(msg)
    end

    if Sync.DiplomacyAction then
        import('/lua/ui/game/diplomacy.lua').ActionHandler(Sync.DiplomacyAction)
    end

    if Sync.DiplomacyAnnouncement then
        import('/lua/ui/game/diplomacy.lua').AnnouncementHandler(Sync.DiplomacyAnnouncement)
    end

    if Sync.LockInput then
        import('/lua/ui/game/worldview.lua').LockInput()
    end

    if Sync.UnlockInput then
        import('/lua/ui/game/worldview.lua').UnlockInput()
    end

    if Sync.NISMode then
        import('/lua/ui/game/gamemain.lua').NISMode(Sync.NISMode)
    end

    if Sync.RequestPlayerFaction then
        import('/lua/ui/game/factionselect.lua').RequestPlayerFaction()
    end

    if Sync.PrintText then
        for _, textData in Sync.PrintText do
            local data = textData
            if type(Sync.PrintText) == 'string' then
                data = {text = Sync.PrintText, size = 14, color = 'ffffffff', duration = 5, location = 'center'}
            end
            import('/lua/ui/game/textdisplay.lua').PrintToScreen(data)
        end
    end

    if Sync.FloatingEntityText then
        for _, textData in Sync.FloatingEntityText do
            import('/lua/ui/game/unittext.lua').FloatingEntityText(textData)
        end
    end

    if Sync.StartCountdown then
        for _, textData in Sync.StartCountdown do
            import('/lua/ui/game/unittext.lua').StartCountdown(textData)
        end
    end

    if Sync.CancelCountdown then
        for _, textData in Sync.CancelCountdown do
            import('/lua/ui/game/unittext.lua').CancelCountdown(textData)
        end
    end

    if Sync.AddPingGroups then
        import('/lua/ui/game/objectives2.lua').AddPingGroups(Sync.AddPingGroups)
    end

    if Sync.RemovePingGroups then
        import('/lua/ui/game/objectives2.lua').RemovePingGroups(Sync.RemovePingGroups)
    end

    if Sync.SetAlliedVictory != nil then
        import('/lua/ui/game/diplomacy.lua').SetAlliedVictory(Sync.SetAlliedVictory)
    end

    if Sync.HighlightUIPanel then
        import('/lua/ui/game/tutorial.lua').HighlightPanels(Sync.HighlightUIPanel)
    end

    if Sync.AddCameraMarkers then
        import('/lua/ui/game/tutorial.lua').AddCameraMarkers(Sync.AddCameraMarkers)
    end

    if Sync.RemoveCameraMarkers then
        import('/lua/ui/game/tutorial.lua').RemoveCameraMarkers(Sync.RemoveCameraMarkers)
    end

    if Sync.EndDemo then
        import('/lua/ui/game/demo.lua').OnDemoEnd()
    end

    if Sync.CreateSimDialogue then
        import('/lua/ui/game/simdialogue.lua').CreateSimDialogue(Sync.CreateSimDialogue)
    end

    if Sync.SetButtonDisabled then
        import('/lua/ui/game/simdialogue.lua').SetButtonDisabled(Sync.SetButtonDisabled)
    end

    if Sync.UpdatePosition then
        import('/lua/ui/game/simdialogue.lua').UpdatePosition(Sync.UpdatePosition)
    end

    if Sync.UpdateButtonText then
        import('/lua/ui/game/simdialogue.lua').UpdateButtonText(Sync.UpdateButtonText)
    end

    if Sync.SetDialogueText then
        import('/lua/ui/game/simdialogue.lua').SetDialogueText(Sync.SetDialogueText)
    end

    if Sync.DestroyDialogue then
        import('/lua/ui/game/simdialogue.lua').DestroyDialogue(Sync.DestroyDialogue)
    end

    if Sync.IsSavedGame == true then
        import('/lua/ui/game/gamemain.lua').IsSavedGame = true
    end

    if Sync.ChangeCameraZoom != nil then
        import('/lua/ui/game/gamemain.lua').SimChangeCameraZoom(Sync.ChangeCameraZoom)
    end

    if not table.empty(Sync.ScoreAccum) then
        LOG("Score data received!")
        import('/lua/ui/dialogs/hotstats.lua').scoreData = Sync.ScoreAccum
    end

    -- Game <-> server communications

    -- Adjusting the behavior of this part of the sync is strictly forbidden and is considered
    -- game manipulation and / or rating manipulation. See also the in-game rules:
    -- - https://www.faforever.com/rules

    --- Processes game results to adjust UI capabilities
    for _, gameResult in Sync.GameResult do
        local armyIndex, result = unpack(gameResult)
        import('/lua/ui/game/gameresult.lua').DoGameResult(armyIndex, result)
    end

    if not SessionIsReplay() then

        --- Sends the defeat / victory / draw game results over to the server
        for _, gameResult in Sync.GameResult do
            local armyIndex, result = unpack(gameResult)
            SPEW(string.format("(%s) Sending game result: %s %s", tostring(GameTick()), armyIndex, result))
            GpgNetSend('GameResult', armyIndex, result)
        end

        --- Sends the (unit) statistics over to the server
        if Sync.StatsToSend then
            local json = import('/lua/system/dkson.lua').json.encode({ stats = Sync.StatsToSend })
            GpgNetSend('JsonStats', json)
            Sync.StatsToSend = nil
        end

        --- Sends potential team kill events to the server
        if Sync.Teamkill then
            local armies, clients = GetArmiesTable().armiesTable, GetSessionClients()
            local victim, instigator = Sync.Teamkill.victim, Sync.Teamkill.instigator
            local data = {time=Sync.Teamkill.killTime, victim={}, instigator={}}

            for k, army in {victim=victim, instigator=instigator} do
                data[k].name = armies[army] and armies[army].nickname or "-"
                data[k].id = clients[army] and clients[army].uid or 0
            end

            GpgNetSend('TeamkillHappened', data.time, data.victim.id, data.victim.name,  data.instigator.id, data.instigator.name)
            WARN(string.format("TEAMKILL: %s KILLED BY %s, TIME: %s", data.victim.name, data.instigator.name, data.time))

            if GetFocusArmy() == victim then
                import('/lua/ui/dialogs/teamkill.lua').CreateDialog(data)
            end
        end

        --- Informs the server to enforce the rating of the game
        if Sync.EnforceRating then
            GpgNetSend('EnforceRating')
        end

        --- Informs the server that the game has ended
        if Sync.GameEnded then
            GpgNetSend('GameEnded')
        end
    end
end
