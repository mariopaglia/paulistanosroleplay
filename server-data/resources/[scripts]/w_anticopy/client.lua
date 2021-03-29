local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("w_anticopy",src)
Proxy.addInterface("w_anticopy",src)
acClient = Tunnel.getInterface("w_anticopy")

RegisterNUICallback("loadNuis", function(data, cb)
	acClient.pegaTrouxa()
end)


