local config = require 'config.server'
local logger = require 'modules.logger'
local storage = require 'server.storage.main'
local sharedConfig = require 'config.shared'
local starterItems = sharedConfig.starterItems

---@param license2 string
---@param license? string
local function getAllowedAmountOfCharacters(license2, license)
    return config.characters.playersNumberOfCharacters[license2] or license and config.characters.playersNumberOfCharacters[license] or config.characters.defaultNumberOfCharacters
end


lib.callback.register('qbx_core:server:getCharacters', function(source)
    local license2, license = GetPlayerIdentifierByType(source, sharedConfig.licenseType2), GetPlayerIdentifierByType(source, sharedConfig.licenseType)
    return storage.fetchAllPlayerEntities(license2, license), getAllowedAmountOfCharacters(license2, license)
end)

lib.callback.register('qbx_core:server:getPreviewPedData', function(_, citizenId)
    local ped = storage.fetchPlayerSkin(citizenId)
    if not ped then return end

    return ped.skin, ped.model and joaat(ped.model)
end)

lib.callback.register('qbx_core:server:loadCharacter', function(source, citizenId)
    local success = Login(source, citizenId)
    if not success then return end

    SetPlayerBucket(source, 0)
    logger.log({
        source = 'qbx_core',
        webhook = config.logging.webhook['joinleave'],
        event = 'Loaded',
        color = 'green',
        message = ('**%s** (%s |  ||%s|| | %s | %s | %s) loaded'):format(GetPlayerName(source), GetPlayerIdentifierByType(source, 'discord') or 'undefined', GetPlayerIdentifierByType(source, 'ip') or 'undefined', GetPlayerIdentifierByType(source, 'license2') or GetPlayerIdentifierByType(source, 'license') or 'undefined', citizenId, source)
    })
    lib.print.info(('%s (Citizen ID: %s) has successfully loaded!'):format(GetPlayerName(source), citizenId))
end)

---@param data unknown
---@return table? newData
lib.callback.register('qbx_core:server:createCharacter', function(source, data)
    local newData = {}
    newData.charinfo = data

    local success = Login(source, nil, newData)
    if not success then return end

    giveStarterItems(source)
    if GetResourceState('qbx_spawn') == 'missing' then
        SetPlayerBucket(source, 0)
    end

    lib.print.info(('%s has created a character'):format(GetPlayerName(source)))
    return newData
end)

lib.callback.register('qbx_core:server:setCharBucket', function(source)
    SetPlayerBucket(source, source)
    assert(GetPlayerRoutingBucket(source) == source, 'Multicharacter bucket not set.')
end)

RegisterNetEvent('qbx_core:server:deleteCharacter', function(citizenId)
    local src = source
    DeleteCharacter(src --[[@as number]], citizenId)
    Notify(src, locale('success.character_deleted'), 'success')
end)
