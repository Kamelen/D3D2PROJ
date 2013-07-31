totalNrSpawned = 0
totalTime = 0.0
totalMins = 1
timeSinceLastSpawn = 0.0
EperMin = 0
hasSpawned = false
difficulty = 0
bossCanSpawn = false

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
		bossCanSpawn = true
	end
	
	if(hasSpawned == false)
	then
		if(totalNrSpawned < ePerMin*totalMins)
		then
			--randoma ett hur många fiender som ska spawnas
			
			enemiesToSpawn = math.random(5 + (totalMins^2),(totalMins+2)^2)
			if(difficulty == 0) -- easy
			then
			enemiesToSpawn = enemiesToSpawn - (5 * totalMins)
			end
			if(difficulty == 2) -- hard
			then
			enemiesToSpawn = enemiesToSpawn + (5 * totalMins)
			end
			--spawna så många fiender på random noder runt om banan
			if(bossCanSpawn)
			then
				enemiesToSpawn = 1
			end
			
			
			for i = 1, enemiesToSpawn
			do
				side = math.random(1,4)
				spawnNode = math.random(0,nodes.n-1)
				enemyHP = 30 + totalMins*2
				enemyDMG = 10
				enemySPEED = 5 + totalMins/2
				enemyXP = 10
				if(bossCanSpawn)
				then
					enemyHP = 200 + totalMins*50
					enemyDMG = 80
					enemySPEED = 3
					enemeyXp = 100
					bossCanSpawn = false
				end
				
				if(side == 1) --top
				then
					if(nodes[spawnNode] == 1)
					then
						enemies[insertIndex] = {spawnNode * nodes.q,0,enemyHP,enemySPEED,enemyDMG,enemyXP}	
					end
					
				end
				
				if(side == 2) --bottom
				then
					if(nodes[spawnNode + (nodes.n * (nodes.n-1))] == 1)
					then
						enemies[insertIndex] = {spawnNode * nodes.q,(nodes.n-1)*nodes.q,enemyHP,enemySPEED,enemyDMG,enemyXP}
					end
				end
				
				if(side == 3) --left
				then
					if(nodes[0 + spawnNode*(nodes.n)] == 1)
					then
						enemies[insertIndex] = {0,spawnNode * nodes.q,enemyHP,enemySPEED,enemyDMG,enemyXP}
					end
					
				end
				
				if(side == 4) --right
				then
					if(nodes[(nodes.n-1) + spawnNode * (nodes.n)] == 1)
					then
						enemies[insertIndex] = {(nodes.n-1)*nodes.q,spawnNode * nodes.q,enemyHP,enemySPEED,enemyDMG,enemyXP}
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