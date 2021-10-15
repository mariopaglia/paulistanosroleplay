-------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÕES SERVER SIDE
-------------------------------------------------------------------------------------------------------------------------
CONF_ = {}

-------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-------------------------------------------------------------------------------------------------------------------------
CONF_.webhook = "https://discord.com/api/webhooks/885643958481457193/a1VX1spw9d0VxbqtWYZOtAoX0TpmMxJ_5fWyPPKTYoOao8cdDhSovcGCeV4OC1Y7j1kH"

-------------------------------------------------------------------------------------------------------------------------
-- FEED DE MORTES IN GAME
-------------------------------------------------------------------------------------------------------------------------
CONF_.notify = "notify" -- **false** desativa, **chat** receberá via chat, **notify** via notify em cima do mini-mapa e **notifykill** via notify com imagem
CONF_.feedOnOff = "founder.permissao" -- permissão para ativar ou desativar as notificações in-game, exemplo abaixo:
-- utilizando o comando in-game "/feedmortes chat" altera para modo chat
-- utilizando o comando in-game "/feedmortes notify" altera para modo notificação em cima do mini-mapa
-- utilizando o comando in-game "/feedmortes notifykill" altera para modo notificação com imagem
-- utilizando o comando in-game "/feedmortes" desativa o feed
CONF_.permissao = "kick.permissao" -- permissão para receber as notificações in-game

-------------------------------------------------------------------------------------------------------------------------
-- NATION PAINTBALL
-------------------------------------------------------------------------------------------------------------------------
CONF_.nationpaintball = false -- **true** desativa as logs de mortes que ocorrerem dentro do nation_paintball, **false** receberá todas as logs

-------------------------------------------------------------------------------------------------------------------------
-- DIMENSÕES
-------------------------------------------------------------------------------------------------------------------------
CONF_.dimensions = true -- **true** desativa as logs de mortes que ocorrerem dentro de outras dimensões, **false** receberá todas as logs

-------------------------------------------------------------------------------------------------------------------------
-- BASE CREATIVE
-------------------------------------------------------------------------------------------------------------------------
CONF_.creative = false -- Caso a sua base seja Creative (tipo Bahamas) deixar true

-------------------------------------------------------------------------------------------------------------------------
-- SAFEZONES
-------------------------------------------------------------------------------------------------------------------------
CONF_.safezone = true  -- Para habilitar a detecção de morte em safezone alterar para TRUE

CONF_.safes = {
	{ ['x'] = 194.02, ['y'] = -933.99, ['z'] = 32.98, ['range'] = 90, ['nome'] = "Praça" },
	{ ['x'] = 46.72, ['y'] = -867.54, ['z'] = 30.51, ['range'] = 60, ['nome'] = "Garagem 1" },
	{ ['x'] = 341.42, ['y'] = 2626.26, ['z'] = 44.51, ['range'] = 60, ['nome'] = "Garagem 2" },
	{ ['x'] = -774.7, ['y'] = 5578.64, ['z'] = 33.49, ['range'] = 60, ['nome'] = "Garagem 3" },
	{ ['x'] = 280.76, ['y'] = -335.12, ['z'] = 44.92, ['range'] = 60, ['nome'] = "Garagem 4" },
	{ ['x'] = -339.16, ['y'] = 283.65, ['z'] = 85.52, ['range'] = 60, ['nome'] = "Garagem 5" },
	{ ['x'] = -1187.16, ['y'] = -1486.75, ['z'] = 4.38, ['range'] = 60, ['nome'] = "Garagem 6" },
	{ ['x'] = -89.65, ['y'] = -2009.03, ['z'] = 18.02, ['range'] = 60, ['nome'] = "Garagem 7" },
	{ ['x'] = 228.67, ['y'] = -783.04, ['z'] = 30.72, ['range'] = 60, ['nome'] = "Garagem 8" },
	{ ['x'] = -332.29, ['y'] = -915.8, ['z'] = 31.09, ['range'] = 60, ['nome'] = "Garagem 9" },
	{ ['x'] = 1751.56, ['y'] = 3290.89, ['z'] = 41.11, ['range'] = 30, ['nome'] = "Garagem 10" },
	{ ['x'] = 62.63, ['y'] = 22.1, ['z'] = 69.51, ['range'] = 20, ['nome'] = "Garagem 11" },
	{ ['x'] = 370.4, ['y'] = 277.38, ['z'] = 103.18, ['range'] = 25, ['nome'] = "Garagem 12" },
	{ ['x'] = 613.21, ['y'] = 111.26, ['z'] = 92.84, ['range'] = 40, ['nome'] = "Garagem 13" },
	{ ['x'] = 452.26, ['y'] = -997.53, ['z'] = 43.7, ['range'] = 55, ['nome'] = "Delegacia" },
	{ ['x'] = 822.25, ['y'] = -956.21, ['z'] = 26.01, ['range'] = 40, ['nome'] = "Mecanica" },
	{ ['x'] = -41.57, ['y'] = -1097.99, ['z'] = 26.43, ['range'] = 35, ['nome'] = "Concessionaria" },
}

-------------------------------------------------------------------------------------------------------------------------
-- PERSONALIZAÇÃO DA WEBHOOK
-------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS DAS LOGS:
-- {idVitima}			-- ID da vitima
-- {vitimaNome}			-- Nome da vitima
-- {vitimaSobrenome}	-- Sobrenome da vitima
-- {cdsVitima}			-- Coordenada da vitima
--
-- {idAssasino}			-- ID do assasino
-- {assasinoNome}		-- Nome do assasino
-- {assasinoSobrenome}  -- Sobrenome do assasino
-- {cdsAssasino}        -- Coordenada do assasino
--
-- {tipoMorte}          -- Descrição do tipo da morte
-- {arma}               -- Arma utilizada
-- {safezone}           -- Se ocorreu em safezone ou não
-- {veiculo}            -- Veiculo utilizado
-- {horaMorte}          -- Hora da morte (in-game)

CONF_.LogMorreu = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} \n[{tipoMorte}] \n[CAUSA DA MORTE]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL]: {cdsVitima}"
CONF_.LogMatou = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} \n[{tipoMorte}] \n[ID]: {idAssasino} {assasinoNome} {assasinoSobrenome} \n[UTILIZANDO]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL ASSASINO]: {cdsAssasino} \n[LOCAL VITIMA]: {cdsVitima}"
CONF_.LogSuicidou = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} [SE SUICIDOU] \n[CAUSA DA MORTE]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL]: {cdsVitima}"

return CONF_