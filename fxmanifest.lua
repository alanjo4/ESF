

local esf_config = {
  loadingcreen = false,
  hud = false
}

fx_version      'adamant'
game            'gta5'
description     'ESF'
version         '2.0.1'
-- ui_page         'hud/index.html'
-- ui_page_preload 'yes'

dependencies {
  'spawnmanager',
  'mysql-async',
  'async',
  'cron',
  'skinchanger'
}

files {
}

server_scripts {
  'basic/utils/component.lua'
}

client_scripts {
}

if esf_config.loadingcreen then

end

if esf_config.hud then

end
