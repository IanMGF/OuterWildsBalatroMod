--- STEAMODDED HEADER
--- MOD_NAME: Outer Wilds Ventures
--- MOD_ID: OUTERWILDS
--- MOD_AUTHOR: [AndroT14, IanMGF, Nmora, dino460]
--- MOD_DESCRIPTION: Mod based on the game Outer Wilds

----------------------------------------------
------------MOD CODE -------------------------

function LoadJoker(joker_data)
    local data = {
        atlas = joker_data.key,
        atlas_obj = {
            key = joker_data.key,
            path = joker_data.img_path or "missing.png",
            px = 69,
            py = 93,
        }
    }

    for k, v in pairs(joker_data) do
        data[k] = v
    end

    data["unlocked"] = true

    SMODS.Atlas(data.atlas_obj)
    SMODS.Joker(data)
end

function LoadConsumable(consumable_data)
    local data = {
        atlas = consumable_data.key,
        atlas_obj = {
            key = consumable_data.key,
            path = consumable_data.img_path or "missing.png",
            px = 63,
            py = 93,
        }
    }

    for k, v in pairs(consumable_data) do
        data[k] = v
    end

    data["unlocked"] = true

    SMODS.Atlas(data.atlas_obj)
    SMODS.Consumable(data)
end

function LoadEnhancement(enhanc)
    local data = {
        atlas = enhanc.key,
        atlas_obj = {
            key = enhanc.key,
            path = enhanc.img_path or "missing.png",
            px = 69,
            py = 93,
        }
    }
    for k, v in pairs(enhanc) do
        data[k] = v
    end

    SMODS.Atlas(data.atlas_obj)
    SMODS.Enhancement(data)
end

local mod_path = "" .. SMODS.current_mod.path

local folders = {
    "items/jokers",
    "items/planets",
    "items/editions",
    "items/spectral",
    "items/hands",
    "items/enhancements",
}

for _, folder in ipairs(folders) do
    local files = NFS.getDirectoryItems(mod_path .. folder)
    for _, file in ipairs(files) do
        print("[OUTERWILDS] Loading file " .. file)
        local f, err = SMODS.load_file(folder .. "/" .. file)
        if err then
            error(err)
        end
        f()
    end
end

----------------------------------------------
------------MOD CODE END ---------------------
