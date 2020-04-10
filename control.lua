local function get_opened_item_by_current_player(player_index)
    local opened_item = game.players[player_index].opened
    return opened_item
end

local function get_first_item_name_and_position(chest)
    if chest ~= nil then
        local chest_inventory = chest.get_inventory(defines.inventory.chest)
        if chest_inventory ~= nil then
            local inventory_contents = chest_inventory.get_contents()
            if inventory_contents ~= nil then
                n,t = pairs(inventory_contents)

                local item_name, item_amount = n(t)
                return item_name, chest.position
            end
        end
    end
end

local function build_resource_tag(item_name, chest_position)
    if item_name ~= nil and chest_position ~= nil then
        local item_icon = "[img=item/" .. item_name .. "]"
        local item_locale_name = item_name

        local tag = {
                position = chest_position,
                text = item_icon
        }
        return tag
    end
end

local function get_offset_chest_position(original_position)
    if original_position ~= nil then
        original_position['x'] = original_position['x'] - 5
        return original_position
    end
end

local function add_chart_tag(player_index, tag)
    if tag ~= nil then
        game.players[player_index].force.add_chart_tag(
                game.players[player_index].surface,
                tag)
    end
end

local function create_resource_tag(event, tag)
    local opened_item = get_opened_item_by_current_player(event.player_index)
    if opened_item ~= nil then
        print(opened_item.name)
    end
    local first_chest_item_name, original_chest_position = get_first_item_name_and_position(opened_item)
    local offset_chest_position = get_offset_chest_position(original_chest_position)
    local resource_tag = build_resource_tag(first_chest_item_name, offset_chest_position)

    add_chart_tag(event.player_index, resource_tag)
end

script.on_event("create-resource-tag", create_resource_tag)