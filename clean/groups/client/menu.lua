function Group:registerMenu()
  local getOptions  = function()
    local options = {}
    if not self.name then 
      table.insert(options, {
        title = 'Create Group', 
        icon = 'users',
        description = 'Create a group',
  
        onSelect = function()
          -- Choose group name
          -- Input menu
          -- callback to see if you can create a group. 
          local input = lib.inputDialog('Group Info', {
            {type = 'input', label = 'Name', description = 'The name of your group!', required = true, min = 4, max = 16},
          }, {
            fromContext = 'groupMenu',
          })
           
        end
      })
    else 
      -- Show members and show option to leave. 
      -- if role == 'owner' show option to disband and kick members.
    end 
    return options
  end 
  lib.registerContext('groupMenu', {
    title = 'Group Menu',
    icon = 'users',
    options = getOptions,
  })
end

RegisterCommand('groups:menu', function()
  lib.openContext('groupMenu')
end)

TriggerEvent('chat:addSuggestion', '/groups:menu', locale('group_menu_chat_suggestion'), {})

lib.onCache('playerLoaded', function(loaded) 
  Group:registerMenu()
  if not loaded then return end
  local myGroup = lib.callback.await('clean_groups:getMyGroup')
  if myGroup then 
    TriggerEvent('clean_groups:joinGroup', myGroup)
  end 
 
end)