
-- implementation of the observable pattern as described on:
--  - https://en.wikipedia.org/wiki/Observer_pattern

-- upvalue for performance
local TableInsert = table.insert

-- setup for a basic meta table
---@class Observer
local ObservableMeta = {}
ObservableMeta.__index = ObservableMeta

--- Adds an observer that is updated when the value is subject is set.
---@param callback fun(value: any) A function that receives the value as its first argument.
function ObservableMeta:AddObserver(callback)
    TableInsert(self.Listeners, callback)
end

--- Sets the value of the subject and notifies all observers with the updated value.
function ObservableMeta:Set(value)
    for k, callback in self.Listeners do
        callback(value)
    end
end

--- Constructs an observable as described by the observable pattern
function Create()
    local observable = {
        Listeners = {},
    }
    setmetatable(observable, ObservableMeta)

    return observable
end