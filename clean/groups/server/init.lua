function Group:__init()
  if not self.owner then return false, 'owner_not_set' end
  local owner_id = lib.player.checkOnline(self.owner)
  if not owner_id then return false, 'owner_not_online' end

  local playerGroup = Group.getGroupById(self.owner)
  if playerGroup then return false, 'player_already_in_group' end

  if not self.name then return false, 'name_not_set' end
  self.members = {}
  self:addMember({
    id = self.owner,
    role = 'owner',
    metadata = {}, 
    online  = owner_id,
  })

  return true
end
