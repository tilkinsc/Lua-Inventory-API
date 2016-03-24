
local Item = {}

Item.new = function(id)
	local this = {
		Id = id or -1;
	}
	
	this.Clone = function(self)
		local out = {}
		for i, v in pairs(self)do
			if(type(v) == "table")then
				out[i] = {}
			else
				out[i] = v
			end
		end
		return out
	end
	
	return this
end

local ItemFactory = {}

ItemFactory.instance = function()
	local this = {
		call = false;
		call_data = nil;
		stack_data = false;
		stack_data_amt = 0;
		stack_data_max = 0;
		data = false;
		data_data = false;
	}
	
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
		if(item.Callable)then
			item.Invoke = function(self, ...)
				self.Callable(self, ...)
			end
		end
		if(item.Data)then
			item.Set = function(self, index, val)
				self.Data[index] = val
				return self
			end
			item.Get = function(self, index)
				return self.Data[index]
			end
			item.Remove = function(self, index, getvalue)
				local value = self.Data[index]
				self.Data[index] = nil
				return getvalue and self or value
			end
			item.Reset = function(self)
				self.Id = -1
				self.Data = {}
			end
		end
		return item
	end
	
	return this
end

return ItemFactory
