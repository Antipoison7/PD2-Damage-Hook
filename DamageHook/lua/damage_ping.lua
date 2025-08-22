if not _G.DamagePingMod then
    _G.DamagePingMod = {}
    DamagePingMod.path = ModPath
    DamagePingMod.last_trigger_time = 0
    DamagePingMod.cooldown = 0.3 -- Cooldown to ensure not spamming the server, may drop damage if graced
end

-- Function to ping the specified server using a get request
function DamagePingMod:RunHttpRequest(attack_data, ...)
    -- Please note, special characters need to be encoded using percentage encoding https://www.w3schools.com/tags/ref_urlencode.ASP
    -- Example
        -- "https://localhost:1327?chains=In%20A%20%Pickle"
    -- For further reference on passing information using GET, read https://www.w3schools.com/tags/ref_httpmethods.asp
    dohttpreq("http://localhost:1327", function(data, id)
        log("Retrieved server data:\n" .. data)
    end)
end

-- Function to check if the damage should be valid
function DamagePingMod:CheckIsValid(attack_data, func_run, ...)
    -- Check if the player took damage and it's a new damage event
    if attack_data and attack_data.damage and attack_data.damage > 0 then
        local current_time = os.clock()
        -- Only trigger once within the cooldown
        if current_time - DamagePingMod.last_trigger_time >= DamagePingMod.cooldown then
            func_run(attack_data, ...)

            DamagePingMod.last_trigger_time = current_time
            DamagePingMod.last_damage = attack_data.damage
        end
    end

end

-- Hook into PlayerDamage:damage_bullet to trigger a function when player is shot
local original_damage_bullet = PlayerDamage.damage_bullet
function PlayerDamage:damage_bullet(attack_data, ...)
    local result = original_damage_bullet(self, attack_data, ...)
    
    DamagePingMod:CheckIsValid(
        attack_data, 
        DamagePingMod:RunHttpRequest,
        ...
    )
    
    return result
end

-- Hook into PlayerDamage:damage_melee to trigger a function when player is meleed
local original_damage_melee = PlayerDamage.damage_melee
function PlayerDamage:damage_melee(attack_data, ...)
    local result = original_damage_melee(self, attack_data, ...)
    
    DamagePingMod:CheckIsValid(
        attack_data, 
        DamagePingMod:RunHttpRequest,
        ...
    )
    
    return result
end