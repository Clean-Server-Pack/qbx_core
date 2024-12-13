fx_version 'cerulean'
game 'gta5'

name 'qbx_core'
description 'The core resource for the Qbox Framework'
repository 'https://github.com/Qbox-project/qbx_core'
-- version '1.17.2'
version '2.0.0'

clean_lib 'locale'

shared_scripts {
  '@clean_lib/init.lua',
  'modules/lib.lua',
  'shared/locale.lua',
  'shared/functions.lua',
}

client_scripts {
  'client/main.lua',
  'client/groups.lua',
  'client/functions.lua',
  'client/loops.lua',
  'client/events.lua',
  'client/character.lua',
  'client/discord.lua',
  'bridge/qb/client/main.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua',
  'server/groups.lua',
  'server/functions.lua',
  'server/player.lua',
  'server/events.lua',
  'server/commands.lua',
  'server/loops.lua',
  'server/character.lua',
  'bridge/qb/server/main.lua',
}

files {
  'modules/*.lua',
  'shared/gangs.lua',
  'shared/items.lua',
  'shared/jobs.lua',
  'shared/locations.lua',
  'shared/main.lua',
  'shared/vehicles.lua',
  'shared/weapons.lua',
  'bridge/qb/client/functions.lua',
  'bridge/qb/client/drawtext.lua',
  'bridge/qb/client/events.lua',
  'bridge/qb/shared/main.lua',
  'bridge/qb/shared/export-function.lua',
  'config/client.lua',
  'config/shared.lua',
  'locales/*.json'
}

dependencies {
  '/server:7290',
  '/onesync',
  'clean_lib',
  'oxmysql',
}

provide 'qb-core'
lua54 'yes'
use_experimental_fxv2_oal 'yes'