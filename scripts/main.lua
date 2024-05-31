local UEHelpers = require("UEHelpers")

print("[LeyakRemover] Mod loaded\n")

local disableLeyak = false
local playerController = FindFirstOf("Abiotic_PlayerController_C")

function sendChatMessage(msg)
    playerController:Request_SendTextChatMessage(msg .. "\n")
end

RegisterKeyBind(Key.F2, function()
    print("[LeyakRemover] F2 pressed\n")
    disableLeyak = not disableLeyak

    if disableLeyak then
        sendChatMessage("Leyak Disabled!")
    else
        sendChatMessage("Leyak Enabled!")
    end

    print("[LeyakRemover] disableLeyak is now " .. tostring(disableLeyak))
    
end)

RegisterHook("/Game/Blueprints/Environment/Systems/Abiotic_AIDirector.Abiotic_AIDirector_C:SpawnLeyak", function()
    ExecuteWithDelay(2000, function()
        print("[LeyakRemover] Leyak Spawned!\n")
        sendChatMessage("Leyak Spawned!")
        if disableLeyak then
            local leyak = FindFirstOf("AI_Controller_Leyak_C")
            leyak:Despawn()
            print("[LeyakRemover] Leyak Despawned!\n")
            sendChatMessage("Leyak Despawned!")
        end
    end)
end)

RegisterKeyBind(Key.F4, function()
    print("[LeyakRemover] F4 pressed\n")
    
    local playerChar = FindFirstOf("Abiotic_PlayerCharacter_C")

    sendChatMessage("F4 pressed")

end)