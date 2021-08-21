local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bank")

RegisterCommand("inoite", function(source)

	local userID 	= vRP.getUserId(source)
	local player 	= vRP.getUserSource(userID)

	if vRP.hasPermission(userID,"founder.permissao") then
	TriggerClientEvent("cuqui_noiteCrime:iniciar", source)
	-- print("[NOITE DE CRIME] O superadmin ".. GetPlayerName(source) .." deu inicio a expurgacao")
	end

end)

RegisterNetEvent("cuqui_noiteCrime:notificacaoInicio")
AddEventHandler("cuqui_noiteCrime:notificacaoInicio", function(source)
	TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao-crime'></div><div class='texto'> <b>[EXPURGAÇÃO]</b> Crimes são permitidos por <b>60 minutos</b>. <br><b>Que Deus esteja conosco!</div>", layout = "bottomCenter", type = "warning", theme = "metroui", timeout = 30000})
end)

RegisterNetEvent("cuqui_noiteCrime:terminou")
AddEventHandler("cuqui_noiteCrime:terminou", function(source)
	TriggerClientEvent("pNotify:SendNotification", -1, {text = "<div class='imagem-notificacao-crime'></div><div class='texto'> <b>[EXPURGAÇÃO]</b> Os serviços emergenciais poderão trabalhar agora.<br> <b>Obrigado por jogar em Fênix City.</b></div>", layout = "bottomCenter", type = "info", theme = "metroui", timeout = 30000})
end)

RegisterCommand("tnoite", function(source)
	local userID 	= vRP.getUserId(source)
	local player 	= vRP.getUserSource(userID)

	if vRP.hasPermission(userID,"founder.permissao") then
		TriggerClientEvent("cuqui_noiteCrime:terminarExpurgacao", source)
	end
end)


