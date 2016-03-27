
-- Imports
local InventoryDebug = require("InventoryDebug")
--local InventorySave = require("InventorySave")
local InventoryFactory = require("InventoryFactory")
local ItemFactory = require("ItemFactory")

-- Creating a single stack item with metadata
local item = ItemFactory.instance()
	:withStack(0, 10)
	:withMetadata()
	:finalize(2)

-- Creating a single 2D inventory
local invy = InventoryFactory.instance()
	:as2D(10, 10)
	:finalize()

-- Fill 2D inventory with default previously created new item
invy:Fill(nil, item)
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
newItem:Invoke()

-- Getting/Setting, using cart coords, an item from inventory
invy[{2,1}] = newItem
local twoone = invy[{2,1}]
InventoryDebug.DebugItem(twoone)
InventoryDebug.DebugItems(invy)

-- Empty and re-put-in inventory contents
local contents = invy:Empty()
print("Contents", contents)
print("== Inventory Cleared ==")
InventoryDebug.DebugItems(invy)

invy:Fill(contents)
InventoryDebug.DebugItems(invy)

-- Save inventory
-- InventorySave.Save(1131 .. "u3" .. "_Inventory", "Contents", invy)
-- invy:Empty()
-- InventoryDebug.DebugItems(invy)
-- local inventory_data = InventorySave.Load(1131 .. "u3" .. "_Inventory", "Contents")
-- invy:Fill(inventory_data)
-- InventoryDebug.DebugItems(invy)
