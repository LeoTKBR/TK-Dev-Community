local config = {
	combat = COMBAT_PHYSICALDAMAGE, -- combatType do hit principal
	passive = COMBAT_PHYSICALDAMAGE,
	condition = CONDITION_INVISIBLE, -- condition que vai ser aplicada
	weaponType = WEAPON_SWORD, -- weapon Type
	skill = SKILL_FIST, -- Skill chance para ativar a passiva
	skillChance = 0.005, -- 0.005 = 0.5% / skill = 100 - skillChance = 0.5 = 50%
	duration = 0.5, -- 0.5 = 500 milleseconds
	cooldownPassive = 10, -- 10 = 10 seconds
	cooldownStorage = 69995,
	effectTeleport = CONST_ME_WHITE_SMOKE, -- efeito ao teleportar
}

local sound = {
	weapon = SOUND_EFFECT_TYPE_MELEE_ATK_SWORD,
	cast = SOUND_EFFECT_TYPE_ITEM_MOVE_METALIC,
	invisible = SOUND_EFFECT_TYPE_SPELL_INVISIBLE,
}

local direction = {
	north = 0, -- /\ north = 0
	east = 1, -- >> east = 1
	south = 2, -- \/ south = 2
	west = 3, -- << west = 3
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, config.combat)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_IMPACTSOUND, sound.weapon)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

local passive = Combat()
passive:setParameter(COMBAT_PARAM_TYPE, config.passive)
passive:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
passive:setParameter(COMBAT_PARAM_IMPACTSOUND, sound.weapon)
passive:setParameter(COMBAT_PARAM_CASTSOUND, sound.cast)
passive:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

local condition = Condition(config.condition)
condition:setParameter(CONDITION_PARAM_TICKS, config.duration*1000)

local wTeleport = Weapon(config.weaponType)
wTeleport.onUseWeapon = function(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end
	if not player then return true end
	local chance = math.random()
	local skillChance = (player:getSkillLevel(config.skill) * config.skillChance)
	local target = Monster(variant.number)
	local targetPlayer = player:getTarget(variant.number)
	local monsterType = target:getType()
		if monsterType:bossRaceId() == 1 then return combat:execute(player, variant) end
		if chance <= skillChance then
			addEvent(function()
				if target then
					if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
						player:addCondition(condition)
						player:getPosition():sendSingleSoundEffect(sound.invisible, player:isInGhostMode() and nil or player)
						return true
					end
					if not target:getCondition(config.condition) then
							local position = target:getPosition()
							player:addCondition(condition)
							passive:execute(player, variant)
							player:getPosition():sendMagicEffect(config.effectTeleport)
							if target:getDirection() == direction.north then
								position.y = position.y + 1
								player:teleportTo(position)
							elseif target:getDirection() == direction.east then
								position.x = position.x - 1
								player:teleportTo(position)
							elseif target:getDirection() == direction.south then
								position.y = position.y - 1
								player:teleportTo(position)
							elseif target:getDirection() == direction.west then
								position.x = position.x + 1
								player:teleportTo(position)
							end
								player:getPosition():sendSingleSoundEffect(sound.invisible, player:isInGhostMode() and nil or player)
							end
					elseif targetPlayer then
						if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
							player:addCondition(condition)
							player:getPosition():sendSingleSoundEffect(sound.invisible, player:isInGhostMode() and nil or player)
							return true
						end
						if not targetPlayer:getCondition(config.condition) then
							local position = targetPlayer:getPosition()
							player:addCondition(condition)
							passive:execute(player, variant)
							player:getPosition():sendMagicEffect(config.effectTeleport)
							if targetPlayer:getDirection() == direction.north then
								position.y = position.y + 1
								player:teleportTo(position)
							elseif targetPlayer:getDirection() == direction.east then
								position.x = position.x - 1
								player:teleportTo(position)
							elseif targetPlayer:getDirection() == direction.south then
								position.y = position.y - 1
								player:teleportTo(position)
							elseif targetPlayer:getDirection() == direction.west then
								position.x = position.x + 1
								player:teleportTo(position)
							end
								player:getPosition():sendSingleSoundEffect(sound.invisible, player:isInGhostMode() and nil or player)
						end
					return true
				end
				player:setStorageValue(config.cooldownStorage, os.time() + config.cooldownPassive)
			end, 500)
		end
	return combat:execute(player, variant)	
end

wTeleport:id(3300) -- ItemId
wTeleport:vocation("Royal Paladin", true, true) -- Vocation, showDescription, lastVoc
wTeleport:level(5) -- Level
wTeleport:register()