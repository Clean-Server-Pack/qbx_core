QBX = {}
QBX.PlayerData = {}
QBX.Shared = require 'shared.main'
QBX.IsLoggedIn = false

---@return table<string, Vehicle>
function GetVehiclesByName()
  return QBX.Shared.Vehicles
end

exports('GetVehiclesByName', GetVehiclesByName)

---@return table<number, Vehicle>
function GetVehiclesByHash()
  return QBX.Shared.VehicleHashes
end

exports('GetVehiclesByHash', GetVehiclesByHash)

---@return table<string, Vehicle[]>
function GetVehiclesByCategory()
  return qbx.table.mapBySubfield(QBX.Shared.Vehicles, 'category')
end

exports('GetVehiclesByCategory', GetVehiclesByCategory)

---@return table<number, Weapon>
function GetWeapons()
  return QBX.Shared.Weapons
end

exports('GetWeapons', GetWeapons)

---@deprecated
---@return table<string, vector4>
function GetLocations()
  return QBX.Shared.Locations
end

exports('GetLocations', GetLocations)

AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
  QBX.IsLoggedIn = value
end)

lib.callback.register('qbx_core:client:setHealth', function(health)
  SetEntityHealth(cache.ped, health)
end)

CreateThread(function()
  for _, v in pairs(GetVehiclesByName()) do
    if v.model and v.name then
      local gameName = GetDisplayNameFromVehicleModel(v.model)
      if gameName and gameName ~= 'CARNOTFOUND' then
        AddTextEntryByHash(joaat(gameName), v.name)
      end
    end
	end
end)
