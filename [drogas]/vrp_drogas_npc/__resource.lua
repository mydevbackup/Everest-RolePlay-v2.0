resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Vendendo dorgas para os gringos! by: kitoide"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "@everest/lib/utils.lua",
  "config.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua",
}