
local clone = function(item)
	local out = {}
	for i, v in pairs(item)do
		if(type(v) == "table")then
			out[i] = {}
		elseif(type(v) == "userdata")then
			error("Attempt to clone userdata. Please convert userdata to tables prior to cloning.")
		else
			out[i] = v
		end
	end
	return out
end



local InventoryFactory = {}

-- TODO: Figure out how to handle return nil
local InventoryFactory_finalize_set1D = function(inventory, inp)
	if(inventory.size < inventory.length)then
		return nil
	end
	inventory.length = inventory.length + 1
	table.insert(inventory.contents, inp)
	return inventory
end

local InventoryFactory_finalize_set2D = function(inventory, x, y, inp)
	inventory.contents[x][y] = inp
	return inventory
end

local InventoryFactory_finalize_get1D = function(inventory, x)
	return inventory.contents[x]
end

local InventoryFactory_finalize_get2D = function(inventory, x, y)
	return inventory.contents[x][y]
end

-- TODO: Figure out how to handle return nil
local InventoryFactory_finalize_remove1D = function(inventory, index)
	if(index > inventory.length or index > inventory.size)then
		return nil
	end
	inventory.length = inventory.length - 1
	return table.remove(inventory.contents, index)
end

local InventoryFactory_finalize_fill1D = function(inventory, contents)
	if(not contents.Id)then
		inventory.Contents = contents
		return
	end
	inventory.contents = {}
	for x=1, inventory.lengthx do
		inventory.contents[x] = clone(contents)
	end
	inventory.size = #inventory.contents
end

local InventoryFactory_finalize_fill2D = function(inventory, contents)
	if(contents.id == nil)then
		print("lazy fill")
		inventory.contents = contents
		return
	end
	inventory.contents = {}
	for x=1, inventory.lengthx do
		inventory.contents[x] = {}
		for y=1, inventory.lengthy do
			inventory.contents[x][y] = clone(contents)
		end
	end
	inventory.lengthx = #inventory.contents
	inventory.lengthy = #inventory.contents[1]
	inventory.size = inventory.lengthx * inventory.lengthy
end

local InventoryFactory_finalize_empty = function(inventory)
	local old = inventory.contents
	inventory.contents = {}
	return old
end

local InventoryFactory_finalize = function(self)
	if(self.dimension_x == nil)then
		error("No inventory type or dimensions set!")
	end
	
	local invy
	
	if(self.dimension == 1) then
		invy = {
			size = self.dimension_x;
			contents = {};
		}
		invy.set = InventoryFactory_finalize_set1D
		invy.get = InventoryFactory_finalize_get1D
		invy.remove = InventoryFactory_finalize_remove1D
		invy.fill = InventoryFactory_finalize_fill1D
	elseif(self.dimension == 2) then
		invy = {
			size = self.dimension_x * self.dimension_y;
			lengthx = self.dimension_x;
			lengthy = self.dimension_y;
			contents = {};
		}
		invy.set = InventoryFactory_finalize_set2D
		invy.get = InventoryFactory_finalize_get2D
		invy.remove = InventoryFactory_finalize_remove2D
		invy.fill = InventoryFactory_finalize_fill2D
	end
	
	invy.clone = InventoryFactory_finalize_clone
	invy.empty = InventoryFactory_finalize_empty
	
	return invy
end

local InventoryFactory_reset = function(self)
	self.dimension = nil;
	self.dimension_x = nil;
	self.dimension_y = nil;
end

local InventoryFactory_as1D = function(self, dim_x)
	self.dimension = 1
	self.dimension_x = dim_x
	self.dimension_y = 0
	return self
end

local InventoryFactory_as2D = function(self, dim_x, dim_y)
	self.dimension = 2
	self.dimension_x = dim_x
	self.dimension_y = dim_y
	return self
end

InventoryFactory.instance = function()
	local this = {}
	
	this.reset = InventoryFactory_reset
	
	this:reset()
	
	this.as1D = InventoryFactory_as1D
	this.as2D = InventoryFactory_as2D
	
	this.finalize = InventoryFactory_finalize
	
	return this
end

return InventoryFactory
