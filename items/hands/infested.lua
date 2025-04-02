SMODS.PokerHand {
    key = "Infested",
    visible = false,
    chips = 110,
    mult = 10,
    l_chips = 22,
    l_mult = 2,
    example = {
        { "S_2", true },
        { "S_2", true },
        { "S_2", true },
        { "S_2", true },
        { "S_2", true },
    },
    loc_txt = {
        name = "Infested Hand",
        text = {
            "Five {C:attention}Infested{} cards."
        }
    },
    evaluate = function(parts, hand)
        if (#hand < 5) then
            return { }
        end

        local infested_cards = 0
        for _, card in ipairs(hand) do
            if SMODS.has_enhancement(card, "m_oute_Infested") then
                infested_cards = infested_cards + 1
            end
        end

        if infested_cards >= 5 then
            return { hand }
        else
            return { }
        end
    end
}