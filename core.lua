NeP.Protected = {
	Version = '1.1.1',
	Unlocker = nil,
	uGeneric = false,
	uAdvanced = false
}

local pT = NeP.Protected
local ranOnce = false

NeP.Listener.register('ADDON_ACTION_FORBIDDEN', function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using faceroll.')
	end
end)

NeP.Interface.CreatePlugin('|cffff0000Unlock! |rV:'..pT.Version, function() 
	pcall(RunMacroText, '/run NeP.Protected.uGeneric = true')
	if not pT.Generic then 
		NeP.Core.Print('Failed to Unlock...')
		NeP.Engine.FaceRoll()
	end
end)

C_Timer.NewTicker(1, (function()
	--local Running = NeP.Config.Read('bStates_MasterToggle', false)
	if not pT.uGeneric and not pT.uAdvanced then
		-- Everthing in here will only run once
		if not ranOnce then
			pcall(RunMacroText, '/run NeP.Protected.uGeneric = true')
			ranOnce = true
		end
		-- Advanced
		if IsHackEnabled then
			pT.Advanced()
			pT.uAdvanced = true
			pT.Unlocker = 'FireHack'
			NeP.Core.Print('Found: Advanced Unlocker')
		-- Generic
		elseif pT.uGeneric then
			pT.Generic()
			pT.Unlocker = 'Generic'
			NeP.Core.Print('Found: Generic Unlocker')
		end
	end
end), nil)