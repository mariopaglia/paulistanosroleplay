local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local webset = "https://discord.com/api/webhooks/795669087896338462/QeH-0wMplpMq8pfvuxIlA_XmQKyWcERkOzy0c5yBjLidBa7W6EkndzS-ul4s4hq3t33-"

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
    end
end

local table = {
    {["Lider"] = "PMFCIV", ["Nome"] = "Policia", ["Grupos"] = {"PMFCIP", "PMFCIIP", "PMFCIIIP", "Civil"}},
    {["Lider"] = "SAMUIV", ["Nome"] = "Hospital", ["Grupos"] = {"SAMUIP", "SAMUIIP", "SAMUIIP", "SAMUIIIP", "Civil"}},
    {["Lider"] = "MidnightL", ["Nome"] = "Midnight", ["Grupos"] = {"Midnight", "Civil"}},
    {["Lider"] = "DriftkingL", ["Nome"] = "Driftking", ["Grupos"] = {"Driftking", "Civil"}},
    {["Lider"] = "MotoclubL", ["Nome"] = "Motoclub", ["Grupos"] = {"Motoclub", "Civil"}},
    {["Lider"] = "VerdesL", ["Nome"] = "Verdes", ["Grupos"] = {"Verdes", "Civil"}},
    {["Lider"] = "VermelhosL", ["Nome"] = "Vermelhos", ["Grupos"] = {"Vermelhos", "Civil"}},
    {["Lider"] = "RoxosL", ["Nome"] = "Roxos", ["Grupos"] = {"Roxos", "Civil"}},
    {["Lider"] = "LaranjasL", ["Nome"] = "Laranjas", ["Grupos"] = {"Laranjas", "Civil"}},
    {["Lider"] = "SinaloaL", ["Nome"] = "Sinaloa", ["Grupos"] = {"Sinaloa", "Civil"}},
    {["Lider"] = "CNL", ["Nome"] = "CN", ["Grupos"] = {"CN", "Civil"}},
    {["Lider"] = "YakuzaL", ["Nome"] = "Yakuza", ["Grupos"] = {"Yakuza", "Civil"}},
    {["Lider"] = "IrmandadeL", ["Nome"] = "Irmandade", ["Grupos"] = {"Irmandade", "Civil"}},
    {["Lider"] = "SalierisL", ["Nome"] = "Salieris", ["Grupos"] = {"Salieris", "Civil"}},
    {["Lider"] = "CamorraL", ["Nome"] = "Camorra", ["Grupos"] = {"Camorra", "Civil"}},
    {["Lider"] = "TriadeL", ["Nome"] = "Triade", ["Grupos"] = {"Triade", "Civil"}},
    {["Lider"] = "FARCL", ["Nome"] = "FARC", ["Grupos"] = {"FARC", "Civil"}},
    {["Lider"] = "SerpentesL", ["Nome"] = "Serpentes", ["Grupos"] = {"Serpentes", "Civil"}},
}

-- NOME DO GRUPO LIDER, NOME DA CLASSE , GRUPOS QUE ELE PODE SETAR

RegisterCommand("painel", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserId(user_id)
    local identity = vRP.getUserIdentity(user_id)
    for k, v in pairs(table) do
        if vRP.hasGroup(user_id, v.Lider) then
            local menu = {name = v.Nome, css = {top = "75px", header_color = "rgba(42, 112, 190, 0.8)"}}
            for t, v in pairs(v.Grupos) do
                menu[v] = {
                    function(player, choice)
                        local console = vRP.prompt(source, "ID do usuário", "")
                        local sourcec = vRP.getUserSource(parseInt(console))
                        local idc = vRP.getUserId(sourcec)
                        if console ~= "" then
                            if idc then
                                if vRP.hasGroup(idc, v) then
                                    local request = vRP.request(source, 'Deseja remover essa pessoa do grupo: ' .. v, 15)
                                    if request then
                                        vRP.removeUserGroup(idc, v)
                                        TriggerClientEvent("Notify", source, "sucesso", "Você removeu o ID: " .. idc .. " do grupo: <b>" .. v)
                                        SendWebhookMessage(webset, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. idc .. " \n[DO O GRUPO]: " .. v .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")

                                    end
                                else
                                    -- if vRP.request(sourcec,"Você deseja se ingressar ao grupo "..v.. " ?",15) then

                                    TriggerClientEvent("Notify", source, "sucesso", "Você adicionou o ID: <b>" .. idc .. "</b> no grupo: <b>" .. v)
                                    vRP.addUserGroup(idc, v)
                                    SendWebhookMessage(webset, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. idc .. " \n[PARA O GRUPO]: " .. v .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
                                    -- else
                                    --     TriggerClientEvent("Notify",source,"O convite foi recusado")
                                    -- end
                                end
                            else
                                TriggerClientEvent("Notify", source, "negado", "Usuário não está online")
                            end
                        end
                        vRP.closeMenu(source)
                    end,
                    "",
                }
            end
            vRP.openMenu(source, menu)
        end
    end
end)

