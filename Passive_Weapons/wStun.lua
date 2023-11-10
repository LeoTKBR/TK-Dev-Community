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
	duration = 8, -- 20 = 20 segundos - tempo que vai durar o sangramento
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

local wStun = Weapon(config.weaponType)
wStun.onUseWeapon = function(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end
	if not player then return true end
	local chance = math.random()
	local skillChance = (player:getSkillLevel(config.skill) * config.skillChance)
	local target = Monster(variant.number)
	local targetPlayer = player:getTarget(variant.number)
	local monsterType = target:getType()
	local tile = Tile(target:getPosition())
		if monsterType:bossRaceId() == 1 then return combat:execute(player, variant) end
		if chance <= skillChance then
			addEvent(function()
				if target then
					if not target:getCondition(config.condition, config.conditionMuted) then
						target:getPosition():sendMagicEffect(config.effect)
						passive:execute(player, variant)
						for i = 1, config.duration do
                            addEvent(function() local checkTarget = tile:getCreatureCount() if checkTarget >= 1 then target:getPosition():sendMagicEffect(config.effect) return true end end, 1000 * (i - 1))
                            addEvent(function() local checkTarget = tile:getCreatureCount() if checkTarget >= 1 then target:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player) return true end end, 1000 * (i - 1))
						end
					end
				elseif targetPlayer then
					if not targetPlayer:getCondition(config.condition, config.conditionMuted) then
						targetPlayer:getPosition():sendMagicEffect(config.effect)
						passive:execute(player, variant)
						for i = 1, config.duration do
                            addEvent(function() targetPlayer:getPosition():sendMagicEffect(config.effect) end, 1000 * (i - 1))
                            addEvent(function() targetPlayer:getPosition():sendSingleSoundEffect(sound.stun, player:isInGhostMode() and nil or player) end, 1000 * (i - 1))
                        end
					end
					return true
				end
			end, 500)
		end
	return combat:execute(player, variant)	
end

wStun:id(3300) -- ItemId
wStun:vocation("Royal Paladin", true, true) -- Vocation, showDescription, lastVoc
wStun:level(5) -- Level
wStun:register()