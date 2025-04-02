LoadEnhancement {
    key = "Infested",
    img_path = "infested.png",
    loc_txt = {
        label = "Infested",
        name = "Infested",
        text = {
            "When scoring, 1 in 2 chance of",
            "{C:attention}Infesting{} a random scoring card"
        }
    },

    calculate = function(self, card, context)
        if 	context.main_scoring and context.cardarea == G.play then
            if pseudorandom(pseudoseed("infesting")) < 0.5 then
                local non_infested_scoring = { }
                for _, c in ipairs(context.scoring_hand) do
                    if not SMODS.has_enhancement(c, "m_oute_Infested") then
                        table.insert(non_infested_scoring, c)
                    end
                end

                local infested_card = pseudorandom_element(non_infested_scoring, pseudoseed("infested_card"))
                if not infested_card then
                    return { }
                end

                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
					func = function()
					   infested_card:set_ability(G.P_CENTERS["m_oute_Infested"], nil, true)
						infested_card:juice_up()
						return true
					end,
				}))

                return {
                    message = "Infest!",
                    colour = G.C.FILTER
                }
            end
        end
    end,
    in_pool = function(self, args) return false end
}
