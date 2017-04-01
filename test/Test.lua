
package.path = "../src/?.lua;" .. package.path

-- Imports
local InventoryDebug = require("InventoryDebug")
local InventoryFactory = require("InventoryFactory")
--local InventorySave = require("InventorySave")
local ItemFactory = require("ItemFactory")

-- Creating a single stack item with metadata
local item = ItemFactory.instance()
	:withStack(0, 10)
	:withMetadata()
	:finalize(-1)

-- Creating a single 2D inventory and capturing then debugging the instance
local invy_p = InventoryFactory.instance():as2D(10, 10)
	
local invy = invy_p:finalize()
InventoryDebug.DebugInstance(invy)

-- Fill 2D inventory with default previously created new item
invy:fill(item)
InventoryDebug.DebugItems(invy)

-- Create a single stack item with metadata which can be invoked
local newItem = ItemFactory.instance()
	:withStack(1, 2)
	:withMetadata()
	:withCall(function(self, ...)
		print("Item", self.id)
	end)
	:finalize(3)
	
-- Invoke that item
newItem:invoke()

-- Getting/Setting, using cart coords, an item from inventory
invy:set(2, 1, newItem)
local twoone = invy:get(2, 1)
InventoryDebug.DebugItem(invy, 2, 1)
InventoryDebug.DebugItem(twoone)
InventoryDebug.DebugItems(invy)

-- Empty and re-put-in inventory contents
local contents = invy:empty()
print("Contents", contents)
print("== Inventory Cleared ==")
InventoryDebug.DebugItems(invy)

invy:fill(contents)
InventoryDebug.DebugItems(invy)

-- Save inventory
-- InventorySave.Save(1131 .. "u3" .. "_Inventory", "Contents", invy)
-- Inventory.Empty(invy)
-- InventoryDebug.DebugItems(invy)
-- local inventory_data = InventorySave.Load(1131 .. "u3" .. "_Inventory", "Contents")
-- Inventory.Fill2D(invy, inventory_data)
-- InventoryDebug.DebugItems(invy)