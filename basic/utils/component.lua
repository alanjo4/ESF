-- Basics to set up ESF
ESF = {}
ESF.loaded = false
ESF.ready = true
ESF.components = {}
ESF.timeoutCounter = 0
ESF.timeouts = {}
ESF.cancelledTimeouts = {}

local printFlag = print

print = function(...)
  local args = {...}
  local esfDebug = "[^1ESF^7]:"

  for index in pairs(args) do
    esfDebug = esfDebug .. ' ' .. tostring(args[index])
  end

  printFlag(esfDebug)
end

local tableIncludes = function(obj, name)
  for index in pairs(obj) do
    if(obj[index] == name) then
      return index
    end
  end
  return -1
end

typeof = function (var)
  local _type = type(var);
  if(_type ~= "table" and _type ~= "userdata") then
      return _type;
  end
  local _meta = getmetatable(var);
  if(_meta ~= nil and _meta._NAME ~= nil) then
      return _meta._NAME;
  else
      return _type;
  end
end

--Timers
ESF.setTimeout = function(cb, ms)
  local identifier = (ESF.timeoutCounter + 1 < 65635) and (ESF.timeoutCounter + 1) or 1
  ESF.timeouts[identifier] = {cb, isRunning}
  print((ESF.timeoutCounter + 1 < 65635) and (ESF.timeoutCounter + 1) or 1)

  local timer = SetTimeout
  timer(ms, function()
    timer = nil
    if ESF.cancelledTimeouts[identifier] then
      ESF.cancelledTimeouts[identifier] = nil
    else
      cb()
    end
  end)
  ESF.timeoutCounter = identifier
  ESF.timeouts[identifier].isRunning = function ()
    return timer ~= nil
  end

  print(ESF.timeouts[identifier].isRunning())

  return identifier
end

ESF.setInterval = function(cb, ms)
  local exec
  local identifier = (ESF.timeoutCounter + 1 < 65635) and (ESF.timeoutCounter + 1) or 1

  exec = function()
    ESF.setTimeout(function()
      if ESF.cancelledTimeouts[identifier] then
        ESF.cancelledTimeouts[identifier]= nil
      else
        cb()
        exec()
      end
    end, ms)
  end

  ESF.timeoutCounter = identifier

  exec()

  return identifier
end

ESF.clearTimeout = function(id)
  ESF.cancelledTimeouts[id] = true
end

ESF.clearInterval = function(id)
  ESF.cancelledTimeouts[id] = true
end

--Configuration evaluation

ESF.getConfig = function()

end

ESF.checkFile = function()

end

ESF.setInterval(function()
  print("funciona")
end, 2000)

print(ESF.timeouts[2].isRunning())

SetTimeout(3000, function()
  print(ESF.timeouts[2].isRunning())
end)
