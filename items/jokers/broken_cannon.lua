LoadJoker {
    key = "BrokenCannon",
    loc_txt = {
        name = "Broken Cannon",
        text = {
            "{C:chips}+#1#{} Chip.",
            "Yes. It's as useless",
            "as it seems."
        }
    },
    rarity = 3,
    blueprint_compat = true,
    config = {
        chips = 1,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.chips,
            }
        end
    end,
    in_pool = function (self, args)
        return false
    end
}