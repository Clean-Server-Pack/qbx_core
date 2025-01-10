Group  = {}
Group.__index = Group

function Group:join(data)
  for k,v in pairs(data) do
    self[k] = v
  end
  return self
end 

function Group:leave()
  self = {}
end

RegisterNetEvent('clean_groups:joinGroup', function(data)
  print('Joining group...')
  Group:join(data)
end)

RegisterNetEvent('clean_groups:leaveGroup', function()
  print('Leaving group...')
  Group:leave()
end)