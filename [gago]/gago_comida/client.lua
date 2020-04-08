-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("gago_comida",src)
vSERVER = Tunnel.getInterface("gago_comida")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{ 30.34,-1344.82,29.5 },
	{ 2555.49,386.76,108.63 },
    { 1157.65,-324.14,69.21 },
    { -713.4,-913.69,19.22 },
	{ -52.4,-1753.23,29.43 },
	{ 378.78,327.1,103.57 },
	{ -3243.63,1006.02,12.84 },
	{ 1734.08,6414.44,35.04 },
	{ 543.57,2668.2,42.16 },
	{ 1964.28,3744.67,32.35 },
	{ 2679.21,3285.49,55.25 },
	{ 1702.2,4928.85,42.07 },
	{ -1825.44,789.27,138.23 },
	{ 1397.32,3607.66,34.99 },
	{ -2969.95,391.22,15.05 },
	{ -3042.53,589.54,7.91 }, 
	{ 1137.76,-982.14,46.42 },
	{ 1165.8,2707.2,38.16 },
	{ -1488.97,-380.48,40.17 },
	{ -1223.88,-905.18,12.33 },
	{ 436.54,-979.47,30.69 },
	{ 313.13,-587.9,43.3 },
	{ 135.47,-1031.51,29.36 },
	{ -1194.53,-892.0,14.0 },
	{ 198.21,-996.57,30.1 },
    { 363.36,4840.54,-62.59 },
	{ -1093.63,-833.87,23.04 },
	{ 310.15,-585.75,43.29 },

 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("food",function(source,args)
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(localidades) do
			local distance = Vdist(x,y,z,v[1],v[2],v[3])
			if distance <= 2.0  then
			if vSERVER.checkSearch() then
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
			end
		end
	end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("utilidadesList",function(data,cb)
	local shopitens = vSERVER.utilidadesList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VESTUARIOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("vestuarioList",function(data,cb)
	local shopitens = vSERVER.vestuarioList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDASLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bebidasList",function(data,cb)
	local shopitens = vSERVER.bebidasList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopBuy",function(data)
	if data.index ~= nil then
		vSERVER.shopBuy(data.index,data.price,data.amount)
	end
end)