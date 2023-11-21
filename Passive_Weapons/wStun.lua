local config = {
	combat = COMBAT_PHYSICALDAMAGE, -- combatType do hit principal
	passive = COMBAT_PHYSICALDAMAGE,
	condition = CONDITION_ROOTED, -- condition que vai ser aplicada
	muted = CONDITION_MUTED, -- condition muted
	channelMuted = CONDITION_CHANNELMUTEDTICKS, -- condition channel muted
	weaponType = WEAPON_SWORD, -- weapon Type
	skill = SKILL_FIST, -- Skill chance para ativar a passiva
	skillChance = 0.005, -- 0.005 = 0.5% / skill = 100 - skillChance = 0.5 = 50%
	effect = CONST_ME_STUN, -- efeito ao teleportar
	effectHit = CONST_ME_GROUNDSHAKER,
	duration = 8, -- 20 = 20 segundos - tempo que vai durar o sangramento
	cooldownPassive = 16, -- 10 = 10 seconds
	cooldownStorage = 69995,
}

local sound = {
	weapon = SOUND_EFFECT_TYPE_MELEE_ATK_CLUB,
	cast = SOUND_EFFECT_TYPE_ITEM_MOVE_METALIC,
	stun = SOUND_EFFECT_TYPE_ACTION_OBJECT_FALLING_DEPTH,
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
condition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)
passive:addCondition(condition)

local conditionMuted = Condition(config.muted, config.channelMuted)
conditionMuted:setParameter(CONDITION_PARAM_TICKS, config.duration*1000)
passive:addCondition(conditionMuted)

function effectAndSound(player, variant)
	if not player then return true end
	local target = Monster(variant.number)
	local targetPlayer = Player(variant.number)
	if target then
	local tile = Tile(target:getPosition())
	local checkTarget = tile:getCreatureCount()
		if checkTarget >= 1 then
			target:getPosition():sendMagicEffect(config.effect)
			target:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player)
			return true
		end
	else
		if not targetPlayer then return true end
		local tile = Tile(targetPlayer:getPosition())
		local checkTarget = tile:getCreatureCount()
		if checkTarget >= 1 then
			targetPlayer:getPosition():sendMagicEffect(config.effect)
			targetPlayer:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player)
			return true
		end
		return true
	end
end

local wStun = Weapon(config.weaponType)
wStun.onUseWeapon = function(player, variant)
	if not player then return true end
	if player:getSkull() == SKULL_BLACK then
		return false
	end
	local chance = math.random()
	local skillChance = (player:getSkillLevel(config.skill) * config.skillChance)
	local target = Monster(variant.number)
	local targetPlayer = Player(variant.number)
	local monsterType = target and target:getType()
		if not targetPlayer:isPlayer() and target:isMonster() and monsterType:bossRaceId() == 1 then return combat:execute(player, variant) end
		if chance <= skillChance then
			addEvent(function()
				if target then
					if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
						combat:execute(player, variant)
						target:getPosition():sendMagicEffect(config.effectHit)
						target:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player)
						return true
					end
					if not target:getCondition(config.condition, config.conditionMuted) then
						passive:execute(player, variant)
						target:getPosition():sendMagicEffect(config.effectHit)
						for i = 1, config.duration do
                            addEvent(function() effectAndSound(player, variant) end, 1000 * (i - 1))
						end
					end
				elseif targetPlayer then
					if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
						combat:execute(player, variant)
						targetPlayer:getPosition():sendMagicEffect(config.effectHit)
						targetPlayer:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player)
						return true
					end
					if not targetPlayer:getCondition(config.condition, config.conditionMuted) then
						passive:execute(player, variant)
						targetPlayer:getPosition():sendMagicEffect(config.effectHit)
						for i = 1, config.duration do
                            addEvent(function() effectAndSound(player, variant) end, 1000 * (i - 1))
                        end
					end
					return true
				end
				player:setStorageValue(config.cooldownStorage, os.time() + config.cooldownPassive)
			end, 500)
		end
	return combat:execute(player, variant)
end

wStun:id(3300) -- ItemId
wStun:vocation("Royal Paladin", true, true) -- Vocation, showDescription, lastVoc
wStun:level(5) -- Level
wStun:register()
