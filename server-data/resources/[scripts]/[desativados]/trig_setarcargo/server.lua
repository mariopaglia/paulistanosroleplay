local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local table = {
    {["Lider"] = "PMFCIV", ["Nome"] = "Policia", ["Grupos"] = {"PMFCIP", "PMFCIIP", "PMFCIIIP", "Retirar Set"}},
    {["Lider"] = "SAMUIV", ["Nome"] = "Hospital", ["Grupos"] = {"SAMUIP", "SAMUIIP", "SAMUIIP", "SAMUIIIP", "Retirar Set"}},
    {["Lider"] = "MidnightL", ["Nome"] = "Midnight", ["Grupos"] = {"Midnight", "Retirar Set"}},
    {["Lider"] = "DriftkingL", ["Nome"] = "Driftking", ["Grupos"] = {"Driftking", "Retirar Set"}},
    {["Lider"] = "MotoclubL", ["Nome"] = "Motoclub", ["Grupos"] = {"Motoclub", "Retirar Set"}},
    {["Lider"] = "VerdesL", ["Nome"] = "Verdes", ["Grupos"] = {"Verdes", "Retirar Set"}},
    {["Lider"] = "VermelhosL", ["Nome"] = "Vermelhos", ["Grupos"] = {"Vermelhos", "Retirar Set"}},
    {["Lider"] = "RoxosL", ["Nome"] = "Roxos", ["Grupos"] = {"Roxos", "Retirar Set"}},
    {["Lider"] = "LaranjasL", ["Nome"] = "Laranjas", ["Grupos"] = {"Laranjas", "Retirar Set"}},
    {["Lider"] = "SinaloaL", ["Nome"] = "Sinaloa", ["Grupos"] = {"Sinaloa", "Retirar Set"}},
    {["Lider"] = "CNL", ["Nome"] = "CN", ["Grupos"] = {"CN", "Retirar Set"}},
    {["Lider"] = "YakuzaL", ["Nome"] = "Yakuza", ["Grupos"] = {"Yakuza", "Retirar Set"}},
    {["Lider"] = "IrmandadeL", ["Nome"] = "Irmandade", ["Grupos"] = {"Irmandade", "Retirar Set"}},
    {["Lider"] = "SalierisL", ["Nome"] = "Salieris", ["Grupos"] = {"Salieris", "Retirar Set"}},
    {["Lider"] = "CamorraL", ["Nome"] = "Camorra", ["Grupos"] = {"Camorra", "Retirar Set"}},
    {["Lider"] = "TriadeL", ["Nome"] = "Triade", ["Grupos"] = {"Triade", "Retirar Set"}},
    {["Lider"] = "FARCL", ["Nome"] = "FARC", ["Grupos"] = {"FARC", "Retirar Set"}},
    {["Lider"] = "SerpentesL", ["Nome"] = "Serpentes", ["Grupos"] = {"Serpentes", "Retirar Set"}},
    {["Lider"] = "SportRaceL", ["Nome"] = "Fenix Customs", ["Grupos"] = {"SportRace", "Retirar Set"}},
    {["Lider"] = "VanillaL", ["Nome"] = "Vanilla Unicorn", ["Grupos"] = {"Vanilla", "Retirar Set"}},
}

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
                                if v == "Retirar Set" then
                                    vRP.addUserGroup(idc, "Civil")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[RETIROU O SET]: " .. idc .. " \n[PARA O GRUPO]: Civil " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_PAINEL")
                                    return TriggerClientEvent("Notify", source, "sucesso", "Você retirou o set do ID <b>" .. idc .. "</b> com sucesso!")
                                end
                                if vRP.request(sourcec, "Você deseja se ingressar ao grupo " .. v .. " ?", 60) then
                                    TriggerClientEvent("Notify", source, "sucesso", "Você adicionou o ID <b>" .. idc .. "</b> no grupo <b>" .. v)
                                    vRP.addUserGroup(idc, v)
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. idc .. " \n[PARA O GRUPO]: " .. v .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_PAINEL")
                                else
                                    TriggerClientEvent("Notify", source, "O convite foi recusado")
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

