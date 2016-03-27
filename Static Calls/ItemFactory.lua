
local Item = {}

Item.new = function(id)
	local this = {
		Id = id or -1;
	}
	
	return this
end

local ItemFactory = {}

ItemFactory.instance = function()
	local this = {}
	
	this.reset = function(self)
		self.call = false;
		self.call_data = nil;
		self.stack_data = false;
		self.stack_data_amt = 0;
		self.stack_data_max = 0;
		self.data = false;
		self.data_data = false;
	end
	
	this:reset()
	
	this.withCall = function(self, func)
		self.call = true
		self.call_data = func
		return self
	end
	
	this.withStack = function(self, stack, _max)
		self.stack_data = true
		self.stack_data_amt = stack
		self.stack_data_max = _max
		return self
	end
	
	this.withMetadata = function(self, data)
		self.data = true
		self.data_data = data or {}
		return self
	end
	
	this.finalize = function(self, id)
		local item = Item.new(id)
		item.Callable = self.call_data
		item.Amount = self.stack_data and self.stack_data_amt or nil
		item.Max = self.stack_data and (self.stack_data_max or 0) or nil
		item.Data = self.data and self.data_data or nil
		return item
	end
	
	return this
end

return ItemFactory
