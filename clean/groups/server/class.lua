local Groups = {}
Group  = {}
Group.__index = Group

Group.generateId = function()
  local id = ('group_%s'):format(#Groups)
  if Groups[id] then 
    Wait(0)
    return Group.generateId()
  end
  return id
end

Group.register = function(data)
  local self = setmetatable(data, Group)
  self.id    = Group.generateId()
  local can_create, reason = self:__init()
  if not can_create then 
    return false, reason
  end
  Groups[self.id] = self
  return self 
end 

lib.callback.register('clean_groups:registerGroup', function(data)
  return Group.register(data)
end)

Group.getGroupById = function(owner)
  local citizen_id = type(owner) == 'string' and owner or lib.player.identifier(owner)
  if not citizen_id then return false, 'invalid_owner_arg or player not online' end
  for k,v in pairs(Groups) do
    for member, data in pairs(v.members) do
      if member.id == citizen_id then
        return v
      end
    end
  end
  return false, 'group_not_found'
end

lib.callback.register('clean_groups:getMyGroup', function()
  local player = source
  return Group.getGroupById(player)
end)

Group.get = function(id)
  return Groups[id]
end

Group.getAll = function()
  return Groups
end

Group.destroy = function(id)
  Groups[id] = nil
end
