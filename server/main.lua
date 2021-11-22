local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback('core_logohud:getInfo', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	cb(
		xPlayer.PlayerData.job.name,
		xPlayer.PlayerData.money['cash'],
		xPlayer.PlayerData.money['bank'],
		GetNumPlayerIndices() 
	)

end)
