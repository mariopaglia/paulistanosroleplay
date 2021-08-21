config = {}



config.webhook = "https://discord.com/api/webhooks/767837335416602666/ZiPVhrTsLX4keVTG0qJ70cIZtFJiKBZ-reyceFXNxFsCvj9BM_X-2Y9t98aFdomqMFsh"

--==========================================================================================================									

									-- || CLIENT CONFIG  || --

--==========================================================================================================									



config.coord_desmanche = {

	[1] = {coord = vector3(883.28,-2101.34,30.77),permi = "motoclub.permissao",nome = 'Motoclub'},

	[2] = {coord = vector3(946.89,-1697.8,30.09),permi = "speed.permissao",nome = 'SPEED'},

	[3] = {coord = vector3(1560.96,3522.07,35.83),permi = "bad.permissao",nome = 'DESMANCHE'},

}



config.drawDesmanche = function(coord)

	DrawMarker(27,coord.x,coord.y,coord.z-0.9,1.0,1.0,1.0,0.0,0,0,4.0,4.0,0.5,255, 100, 0,150,0,0,0,1)

	DrawMarker(36,coord.x,coord.y,coord.z,1.0,1.0,1.0,0.0,0,0,0.8,1.0,0.8,255, 100, 0,150,0,0,0,1)

end

config.remove_peca = 5 --Tempo para remover a parte do carro



config.vender_pecas = vector3(53.58,160.64,104.71) -- LOCAL PARA VENDER AS PEÇAS

config.draw_vender_partes = function(coord)

	DrawMarker(36,coord.x,coord.y,coord.z-0.4,1.0,1.0,1.0,0.0,0,0,0.8,1.0,0.8,255, 100, 0,150,0,0,0,1)

end



-- Não mexer

config.vehList = true

config.modelName = false



--==========================================================================================================									

									-- || SERVER CONFIG  || --

--==========================================================================================================

-- Config para receber dinheiro no desmanche com % pelo valor do veiculo

config.receber_dinheiro_desmanche = true

config.item_dinheiro_sujo = "dinheirosujo"

config.porcentagem_recebida = 0.2



-- Config para receber peças no desmanche

config.receber_pecas = false

config.pecas = {

	[1] = {['item'] = "motor",['valor'] = 2000},

	[2] = {['item'] = "porta",['valor'] = 2000},

	[3] = {['item'] = 'jogodepneu', ['valor'] = 2000},

	[4] = {['item'] = 'amortecedor', ['valor'] = 2000}

}



config.cooldown = 0 --Tempo para poder utilizar novamente o blip de desmanche

config.timeMoto = 6 -- Tempo que demora para desmanchar uma moto





return config