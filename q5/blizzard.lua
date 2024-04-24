local BLIZZARD_ANIMATION = {
	{
		{0, 0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 3, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 1, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 0, 0, 3, 0, 0, 0, 1},
		{0, 1, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 1, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 1, 0, 1, 0},
		{0, 0, 0, 1, 3, 1, 0, 1, 0},
		{0, 0, 1, 0, 1, 0, 1, 1, 0},
		{0, 0, 0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 1, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 1, 0, 0, 0, 1, 0, 0},
		{0, 0, 1, 0, 0, 0, 1, 0, 0},
		{0, 0, 1, 0, 3, 0, 1, 0, 0},
		{0, 0, 0, 1, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 1, 0, 0, 0},
		{0, 0, 0, 0, 0, 1, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0}
	},
}

local blizzards = {}
local animationLoop = 3
for i = 1, animationLoop * #BLIZZARD_ANIMATION do
	function onGetFormulaValues(player, level, magicLevel)
		local min = (level / 5) + (magicLevel * 5.5) + 25
		local max = (level / 5) + (magicLevel * 11) + 50
		return -min, -max
	end

	blizzards[i] = Combat()
	blizzards[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	blizzards[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	blizzards[i]:setArea(createCombatArea(BLIZZARD_ANIMATION[i % #BLIZZARD_ANIMATION + 1]))
	blizzards[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues") 
end

function castPartialSpell(combat, creature, variant)
	combat:execute(creature, variant)
end

local spell = Spell("instant")
local animationOffset = 300
function spell.onCastSpell(creature, variant)
	for i = 1, #blizzards do
		addEvent(castPartialSpell, animationOffset * (i - 1), blizzards[i], creature:getId(), variant)
	end
	return true
end

spell:name("Blizzard")
spell:words("exevo mas frigo")
spell:group("attack")
spell:vocation("sorcerer", "master sorcerer")
spell:id(255)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:level(1)
spell:mana(1)
spell:isSelfTarget(true)
spell:isPremium(false)
spell:register()