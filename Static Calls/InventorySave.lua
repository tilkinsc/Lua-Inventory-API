
local DataStore = game:GetService("DataStoreService")

local Save = {}

Save.Save = function(entry, key, invy)
	local length = 0
	local recurse
	recurse = function(object)
		for i, v in pairs(object)do
			if(type(v) == "string")then
				length = length + #v
			end
			if(type(v) == "number")then
				length = length + 1
			end
			if(type(v) == "userdata")then
				error("Attempt to save userdata. Please convert userdata to tables prior to saving.")
			end
			if(type(v) == "table")then
				recurse(v)
			end
		end
	end
	recurse(invy)
	if(#key > 50)then
		error("Too much key to save! Reduce key to under 50 characters.")
	end
	if(length <= 260000)then
		DataStore:GetDataStore(entry):SetAsync(key, invy)
	else
		error("Too much data to save! Reduce data to under 260,000 characters.")
	end
end

Save.Load = function(entry, key)
	return DataStore:GetDataStore(entry):GetAsync(key)
end

return Save
