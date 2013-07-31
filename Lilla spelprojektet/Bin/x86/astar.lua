MAPSIZE = 10
NODES = {}
result = {}

function init(nodes, size)
	MAPSIZE = size
	NODES = nodes
end

function astar(startPos, targetPos, enemyType)
	local closedSet = {}
	local openSet = {startPos}
	local cameFrom = {}
	local g_score = {}
	local f_score = {}
	local path = {}

	for k in pairs (result) do
		result[k] = nil
	end
	
	for i = 0, MAPSIZE*MAPSIZE do
		g_score[i] = 1
	end

	current = startPos
	g_score[startPos] = 0
	f_score[startPos] = g_score[startPos] + lengthBetween(startPos, targetPos)

	--for i = 0, MAPSIZE*MAPSIZE do
	--	NODES[i] = 1
	--end

	while #openSet do
		current = lowestScore(openSet, f_score)

		if current == targetPos then
			path = reconstruct_path(cameFrom, targetPos)
			table.insert(path, targetPos)
				return path, #path
		end

		removeNode(openSet, current)
		table.insert(closedSet, current)

		-- Add all neighbors to openSet if it's not already in openSet
		temp = getNeightbors(current)
		for i = 1, table.getn(temp) do
			if isInSet(closedSet, temp[i]) == false then
				local tenative_score = g_score[temp[i]] + 1

				if isInSet(openSet, temp[i]) == false or tenative_score < g_score[temp[i]] then
					cameFrom[temp[i]] = current
					g_score[temp[i]] = tenative_score
					f_score[temp[i]] = g_score[temp[i]] + lengthBetween(temp[i], targetPos)

					if isInSet(openSet, temp[i]) == false then
						table.insert(openSet, temp[i])
					end
				end
			end
		end
	end

	return result, -1
end

function reconstruct_path(cameFrom, currentNode)
	if cameFrom[currentNode] then
		table.insert(result, 1, cameFrom[currentNode])
		return reconstruct_path(cameFrom, cameFrom[currentNode])
	else
		return result
	end
end

function lowestScore(set, f_score)
	local lowest, bestNode = 100000, nil

	for _, node in ipairs(set) do
		local score = f_score[node]
		if score < lowest then
			lowest, bestNode = score, node
		end
	end
	return bestNode
end

function removeNode(set, value)
	for i, node in ipairs(set) do
		if node == value then
			table.remove(set, i)
			break
		end
	end
end

function getNeightbors(pos)
	-- return all neightbors
	neightbors = {}
	x = pos % MAPSIZE
	y = math.floor(pos / MAPSIZE)

	--if pos > (math.floor(pos/MAPSIZE) * MAPSIZE) and NODES[pos-1] ~= 0 then
	if x > 0 and NODES[pos-1] ~= 0 then
		table.insert(neightbors, pos-1)
	end

	--if pos < (MAPSIZE*(math.ceil(pos/MAPSIZE)))-1 and NODES[pos+1] ~= 0 or change then
	if x < MAPSIZE-1 and NODES[pos+1] ~= 0 then
		table.insert(neightbors, pos+1)
	end

	--if pos >= MAPSIZE and NODES[pos-MAPSIZE] ~= 0 then
	if y > 0 and NODES[pos-MAPSIZE] ~= 0 then
		table.insert(neightbors, pos-MAPSIZE)
	end

	--if pos <= ((MAPSIZE*MAPSIZE) - MAPSIZE-1) and NODES[pos+MAPSIZE] ~= 0 then
	if y < MAPSIZE-1 and NODES[pos+MAPSIZE] ~= 0 then
		table.insert(neightbors, pos+MAPSIZE)
	end

	return neightbors
end

function isInSet(set, value)
	for _, asd in ipairs (set) do
		if asd == value then
			return true
		end
	end
	return false
end

function lengthBetween(start, goal)
	x = start % MAPSIZE
	y = math.floor(start / MAPSIZE)
	x2 = goal % MAPSIZE
	y2 = math.floor(goal / MAPSIZE)

	dirX = x2 - x
	dirY = y2 - y

	length = math.sqrt((dirX*dirX) + (dirY*dirY))

	return length
end

--[[
result = astar(99, 0, 1)
if result == nil then
	print ("fail")
else
	print ("")
	for _, node in ipairs(result) do
		print (node)
	end
end

print (astar(0, 99, 0))--]]
