
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

InventoryUtil.Add1D = function(inventory, inp)
	if(#inventory.Length+1 > Size)then
		return nil
	end
	table.insert(inventory.Contents, inp)
	return inventory
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
