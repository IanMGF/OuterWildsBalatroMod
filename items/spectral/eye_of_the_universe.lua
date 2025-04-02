LoadConsumable {
    key = "EyeOfTheUniverse",
    set = "Spectral",
    img_path = "the_eye.png",
    loc_txt = {
        name = "Eye of the Universe",
        text = {
            "Destroy {C:attention}all jokers{}.",
            "For each joker destroyed,",
            "create a {C:attention}negative random joker{}",
            "with rarity {C:attention}1{} level higher.",
        }
    },
    can_use = function(self, card)
        return (#G.jokers.cards > 0)
    end,

    use = function(self, card, area, copier)
        local rarities = { }
        local rarity_map = {
            { poll_value = 0.7, is_legendary = false },
            { poll_value = 0.95, is_legendary = false },
            { poll_value = 1, is_legendary = false },
            { poll_value = 1, is_legendary = true },
        }

        for i = 1, #G.jokers.cards, 1 do
            local destroyed_joker = G.jokers.cards[i]
            rarities[i] = destroyed_joker.config.center.rarity

            G.E_MANAGER:add_event(Event({
                trigger = "before",
                func = function()
                    G.GAME.joker_buffer = 0
                    destroyed_joker:start_dissolve({ HEX("4a54df") }, nil, 2.23)
                    play_sound("whoosh", 0.96 + math.random() * 0.08)
                    return true
                end,
            }))
        end

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 2.23,
			func = function()
    			for i = 1, #rarities, 1 do
                    local rarity = rarities[i]
                    local new_rarity = math.min(rarity + 1, 4)
                    local new_rarity_data = rarity_map[new_rarity]

                    play_sound("generic1", 0.96 + math.random() * 0.08)
                    local new_joker = SMODS.create_card {
                        set = "Joker",
                        area = G.jokers,
                        legendary = new_rarity_data.is_legendary,
                        rarity = new_rarity_data.poll_value,
                        edition = { negative = true }
                    }

                    new_joker:start_materialize({ HEX("4a54df") }, nil, 2.23)
                    new_joker:add_to_deck()
                    G.jokers:emplace(new_joker)
                end
				return true
			end,
		}))
    end
}
