if not _G.DamagePingMod then
    _G.DamagePingMod = {}
    DamagePingMod.path = ModPath
    DamagePingMod.last_damage = 0
    DamagePingMod.last_trigger_time = 0
    DamagePingMod.cooldown = 0.5 -- Cooldown in seconds to prevent spamming
end

-- Function to ping the specified server using a get request
function DamagePingMod:RunHttpRequest()
    dohttpreq("http://localhost:1327", function(data, id)
		log("Retrieved server data:\n" .. data)
	end)
end

-- Hook into PlayerDamage:damage_bullet for bullet damage taken
local original_damage_bullet = PlayerDamage.damage_bullet
function PlayerDamage:damage_bullet(attack_data, ...)
    local result = original_damage_bullet(self, attack_data, ...)
    
    -- Check if the player took damage and it's a new damage event
    if attack_data and attack_data.damage and attack_data.damage > 0 then
        local current_time = os.clock()
        -- Only trigger if enough time has passed (cooldown) and damage is less than or equal to previous
        if current_time - DamagePingMod.last_trigger_time >= DamagePingMod.cooldown and attack_data.damage <= DamagePingMod.last_damage then
            DamagePingMod:RunHttpRequest()
            DamagePingMod.last_trigger_time = current_time
            DamagePingMod.last_damage = attack_data.damage
        elseif attack_data.damage > DamagePingMod.last_damage then
            -- Update last damage if current damage is higher (new damage event)
            DamagePingMod.last_damage = attack_data.damage
        end
    end
    
    return result
end

-- Hook into PlayerDamage:damage_melee for melee damage taken
local original_damage_melee = PlayerDamage.damage_melee
function PlayerDamage:damage_melee(attack_data, ...)
    local result = original_damage_melee(self, attack_data, ...)
    
    -- Check if the player took damage and it's a new damage event
    if attack_data and attack_data.damage and attack_data.damage > 0 then
        local current_time = os.clock()
        -- Only trigger if enough time has passed (cooldown) and damage is less than or equal to previous
        if current_time - DamagePingMod.last_trigger_time >= DamagePingMod.cooldown and attack_data.damage <= DamagePingMod.last_damage then
            DamagePingMod:RunHttpRequest()
            DamagePingMod.last_trigger_time = current_time
            DamagePingMod.last_damage = attack_data.damage
        elseif attack_data.damage > DamagePingMod.last_damage then
            -- Update last damage if current damage is higher (new damage event)
            DamagePingMod.last_damage = attack_data.damage
        end
    end
    
    return result
end