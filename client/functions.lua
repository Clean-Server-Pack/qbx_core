
---Text box popup for player which dissappears after a set time.
---@param text table|string text of the notification
---@param notifyType? NotificationType informs default styling. Defaults to 'inform'
---@param duration? integer milliseconds notification will remain on screen. Defaults to 5000
---@param subTitle? string extra text under the title
---@param notifyPosition? NotificationPosition
---@param notifyStyle? table Custom styling. Please refer too https://overextended.dev/ox_lib/Modules/Interface/Client/notify#libnotify
---@param notifyIcon? string Font Awesome 6 icon name
---@param notifyIconColor? string Custom color for the icon chosen before
function Notify(text, notifyType, duration, subTitle, notifyPosition, notifyStyle, notifyIcon, notifyIconColor)
    local title, description
    if type(text) == 'table' then
        title = text.text or 'Placeholder'
        description = text.caption or nil
    elseif subTitle then
        title = text
        description = subTitle
    else
        description = text
    end
    local position = notifyPosition or 'top-right'

    lib.notify({
        id = title,
        title = title,
        description = description,
        duration = duration,
        type = notifyType,
        position = position,
        style = notifyStyle,
        icon = notifyIcon,
        iconColor = notifyIconColor
    })
end

exports('Notify', Notify)

---@return PlayerData? playerData
function GetPlayerData()
    return QBX.PlayerData
end

exports('GetPlayerData', GetPlayerData)

---@param filter string | string[] | table<string, number>
---@return boolean
function HasPrimaryGroup(filter)
    return HasPlayerGotGroup(filter, QBX.PlayerData, true)
end

exports('HasPrimaryGroup', HasPrimaryGroup)

---@param filter string | string[] | table<string, number>
---@return boolean
function HasGroup(filter)
    return HasPlayerGotGroup(filter, QBX.PlayerData)
end

exports('HasGroup', HasGroup)

---@return table<string, integer>
function GetGroups()
    local playerData = QBX.PlayerData
    return GetPlayerGroups(playerData)
end

exports('GetGroups', GetGroups)


RegisterNetEvent('qbx_core:revivePlayer', function()
  local playerState = LocalPlayer.state
  local pos = GetEntityCoords(cache.ped, true)
  NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(cache.ped), true, false)
  playerState:set('isDead', false, true)
  SetEntityInvincible(cache.ped, false)
  SetEntityMaxHealth(cache.ped, 200)
  SetEntityHealth(cache.ped, 200)
  ClearPedBloodDamage(cache.ped)
  SetPlayerSprint(cache.playerId, true)
  ResetPedMovementClipset(cache.ped, 0.0)
  TriggerServerEvent('hud:server:RelieveStress', 100)
  lib.notify({
    title = 'Revived',
    description = 'You have been revived.',
    type = 'inform',
  })
  LocalPlayer.state.invBusy = false
end)

