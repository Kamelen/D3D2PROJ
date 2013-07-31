targetX = 0
targetY = 0


function init(mapsize)
MAPSIZE = mapsize

return 1
end


function findTarget(structures, currentPosX, currentPosY, e_type)

getMin(structures, currentPosX, currentPosY, e_type)
getClosest()
return  ID, targetX, targetY

end


function getMin(structures, currentPosX, currentPosY, e_type)
x1 = currentPosX
y1 = currentPosY
targetLength = MAPSIZE*MAPSIZE

if(e_type == 1) then
	for i = 0, math.pow(MAPSIZE-1, 2)-1, 1 do
		if(structures[i] ~= -1) then
		
			x2 = math.fmod(i, (MAPSIZE-1))
			y2 = math.floor(i/(MAPSIZE-1))
			
			diffX = math.abs(x2 - x1)
			diffY = math.abs(y2 - y1)
			
			tempHyp = math.sqrt( math.pow(diffX, 2) + math.pow(diffY, 2) )
			if(tempHyp < targetLength) then
				targetLength = tempHyp
				targetX = x2
				targetY = y2
			end
		end
	end

end
--[[if(e_type == 2) then 
	for i = 0, pow(MAPSIZE-1, 2), 1 do
		x2 = structures[fmod(i, (MAPSIZE-1).floor)]
		y2 = structures[i/(MAPSIZE-1).floor]
		if(x2 == 1 and y2 == 1) then
			
		end
	end
end

--]]
end

function getClosest()

diffX = math.abs(targetX - x1)
diffY = math.abs(targetY - y1)
tempHyp = math.sqrt( math.pow(diffX, 2) + math.pow(diffY, 2) )
minLength = tempHyp
minX = targetX
minY = targetY
ID = 1


targetX = targetX + 1
diffX = math.abs(targetX - x1)
diffY = math.abs(targetY - y1)
tempHyp = math.sqrt( math.pow(diffX, 2) + math.pow(diffY, 2) )
if(tempHyp < minLength) then
	minLength = tempHyp
	minX = targetX
	minY = targetY
	ID = 2
end

targetY = targetY + 1
diffX = math.abs(targetX - x1)
diffY = math.abs(targetY - y1)
tempHyp = math.sqrt( math.pow(diffX, 2) + math.pow(diffY, 2) )
if(tempHyp < minLength) then
	minLength = tempHyp
	minX = targetX
	minY = targetY
	ID = 3
end

targetX = targetX - 1
diffX = math.abs(targetX - x1)
diffY = math.abs(targetY - y1)
tempHyp = math.sqrt( math.pow(diffX, 2) + math.pow(diffY, 2) )
if(tempHyp < minLength) then
	minLength = tempHyp
	minX = targetX
	minY = targetY
	ID = 4
end

targetX = minX
targetY = minY

end


