return {
  statusIntervalSeconds = 5, -- how often to check hunger/thirst status to remove health if 0.
  loadingModelsTimeout = 10000, -- Waiting time for ox_lib to load the models before throws an error, for low specs pc

  discord = {
    enabled = true, -- This will enable or disable the built in discord rich presence.

    appId = '', -- This is the Application ID (Replace this with you own)

    largeIcon = { -- To set this up, visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
      icon = 'logo_name', -- Here you will have to put the image name for the 'large' icon.
      text = 'This is a large icon with text', -- Here you can add hover text for the 'large' icon.
    },

    smallIcon = {
      icon = 'logo_name', -- Here you will have to put the image name for the 'small' icon.
      text = 'This is a small icon with text', -- Here you can add hover text for the 'small' icon.
    },

    firstButton = {
      text = 'First Button!',
      link = 'fivem://connect/localhost:30120',
    },

    secondButton = {
      text = 'Second Button!',
      link = 'fivem://connect/localhost:30120',
    }
  },

  --- Only used by QB bridge
  hasKeys = function()
    return true
  end,
}
