LoadConsumable {
    key = "EyeOfTheUniverse",
    set = "Spectral",
    img_path = "the_eye.png",
    loc_txt = {
        name = "Eye of the Universe",
        text = {
            "Destroy {C:attention}all jokers{}.",
            "For each joker destroyed,",
            "create a {C:attention}random joker{}",
            "with rarity {C:attention}1{} level higher.",
        }
    },
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        local rarities = { }

        for i = 1, #G.jokers.cards, 1 do
            local destroyed_joker = G.jokers.cards[i]
            local rarity = destroyed_joker.config.center.rarity
            rarities[i] = rarity

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
                    local new_rarity_poll
                    local is_legendary
                    if rarity == 1 then
                        new_rarity_poll = 0.95
                        is_legendary = false
                    elseif rarity == 2 then
                        new_rarity_poll = 1
                        is_legendary = false
                    elseif rarity >= 3 then
                        new_rarity_poll = 1
                        is_legendary = true
                    end

                    play_sound("generic1", 0.96 + math.random() * 0.08)
                    local new_joker = SMODS.create_card {
                        set = "Joker",
                        area = G.jokers,
                        legendary = is_legendary,
                        rarity = new_rarity_poll
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
