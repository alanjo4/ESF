-- Basics to set up ESF
ESF = {}
ESF.Loaded = false
ESF.Status = 'not loaded'
ESF.Ready = true
ESF.Components = {}
ESF.TimeoutCounter = 1
ESF.TimeOutQueue = {}
ESF.CancelledTimeouts = {}

local printFlag = print

print = function(...)
  local args = {...}
  local esfDebug = "[^1ESF^7]:"

  for index in pairs(args) do
    esfDebug = esfDebug .. ' ' .. tostring(args[index])
  end

  printFlag(esfDebug)
end
