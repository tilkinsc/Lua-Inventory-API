
local InventoryDebug = {}

InventoryDebug.DebugItems = function(invy)
	print("start inventory items debugging")
	if(#invy.Contents == 0)then
		print("{}")
		print("end inventory items debugging")
		return
	end
	for y=1, invy.LengthY do
		local out = "{"
		for x=1, invy.LengthX do
			local value = invy.Contents[x][y]
			out = out .. (value.Id > -1 and (" " .. value.Id) or value.Id) .. ","
		end
		out = out .. "}"
		print(out)
	end
	print("end inventory items debugging")
end

InventoryDebug.DebugItem = function(invy, x, y)
	print("start item debugging")
	local item = x and y and invy[x][y] or invy
	print(x, y, item.Id, item.Amount, item.Max, item.Callable)
	if(item.Data)then
		for i, v in pairs(item.Data)do
			print(i, v)
		end
	end
	print("end item debugging")
end

return InventoryDebug
