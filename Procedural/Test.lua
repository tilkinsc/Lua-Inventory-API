
--local Inventory = require("Inventory")

local InventoryDebug = require("InventoryDebug")
local InventoryFactory = require("InventoryFactory")
local ItemFactory = require("ItemFactory")

local item = ItemFactory.instance()
	:withStack(0, 10)
	:withMetadata()
	:finalize(2)

local invy = InventoryFactory.instance()
	:as2D(10, 10)
	:finalize()

invy:Fill(nil, item)
InventoryDebug.DebugItems(invy)

local newItem = ItemFactory.instance()
	:withStack(1, 2)
	:withMetadata()
	:withCall(function(self, ...)
		print("Item", self.Id)
	end)
	:finalize(3)
print("amount", newItem.Callable)
newItem:Invoke()
	
invy[{2,1}] = newItem
local twoone = invy[{2,1}]
InventoryDebug.DebugItem(twoone)
InventoryDebug.DebugItems(invy)

local contents = invy:Empty()
print("Contents", contents)
print("== Inventory Cleared ==")
InventoryDebug.DebugItems(invy)

invy:Fill(contents)
InventoryDebug.DebugItems(invy)