local UEHelpers = require("UEHelpers")

print("[LeyakRemover] Mod loaded!\n")

local disableLeyak = false

function sendChatMessage(msg)
    local playerController = FindFirstOf("Abiotic_PlayerController_C")
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

--[[
--WIP: This will be used to create Leyak Essence for the player.
RegisterKeyBind(Key.F4, function()
    print("[LeyakRemover] F4 pressed\n")

    local playerController = FindFirstOf("Abiotic_PlayerController_C")
    local playerChar = playerController.MyPlayerCharacter
    
    local testEssence = StaticFindObject("/Game/Blueprints/Environment/Nodes/Resource_Micronode_LeyakEssence.Default__Resource_Micronode_LeyakEssence_C")

    local essName = testEssence:GetItemNameText()

    print("" .. essName:ToString())

    print("" .. tostring(testEssence['Loot Is Generated?']))

    playerChar:TryPickupItemAndFindBestSlotForIt(testEssence.DebrisRow, playerChar['Carryover Changeable Data'], false, 0)

    sendChatMessage("Giving Leyak Essence to ".. playerChar:GetCharacterName():ToString())
end)
]]
---@param ItemRow FDataTableRowHandle
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct
---@param PickedUpEntireStack boolean
---@param NumberOfItemsLeftOver int32
---function AAbiotic_PlayerCharacter_C:TryPickupItemAndFindBestSlotForIt(ItemRow, ChangeableData, PickedUpEntireStack, NumberOfItemsLeftOver) end