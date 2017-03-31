
local Item = {}

local Item_clone = function(item)
	local out = {}
	for i, v in pairs(item)do
		out[i] = type(v) == "table" and {} or v
	end
	return out
end

local Item_invoke = function(item, ...)
	return item.callable(item, ...)
end

local Item_set = function(item, index, val)
	item.data[index] = val
	return item
end

local Item_get = function(item, index)
	return item.data[index]
end

local Item_remove = function(item, index)
	local value = item.data[index]
	item.data[index] = nil
	return value
end

Item.new = function(id)
	local this = {
		id = id or -1;
	}
	
	this.clone = Item_clone
	
	this.invoke = Item_invoke
	this.remove = Item_remove
	
	this.set = Item_set
	this.get = Item_get
	
	return this
end




local ItemFactory = {}

local ItemFactory_reset = function(self)
	self.call = false;
	self.call_data = nil;
	self.stack_data = false;
	self.stack_data_amt = 0;
	self.stack_data_max = 0;
	self.data = false;
	self.data_data = false;
end

local ItemFactory_withCall = function(self, func)
	self.call = true
	self.call_data = func
	return self
end

local ItemFactory_withStack = function(self, stack, _max)
	self.stack_data = true
	self.stack_data_amt = stack
	self.stack_data_max = _max
	return self
end

local ItemFactory_withMetadata = function(self, data)
	self.data = true
	self.data_data = data or {}
	return self
end

local ItemFactory_finalize = function(self, id)
	local item = Item.new(id)
	item.callable = self.call_data
	item.amount = self.stack_data and self.stack_data_amt or nil
	item.max = self.stack_data and (self.stack_data_max or 0) or nil
	item.data = self.data and self.data_data or nil
	return item
end

ItemFactory.instance = function()
	local this = {}
	
	this.reset = ItemFactory_reset
	
	this:reset()
	
	this.withCall = ItemFactory_withCall
	this.withStack = ItemFactory_withStack
	this.withMetadata = ItemFactory_withMetadata
	
	this.finalize = ItemFactory_finalize
	
	return this
end

return ItemFactory
