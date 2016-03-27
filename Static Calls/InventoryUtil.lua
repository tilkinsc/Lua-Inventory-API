
local CloneItem = function(item)
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

local InventoryUtil = {}

-- TODO: Figure out how to handle return nil
InventoryUtil.Add1D = function(inventory, inp)
	if(inventory.Size < inventory.Length+1)then
		return nil
	end
	inventory.Length = inventory.Length + 1
	table.insert(inventory.Contents, inp)
	return inventory
end

InventoryUtil.Add2D = function(inventory, x, y, inp)
	if(x => inventory.LengthX+1)then
		return nil
	end
	inventory.Contents[x][y] = inp
	return inventory
end

-- TODO: Figure out how to handle return nil
InventoryUtil.Remove1D = function(inventory, index)
	if(index > inventory.Length or index > inventory.Size)then
		return nil
	end
	inventory.Length = inventory.Length - 1
	return table.remove(inventory.Contents, index)
end

InventoryUtil.Fill1D = function(inventory, contents)
	if(not contents.Id)then
		inventory.Contents = contents
		return
	end
	inventory.Contents = {}
	for x=1, inventory.LengthX do
		inventory.Contents[x] = CloneItem(contents)
	end
	inventory.Size = #inventory.Contents
end

InventoryUtil.Fill2D = function(inventory, contents)
	if(not contents.Id)then
		inventory.Contents = contents
		return
	end
	inventory.Contents = {}
	for x=1, inventory.LengthX do
		inventory.Contents[x] = {}
		for y=1, inventory.LengthY do
			inventory.Contents[x][y] = CloneItem(contents)
		end
	end
	inventory.LengthX = #inventory.Contents
	inventory.LengthY = #inventory.Contents[1]
	inventory.Size = inventory.LengthX * inventory.LengthY
end

InventoryUtil.Empty = function(inventory)
	local old = inventory.Contents
	inventory.Contents = {}
	return old
end

return InventoryUtil
