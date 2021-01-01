local textos = {
-- AEROPORTO
    {x=-1021.25,y=-2756.62,z=0.80, name = "VOCE PODE IR DE METRO OU PEGA SUA BIKE SUBINDO AS ESCADAS ! [BOM RP]"},
-- PROCESSAMENTO
    {x=75.38,y=-1970.32,z=21.12, name = "Empacotamento de droga"},
    {x=-223.16,y=-1617.56,z=38.05, name = "Empacotamento de droga"},
    {x=371.41,y=-2040.78,z=22.19, name = "Empacotamento de droga"}
}

Citizen.CreateThread(function()
    while true do
        if perto() then
            for k,v in pairs(textos) do
                Text3D(v.x,v.y,v.z-1.9,v.name,1, 0.2, 0.1, 255, 255, 255, 215)
                --DrawMarker(27, v.x,v.y,v.z-0.8, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 0.3001, 150, 2, 2, 255, 0, 0, 0, 0)
            end
        end
        Citizen.Wait(5)
    end
end)

function perto()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for k, v in pairs(textos) do
      local distance = GetDistanceBetweenCoords(v.x, v.y, v.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
      if(distance <= 5) then
        return true
      end
    end
end


function Text3D(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end