local config = {
	combat = COMBAT_PHYSICALDAMAGE, -- combatType do hit principal
	passive = COMBAT_PHYSICALDAMAGE,
	condition = CONDITION_BLEEDING, -- condition que vai ser aplicada
	weaponType = WEAPON_SWORD, -- weapon Type
	skill = SKILL_FIST, -- Skill chance para ativar a passiva
	skillChance = 0.005, -- 0.005 = 0.5% / skill = 100 - skillChance = 0.5 = 50%
	duration = 15, -- 0.5 = 500 milleseconds
	cooldownPassive = 30, -- 10 = 10 seconds
	cooldownStorage = 69995,
	effect = CONST_ME_EXPLOSIONAREA, -- efeito ao teleportar
	periodDamage = 100, -- dano por segundo de sangramento
	interval = 1, -- 1 = 1 segundo - intervalo de cada dano de sangramento
	durationDamage = 10, -- 10 = 10 segundos - tempo que vai durar o dano extra que o alvo vai receber
	extraDamage = 150, -- 150 = 50% extra damage
}

local sound = {
	weapon = SOUND_EFFECT_TYPE_MELEE_ATK_SWORD,
	cast = SOUND_EFFECT_TYPE_ITEM_MOVE_METALIC,
	bleeding = SOUND_EFFECT_TYPE_MONSTER_SPELL_SINGLE_TARGET_BLEEDING,
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
condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -config.periodDamage)
condition:setParameter(CONDITION_PARAM_TICKS, config.duration*1000)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, config.interval*1000)
condition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)
passive:addCondition(condition)

local extraDamage = Condition(CONDITION_ATTRIBUTES)
extraDamage:setParameter(CONDITION_PARAM_SUBID, 9999)
extraDamage:setParameter(CONDITION_PARAM_TICKS, config.durationDamage*1000)
extraDamage:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, config.extraDamage)
passive:addCondition(extraDamage)

local wBleeding = Weapon(config.weaponType)
wBleeding.onUseWeapon = function(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end
	if not player then return true end
	local chance = math.random()
	local skillChance = (player:getSkillLevel(config.skill) * config.skillChance)
	local target = Monster(variant.number)
	local targetPlayer = player:getTarget(variant.number)
	local monsterType = target:getType()
		if target:isMonster() and monsterType:bossRaceId() == 1 then return combat:execute(player, variant) end
		if chance <= skillChance then
			addEvent(function()
				if target then
					if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
						combat:execute(player, variant)
						player:getPosition():sendSingleSoundEffect(sound.bleeding, player:isInGhostMode() and nil or player)
						return true
					end
					if not target:getCondition(config.condition) then
						local position = target:getPosition()
						passive:execute(player, variant)
						target:getPosition():sendMagicEffect(config.effect)
						target:getPosition():sendSingleSoundEffect(sound.bleeding, player:isInGhostMode() and nil or player)
					end
					elseif targetPlayer then
						if player:getStorageValue(config.cooldownStorage) - os.time() > 0 then
							combat:execute(player, variant)
							player:getPosition():sendSingleSoundEffect(sound.bleeding, player:isInGhostMode() and nil or player)
							return true
						end
						if not targetPlayer:getCondition(config.condition) then
							local position = targetPlayer:getPosition()
							passive:execute(player, variant)
							targetPlayer:getPosition():sendMagicEffect(config.effect)
							targetPlayer:getPosition():sendSingleSoundEffect(sound.bleeding, player:isInGhostMode() and nil or player)
						end
					return true
				end
				player:setStorageValue(config.cooldownStorage, os.time() + config.cooldownPassive)
			end, 500)
		end
	return combat:execute(player, variant)	
end

wBleeding:id(3300) -- ItemId
wBleeding:vocation("Royal Paladin", true, true) -- Vocation, showDescription, lastVoc
wBleeding:level(5) -- Level
wBleeding:register()
