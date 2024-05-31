local UEHelpers = require("UEHelpers")

print("[MyLuaMod] Mod loaded\n")

local disableLeyak = false

RegisterKeyBind(Key.F2, function()
    print("[MyLuaMod] F2 pressed\n")
    disableLeyak = not disableLeyak
    print("[MyLuaMod] disableLeyak is now " .. tostring(disableLeyak))
end)

RegisterHook("/Game/Blueprints/Environment/Systems/Abiotic_AIDirector.Abiotic_AIDirector_C:SpawnLeyak", function()
    ExecuteWithDelay(2000, function()
        print("[MyLuaMod] Leyak Spawned!\n")
        if disableLeyak then
            local leyak = FindFirstOf("AI_Controller_Leyak_C")
            leyak:Despawn()
            print("[MyLuaMod] Leyak Despawned!\n")
        end
    end)
end)

RegisterKeyBind(Key.F4, function()
    print("[MyLuaMod] F4 pressed\n")

    local playerController = FindFirstOf("Abiotic_PlayerController_C")
    local playerChar = FindFirstOf("Abiotic_PlayerCharacter_C")

end)