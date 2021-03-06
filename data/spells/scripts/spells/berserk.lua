local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, false)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, fightMode)
	local base = 50
	local baseMagicLevel = player:getMagicLevel()
	if baseMagicLevel > 9 then
		baseMagicLevel = 9
	end
	local variation = 30
	local formula = 2 * baseMagicLevel + (1.5 * player:getLevel())
	local damage = formula * base / 100
	damage = damage * attack / 25
    return -damage - variation, -damage + variation
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end