FenixConf = {}

FenixConf.Webhook = "https://discord.com/api/webhooks/887146643105935400/HA2xBArN3t-kAGQ5u-tKebD5kWZ9OG8w4DoL_fJ1FtkbCqyKnI6cZP5a7mnfTIdPtLso" -- Adicionar aqui o link do seu Webhook da sala do Discord

FenixConf.Permissao = "policia.permissao" -- Alterar aqui a permissão da policia do seu servidor para receber notificação in-game 

FenixConf.Notificacao = "notify" -- Escolha o tipo de notificação: "chat" para notificar através de Chat | "notify" para notificar através de "Notify" | Para desligar deixe em branco

FenixConf.Blip = false -- Configure aqui para habilitar o blip abaixo do texto 3D - Ligado: true | Desligado: false

FenixConf.Coordenadas = { -- Defina abaixo as coordenadas onde estarão seus blips de boletim
    { ['x'] = 1024.44, ['y'] = 94.31, ['z'] = 110.23 },
    -- { ['x'] = 1020.36, ['y'] = 94.29, ['z'] = 110.23 },
    -- { ['x'] = 1020.36, ['y'] = 94.29, ['z'] = 110.23 },
}

return FenixConf