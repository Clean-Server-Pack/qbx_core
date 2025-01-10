function Group:addMember(member)
  self.members[#self.members + 1] = member
  TriggerClientEvent('clean_groups:joinGroup', member.online, {
    id     = self.id,
    name   = self.name,
    role   = member.role,
  })

end

function Group:removeMember(member)
  for k,v in pairs(self.members) do
    if v.id == member.id or v.online and v.online == member then
      table.remove(self.members, k)
      return true
    end
  end
end

function Group:editMemberMetadata(member, metadata)
  local member = self.members[member.id]
  if not member then return false, 'Member not found' end
  local metadata = member.metadata
  for k,v in pairs(metadata) do
    metadata[k] = v
  end
end

exports('editMemberMetadata', function(groupId, member, metadata)
  local group = Group.get(groupId)
  if not group then return end
  group:editMemberMetadata(member, metadata)
end)