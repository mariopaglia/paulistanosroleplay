
--Creditos ! RC#0001
--o queridinho de todos kkkkkk fudase


Config = {}

Config.RepeatTimeout = 2000
Config.CallRepeats   = 10
Config.OpenPhone     = "k"
Config.Webhook       = ""
Config.Field         = "files[]"
Config.VerifyItem    = false
Config.ItemPhone     = "cellphone"
Config.CallSystem    = "mumblevoip" --tokovoip | mumblevoip
Config.UseInvoices   = false --true | false
Config.CheckLife     = 101
--Config.IPAddress     = ""

Config.checkItemPhone = function(user_id, item)
    if vRP.getInventoryItemAmount(user_id, item) >= 1 then
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você não possui um celular em sua mochila.")
        return false
    end
end

Config.getBankUser = function(user_id)
    return vRP.getBank(user_id)
end

Config.paymentBank = function(source, user_id, nsource, nuser_id, amount)
    if source and user_id and nsource and nuser_id and amount then

        if parseInt(amount) > 0 then

            local bank = vRP.getBank(user_id)

            if bank >= parseInt(amount) then

                --remove bank
                vRP.paymentBank(user_id, parseInt(amount))

                --add bank
                vRP.addBank(nuser_id, parseInt(amount))

                TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(amount)).." dólares</b> ao passaporte <b>"..parseInt(nuser_id).."</b>.",8000)

                local identity2 = vRP.getUserIdentity(user_id)
                if identity2 ~= nil then
                    TriggerClientEvent("Notify", nsource, "importante","<b>"..identity2.name.." "..identity2.name2.."</b> transferiu <b>$"..vRP.format(parseInt(amount)).." dólares</b> para sua conta.",8000)
                end

                return true
            else
                TriggerClientEvent("Notify",source, "negado","Dinheiro insuficiente.",8000)
                return false
            end
        else
            TriggerClientEvent("Notify",source, "negado","Dinheiro insuficiente.",8000)
            return false
        end
    end
    return false
end

return Config