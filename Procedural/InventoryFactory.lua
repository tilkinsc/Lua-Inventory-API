
local Inventory = {}

Inventory.new1D = function(size)
	local this = {
		Size = size;
		Contents = {};
	}
	
	this.Add = function(self, item)
		if(#self.Length+1 > Size)then
			return nil
		end
		table.insert(self.Contents, item)
		return self
	end
	
	this.Fill = function(self, contents, typ)
		if(contents)then
			self.Contents = contents
			return
		end
		self.Contents = {}
		for x=1, self.LengthX do
			self.Contents[x] = typ:Clone()
		end
	end
	
	this.Empty = function(self)
		local old = self.Contents
		self.Contents = {}
		return old
	end
	
	setmetatable(this, {
		__index = function(self, i)
			return self.Contents[i]
		end;
		__newindex = function(self, i, v)
			if(i == "Length")then
				return #self.Contents
			end
			self.Contents[i] = v
		end;
	})
	
	return this
end

Inventory.new2D = function(sizex, sizey)
	local this = {
		LengthX = sizex;
		LengthY = sizey;
		Size = sizex * sizey;
		Contents = {};
	}
	
	-- Fill(self, contents)
	-- Fill(self, nil, ItemType)
	this.Fill = function(self, contents, typ)
		if(contents)then
			self.Contents = contents
			return
		end
		self.Contents = {}
		for x=1, self.LengthX do
			self.Contents[x] = {}
			for y=1, self.LengthY do
				self.Contents[x][y] = typ:Clone()
			end
		end
	end
	
	this.Empty = function(self)
		local old = self.Contents
		self.Contents = {}
		return old
	end
	
	setmetatable(this, {
		__index = function(self, i)
			if(type(i) == "table")then
				return self.Contents[i[1]][i[2]]
			end
		end;
		__newindex = function(self, i, v)
			if(type(i) == "table")then
				self.Contents[i[1]][i[2]] = v
			end
			rawset(self, i, v)
		end;
	})
	
	return this
end

local InventoryFactory = {}

InventoryFactory.instance = function()
	local this = {
		dimension = nil;
		dimension_x = nil;
		dimension_y = nil;
	}
	
	this.as1D = function(self, dim_x)
		self.dimension = 1
		self.dimension_x = dim_x
		self.dimension_y = 0
		return self
	end
	
	this.as2D = function(self, dim_x, dim_y)
		self.dimension = 2
		self.dimension_x = dim_x
		self.dimension_y = dim_y
		return self
	end
	
	this.finalize = function(self)
		if(dimension and self.dimension_x and self.dimension_y)then
			error("No inventory type or dimensions set!")
		end
		local invy =
			self.dimension == 1 and Inventory.new1D(self.dimension_x) or
			self.dimension == 2 and Inventory.new2D(self.dimension_x, self.dimension_y)
			or nil
		
		return invy
	end
	
	return this
end

return InventoryFactory
