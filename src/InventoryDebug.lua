
local InventoryDebug = {}

InventoryDebug.DebugItems = function(invy)
	print("start inventory items debugging")
	if(#invy.contents == 0)then
		print("# EMPTY")
		print("end inventory items debugging")
		return
	end
	for y=1, invy.lengthy do
		local out = "{"
		for x=1, invy.lengthx do
			local value = invy.contents[x][y]
			out = out .. (value.id > -1 and (" " .. value.id) or value.id) .. ","
		end
		out = out .. "}"
		print(out)
	end
	print("end inventory items debugging")
end

InventoryDebug.DebugItem = function(invy, x, y)
	print("start item debugging")
	local item = invy
	if(x and y)then
		item = invy.contents[x][y]
	end
	print(x, y, item.id, item.amount, item.max, item.callable)
	if(item.data)then
		for i, v in pairs(item.data)do
			print(i, v)
		end
	end
	print("end item debugging")
end

InventoryDebug.DebugInstance = function(instance)
	print("start instance debugging")
	for i, v in pairs(instance)do
		print(i, type(v), v)
	end
	print("end instance debugging")
end

return InventoryDebug
