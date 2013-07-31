totalNrSpawned = 0
totalTime = 0.0
totalMins = 0
timeSinceLastSpawn = 0.0
EperMin = 0
hasSpawned = false
difficulty = 0

nodes = {}

function init(inputNodes, enemiesPerMin, inputDiff)
	nodes = inputNodes
	ePerMin = enemiesPerMin
	totalTime = 0.0
	difficulty = inputDiff
	return nodes.n
end

function spawning(deltaTime, nrOfEnemies)
	totalTime = totalTime + deltaTime
	local nrOfEnemiesSpawned = 0
	local enemies = {{-1}}
	local insertIndex = 1
	local enemiesToSpawn = 0
	math.randomseed(os.time())
	math.random();math.random();math.random()
	
	if(totalTime/60 > totalMins)
	then
		totalMins = totalMins+1
		ePerMin = ePerMin+1
	end
	
	if(hasSpawned == false)
	then
		if(totalNrSpawned < ePerMin*totalMins)
		then
			--randoma ett hur många fiender som ska spawnas
			--enemiesToSpawn = math.random(0,(nodes.n/2))
			enemiesToSpawn = math.random(1,2 + (totalMins* 2))
			
			--spawna så många fiender på random noder runt om banan
			for i = 1, enemiesToSpawn
			do
				side = math.random(1,4)
				spawnNode = math.random(0,nodes.n-1)
				enemyHP = 30 + totalMins
				enemyDMG = 10
				enemySPEED = 5 + totalMins/2
				
				if(side == 1) --top
				then
					if(nodes[spawnNode] == 1)
					then
						enemies[insertIndex] = {spawnNode * nodes.q,0,enemyHP,enemySPEED,enemyDMG}	
					end
					
				end
				
				if(side == 2) --bottom
				then
					if(nodes[spawnNode + (nodes.n * (nodes.n-1))] == 1)
					then
						enemies[insertIndex] = {spawnNode * nodes.q,(nodes.n-1)*nodes.q,enemyHP,enemySPEED,enemyDMG}
					end
				end
				
				if(side == 3) --left
				then
					if(nodes[0 + spawnNode*(nodes.n)] == 1)
					then
						enemies[insertIndex] = {0,spawnNode * nodes.q,enemyHP,enemySPEED,enemyDMG}
					end
					
				end
				
				if(side == 4) --right
				then
					if(nodes[(nodes.n-1) + spawnNode * (nodes.n)] == 1)
					then
						enemies[insertIndex] = {(nodes.n-1)*nodes.q,spawnNode * nodes.q,enemyHP,enemySPEED,enemyDMG}
					end
						
				end

				insertIndex = insertIndex + 1
				nrOfEnemiesSpawned = nrOfEnemiesSpawned + 1
			end
			
			hasSpawned = true
		end
	else
		if(timeSinceLastSpawn < 10)
		then
			timeSinceLastSpawn = timeSinceLastSpawn + deltaTime
		else
			hasSpawned = false
			timeSinceLastSpawn = 0.0
		end
	end
	
	totalNrSpawned = totalNrSpawned + nrOfEnemiesSpawned
	
	return enemies, nrOfEnemiesSpawned
end