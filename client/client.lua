local firstPersonAimingEnabled = false

-- Command to toggle first person aiming mode
RegisterCommand(Config.CommandName, function()
    firstPersonAimingEnabled = not firstPersonAimingEnabled
    local message = firstPersonAimingEnabled and "First person aiming enabled" or "First person aiming disabled"
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"[ds-aim]", ":".. message}
    })
end, false)

-- Monitor player aiming
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if firstPersonAimingEnabled then
            if IsPlayerFreeAiming(PlayerId()) then
                -- Check if the player is in third person view and aiming
                if GetFollowPedCamViewMode() ~= 4 then
                    SetFollowPedCamViewMode(4)  -- Set to first person
                end
            else
                -- Revert to third person view if not aiming
                if GetFollowPedCamViewMode() == 4 then
                    SetFollowPedCamViewMode(1)  -- Set to third person (default view mode)
                end
            end
        end
        Wait(0)
    end
end)
