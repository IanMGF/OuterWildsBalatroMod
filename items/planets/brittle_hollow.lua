LoadConsumable {
    key = "BrittleHollow",
    set = "Planet",
    img_path = "quantummoon.png",
    config = {
        extra = {
            leveling_hands = 1,
            hands_per_round = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.leveling_hands,
                card.ability.extra.hands_per_round,
            }
        }
    end,
    loc_txt = {
        name = "Brittle Hollow",
        text = {
            "Level up {C:attention}#1# random hand(s){}.",
            "After each round, increase",
            "amount of hands by {C:attention}#2#{C:attention}"
        }
    },


    calculate = function(self, card, context)
        if
 			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
        then
            card.ability.extra.leveling_hands = card.ability.extra.leveling_hands + card.ability.extra.hands_per_round

            return {
                message = "+" .. card.ability.extra.hands_per_round,
                colour = G.C.FILTER
            }
        end
    end,

    use = function(self, card, area, copier)
        local hands_to_upgrd = card.ability.extra.leveling_hands

        local used_cons = card or copier
        for _ = 1, hands_to_upgrd do
            local chosen_hand = pseudorandom_element(G.handlist, pseudoseed("randomhand"))

            update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
    			handname = localize(chosen_hand, "poker_hands"),
    			chips = G.GAME.hands[chosen_hand].chips,
    			mult  = G.GAME.hands[chosen_hand].mult,
    			level = G.GAME.hands[chosen_hand].level,
    		})

            level_up_hand(used_cons, chosen_hand, nil, 1)
        end

  		update_hand_text(
       	    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
           	{ mult = 0, chips = 0, handname = "", level = "" }
  		)
	end,

	can_use = function(self, card)
	   return true
	end
}