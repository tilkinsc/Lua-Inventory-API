
local InventoryDebug = require("InventoryDebug")
local InventoryFactory = require("InventoryFactory")
--local InventorySave = require("InventorySave")
local ItemFactory = require("ItemFactory")
local Inventory = require("InventoryUtil")
local Item = require("ItemUtil")


local item = ItemFactory.instance()
	:withStack(0, 10)
	:withMetadata()
	:finalize(2)

local invy = InventoryFactory.instance()
	:as2D(10, 10)
	:finalize()

Inventory.Fill2D(invy, item)
InventoryDebug.DebugItems(invy)

local newItem = ItemFactory.instance()
	:withStack(1, 2)
	:withMetadata()
	:withCall(function(self, ...)
		print("Item", self.Id)
	end)
	:finalize(3)
print("amount", newItem.Callable)
Item.Invoke(newItem)
	
invy[{2,1}] = newItem
local twoone = invy[{2,1}]
InventoryDebug.DebugItem(twoone)
InventoryDebug.DebugItems(invy)

local contents = Inventory.Empty(invy)
print("Contents", contents)
print("== Inventory Cleared ==")
InventoryDebug.DebugItems(invy)

Inventory.Fill2D(invy, contents)
InventoryDebug.DebugItems(invy)

-- InventorySave.Save(1131 .. "u3" .. "_Inventory", "Contents", invy)
-- Inventory.Empty(invy)
-- InventoryDebug.DebugItems(invy)
-- local inventory_data = InventorySave.Load(1131 .. "u3" .. "_Inventory", "Contents")
-- Inventory.Fill2D(invy, inventory_data)
-- InventoryDebug.DebugItems(invy)
