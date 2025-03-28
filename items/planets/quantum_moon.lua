LoadConsumable {
    key = "QuantumMoon",
    set = "Planet",
    img_path = "quantummoon.png",
    loc_txt = {
        name = "Quantum Moon",
        text = {
            "Upgrade {C:attention}a random hand{} by {C:attention}3 levels{C:attention}"
        }
    },
    cost = 3,
    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        local random_hand_name = pseudorandom_element(G.handlist, pseudoseed("randomhand"))
        local random_hand = G.GAME.hands[random_hand_name]

        local used_consumable = copier or card
        update_hand_text(
            { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize(random_hand_name, "poker_hands"), chips = random_hand.chips, mult = random_hand.mult, level =
            random_hand.level })

        level_up_hand(used_consumable, random_hand_name, false, 3)

        update_hand_text(
            { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end,
}
