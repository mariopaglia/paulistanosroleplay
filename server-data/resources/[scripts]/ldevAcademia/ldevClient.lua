-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Tunnel )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
scriptAcademia = {}
Tunnel.bindInterface('ldevAcademia',scriptAcademia)
academiaSV = Tunnel.getInterface('ldevAcademia')
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Variáveis )----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local type,inProgress
local seconds = 0
anims = {
    ['Biceps'] = {'amb@world_human_muscle_free_weights@male@barbell@base','base','prop_curl_bar_01',49,28422},
    ['Barra'] = {'amb@prop_human_muscle_chin_ups@male@base','base'},
    ['Flexão'] = {'amb@world_human_push_ups@male@base','base'},
    ['Abdominal'] = {'amb@world_human_sit_ups@male@base','base'},
},
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Malhar )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
        for k,v in pairs(ldevAcademia['Equipamento']) do
            local ped = PlayerPedId()
            local x,y,z,h = ldevAcademia['Equipamento'][k]['Coordenadas'][1],ldevAcademia['Equipamento'][k]['Coordenadas'][2],ldevAcademia['Equipamento'][k]['Coordenadas'][3],ldevAcademia['Equipamento'][k]['Coordenadas'][4]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
            
            if ldevAcademia['Equipamento'][k]['Tipo']  == 'barra' then
                type = 'Barra'
            elseif ldevAcademia['Equipamento'][k]['Tipo']  == 'biceps' then
                type = 'Biceps'
            elseif ldevAcademia['Equipamento'][k]['Tipo']  == 'flexao' then
                type = 'Flexão'
            elseif ldevAcademia['Equipamento'][k]['Tipo']  == 'abdominal' then
                type = 'Abdominal'
            end

            if distance <= 3 and seconds <= 0 then
                cooldown = 5
                DrawMarker(ldevAcademia['Equipamento'][k]['Blip']['id'],x,y,z-0.77,0,0,0,0,0,0,ldevAcademia['Equipamento'][k]['Blip']['scale'][1],ldevAcademia['Equipamento'][k]['Blip']['scale'][2],ldevAcademia['Equipamento'][k]['Blip']['scale'][3],ldevAcademia['Equipamento'][k]['Blip']['color'][1],ldevAcademia['Equipamento'][k]['Blip']['color'][2],ldevAcademia['Equipamento'][k]['Blip']['color'][3],ldevAcademia['Equipamento'][k]['Blip']['color'][4],ldevAcademia['Equipamento'][k]['Blip']['jump'],0,0,ldevAcademia['Equipamento'][k]['Blip']['rotate'])
                Text3D(x,y,z,ldevAcademia['Equipamento'][k]['Texto3D']['font'],ldevAcademia['Equipamento'][k]['Texto3D']['scale'][1],ldevAcademia['Equipamento'][k]['Texto3D']['scale'][2],0,0,0,255,ldevAcademia['Equipamento'][k]['Texto3D']['text'])
                if distance <= 1 and IsControlJustPressed(0,38) and not IsPedRunning(ped) then
                    if academiaSV.returnXP() < 1900 then
                        if type == 'Barra' or type == 'Flexão' or type == 'Abdominal' then
                            inProgress = true
                            seconds = ldevAcademia['Equipamento'][k]['TempoProgresso']
                            SetEntityCoords(ped,x,y,z-1)
                            SetEntityHeading(ped,h)
                            vRP._playAnim(false,{{anims[type][1],anims[type][2]}},true)
                        elseif type == 'Biceps' then
                            inProgress = true
                            seconds = ldevAcademia['Equipamento'][k]['TempoProgresso']
                            vRP.CarregarObjeto(anims[type][1],anims[type][2],anims[type][3],anims[type][4],anims[type][5])
                            vRP._playAnim(false,{{anims[type][1],anims[type][2]}},true)
                        end
                    else
                        TriggerEvent('Notify','aviso',ldevAcademia['Notificações']['Limite'])
                    end
                end
            end
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Contador )-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(1000)
        if seconds > 0 then
            seconds = seconds - 1
            if seconds == 0 then
                inProgress = false
                academiaSV.setXP()
                vRP._stopAnim(false)
                vRP._DeletarObjeto()
                TriggerEvent('cancelando',false)
            end
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Cancelar F6 enquanto no processo )-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local cooldown = 1000
        if inProgress then
            cooldown = 5
            DisableControlAction(0,167,true)
        end
        Wait(cooldown)
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--( Funções )------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Text3D(x,y,z,font,scale,scale2,r,g,b,a,text)
    local screen,x2,y2 = GetScreenCoordFromWorldCoord(x,y,z)
    if screen then
        SetTextFont(font)
        SetTextScale(scale,scale2)
        SetTextColour(r,g,b,a)
        SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
        DrawText(x2,y2)
    end
end