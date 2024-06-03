local UEHelpers = require("UEHelpers")

print("[LeyakRemover] Mod loaded!\n")

local disableLeyak = false

function sendChatMessage(msg)
    local playerController = FindFirstOf("Abiotic_PlayerController_C")
    playerController:Request_SendTextChatMessage(msg .. "\n")
end

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

--WIP: Still kinda WIP
RegisterKeyBind(Key.F4, function()
    print("[LeyakRemover] F4 pressed\n")

    local playerController = FindFirstOf("Abiotic_PlayerController_C")
    local playerChar = playerController.MyPlayerCharacter

    local playerHotbar = playerChar.CharacterHotbarInventory

    local itemStruct = playerHotbar.CurrentInventory[1]
    
    local itemName = itemStruct.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B.RowName:ToString()
    print("" .. itemName)

    if string.match(itemName, "essence_leyak") then
        playerController:Server_AddToItemStack(playerHotbar, 0, 1)
        sendChatMessage("Giving Leyak Essence to ".. playerChar:GetCharacterName():ToString())
    else
        sendChatMessage("There is no Leyak Essence in the first hotbar slot.")
    end

end)