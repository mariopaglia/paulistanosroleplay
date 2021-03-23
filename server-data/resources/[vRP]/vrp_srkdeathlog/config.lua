config = {}

-- LINK DA SUA WEBHOOK

config.webhook = "https://discord.com/api/webhooks/819948406973005834/0tOVkPNvd0_1XJt9UGdGcdjBaoBIzjHUPyajhA7ywoeIbNif5AbJm9rKnRVrcwkvL8hA"

-- PERMISSÃO QUE RECEBE OS REPORTS

config.staffperm = "admin.permissao"

-- REPORT DE KILLS COM VEICULO NO CHAT

config.vdmchatreport = true

config.vdmchatmessagecolor = {
    ['red'] = 255,
    ['green'] = 100,
    ['blue'] = 0
}

-- REPORT DE KILLS COM ARMAS NO CHAT

config.gunchatreport = true

config.gunchatmessagecolor = {
    ['red'] = 255,
    ['green'] = 100,
    ['blue'] = 0
}

-- REPORT DE MORTES ALEATORIAS

config.randomdeathreport = true

config.randomchatmessagecolor = {
    ['red'] = 255,
    ['green'] = 100,
    ['blue'] = 0
}

-- SISTEMA DE DIAGNOSTICO DE MORTE

config.diag = true

config.diagpermission = 'paramedico.permissao'
config.diagpermission2 = 'admin.permissao'

-- COLOCAR O TRIGGER A CIMA PARA QUANDO O PLAYER RENASCER NO AEROPORTO O REGISTRO DE MORTE DELE SER EXCLUIDO DO /diag
