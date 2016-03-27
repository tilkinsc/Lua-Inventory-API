
-- Imports
local InventoryDebug = require("InventoryDebug")
local InventoryFactory = require("InventoryFactory")
--local InventorySave = require("InventorySave")
local ItemFactory = require("ItemFactory")
local Inventory = require("InventoryUtil")
local Item = require("ItemUtil")

-- Creating a single stack item with metadata
local item = ItemFactory.instance()
	:withStack(0, 10)
	:withMetadata()
	:finalize(2)

-- Creating a single 2D inventory
local invy_p = InventoryFactory.instance()
	:as2D(10, 10)
	
local invy = invy_p:finalize()
InventoryDebug.DebugInstance(invy_p)

-- Fill 2D inventory with default previously created new item
Inventory.Fill2D(invy, item)
InventoryDebug.DebugItems(invy)

-- Create a single stack item with metadata which can be invoked
local newItem = ItemFactory.instance()
	:withStack(1, 2)
	:withMetadata()
	:withCall(function(self, ...)
		print("Item", self.Id)
	end)
	:finalize(3)
	
-- Invoke that item
Item.Invoke(newItem)

-- Getting/Setting, using cart coords, an item from inventory
invy[{2,1}] = newItem
local twoone = invy[{2,1}]
InventoryDebug.DebugItem(twoone)
InventoryDebug.DebugItems(invy)

-- Empty and re-put-in inventory contents
local contents = Inventory.Empty(invy)
print("Contents", contents)
print("== Inventory Cleared ==")
InventoryDebug.DebugItems(invy)

Inventory.Fill2D(invy, contents)
InventoryDebug.DebugItems(invy)

-- Save inventory
-- InventorySave.Save(1131 .. "u3" .. "_Inventory", "Contents", invy)
-- Inventory.Empty(invy)
-- InventoryDebug.DebugItems(invy)
-- local inventory_data = InventorySave.Load(1131 .. "u3" .. "_Inventory", "Contents")
-- Inventory.Fill2D(invy, inventory_data)
-- InventoryDebug.DebugItems(invy)
