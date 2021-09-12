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
CONF_.feedOnOff = "admin.permissao" -- permissão para ativar ou desativar as notificações in-game, exemplo abaixo:
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
	{ ['x'] = 196.15780639648, ['y'] = -932.81182861328, ['z'] = 30.687440872192, ['range'] = 92, ['nome'] = "Praça" },
	{ ['x'] = 230.94702148438, ['y'] = -776.00927734375, ['z'] = 30.259489059448, ['range'] = 40, ['nome'] = "Garagem 4" },
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