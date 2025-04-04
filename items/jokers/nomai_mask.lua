LoadJoker {
    key = "NomaiMask",
    img_path = "nomai-mask.png",
    loc_txt = {
        name = "Nomai Mask",
        text = {
            "{C:mult}+#3#{} Mult.",
            "After playing {C:attention}#1# hands{},",
            "Reduce {C:attention}Ante{} by {C:attention}#2#{}"
        }
    },
    rarity = 3,
    blueprint_compat = true,
    config = {
        mult = 4,
        extra = {
            hands_to_loop = 22,
            ante_decrease = 1,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands_to_loop,
                card.ability.extra.ante_decrease,
                card.ability.mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.hands_to_loop = card.ability.extra.hands_to_loop - 1
            if card.ability.extra.hands_to_loop <= 0 then
                card.ability.extra.hands_to_loop = 22

                ease_ante(-card.ability.extra.ante_decrease)

                return {
                    message = "Looped!",
                    colour = G.C.FILTER
                }
            end

            return {
                message = "-" .. card.ability.extra.ante_decrease,
                colour = G.C.FILTER
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.mult,
            }
        end
    end,
}