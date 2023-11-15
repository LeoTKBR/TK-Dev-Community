taskOptions = {
	bonusReward = 65001, -- storage bonus reward
	bonusRate = 2, -- rate bonus reward
	taskBoardPositions = {
        {x = 1309, y = 921, z = 6},
        {x = 1307, y = 924, z = 6},
    },
	selectLanguage = 1, -- options: 1 = pt_br or 2 = english
	uniqueTask = true, -- do one task at a time
	uniqueTaskStorage = 65002
}

task_pt_br = {
	exitButton = "Fechar",
	confirmButton = "Validar",
	cancelButton = "Anular",
	returnButton = "Voltar",
	title = "Quadro De Miss�es",
	missionError = "Miss�o esta em andamento ou ela j� foi concluida.",
	uniqueMissionError = "Voc� s� pode fazer uma miss�o por vez.",
	missionErrorTwo = "Voc� concluiu a miss�o",
	missionErrorTwoo = "\nAqui est�o suas recompensas:",
	choiceText = "- Experi�ncia: ",
	messageAcceptedText = "Voc� aceitou essa miss�o!",
	messageDetailsText = "Detalhes da miss�o:",
	choiceMonsterName = "Nome: ",
	choiceMonsterKill = "Abates: ",
	choiceEveryDay = "Repeti��o: Todos os dias",
	choiceRepeatable = "Repeti��o: Sempre",
	choiceOnce = "Repeti��o: Apenas uma vez",
	choiceReward = "Recompensas:",
	messageAlreadyCompleteTask = "Voc� j� concluiu essa miss�o.",
	choiceCancelTask = "Voc� cancelou essa miss�o",
	choiceCancelTaskError = "Voc� n�o pode cancelar essa miss�o, porque ela j� foi conclu�da ou n�o foi iniciada.",
	choiceBoardText = "Escolha uma miss�o e use os bot�es abaixo:",
	choiceRewardOnHold = "Resgatar Pr�mio",
	choiceDailyConclued = "Di�ria Conclu�da",
	choiceConclued = "Conclu�da",
	messageTaskBoardError = "O quadro de miss�es esta muito longe ou esse n�o � o quadro de miss�es correto.",
	messageCompleteTask = "Voc� terminou essa miss�o! \nRetorne para o quadro de miss�es e pegue sua recompensa.",
}

taskConfiguration = {
{name = "Minotaur", color = 40, total = 5000, type = "once", storage = 190000, storagecount = 190001, 
rewards = {
{5804, 1},
{"exp", 1000000},
	},
},

{name = "Dragon", color = 40, total = 1000, type = "daily", storage = 190002, storagecount = 190003, 
rewards = {
{3043, 100},
{5908, 1},
{"exp", 1500000},
	},
},

{name = "Dragon Lord", color = 40, total = 60000, type = "once", storage = 190004, storagecount = 190005, 
rewards = {
{5919, 1},
{"exp", 1500000},
	},
},

{name = "Rotworm", color = 40, total = 250, type = "once", storage = 190006, storagecount = 190007, 
rewards = {
{3043, 10},
{"exp", 100000},
	},
},

{name = "Amazon", color = 40, total = 500, type = "repeatable", storage = 190008, storagecount = 190009, 
rewards = { 
{"exp", 1500000},
{3437, 1},
	},
},

{name = "Valkyrie", color = 40, total = 50000, type = "once", storage = 190010, storagecount = 190011, 
rewards = { 
{3437, 1},
	},
},

{name = "Weakened Frazzlemaw", color = 40, total = 1000, type = "daily", storage = 190012, storagecount = 190013, 
rewards = { 
{22516, 1},
	},
},

{name = "Enfeebled Silencer", color = 40, total = 1000, type = "daily", storage = 190014, storagecount = 190015, 
rewards = { 
{22721, 1},
	},
},

{name = "Deepling Guard", color = 40, total = 1000, type = "daily", storage = 190016, storagecount = 190017, 
rewards = { 
{14142, 1},
	},
},

{name = "Deepling Warrior", color = 40, total = 1000, type = "daily", storage = 190018, storagecount = 190019, 
rewards = { 
{"exp", 10000000},
	},
},

{name = "Deepling Scout", color = 40, total = 1000, type = "daily", storage = 190020, storagecount = 190021, 
rewards = { 
{"exp", 10000000},
	},
},

{name = "Guzzlemaw", color = 40, total = 5000, type = "once", storage = 190022, storagecount = 190023, 
rewards = { 
{20270, 1},
	},
},

{name = "Frazzlemaw", color = 40, total = 5000, type = "once", storage = 190022, storagecount = 190023, 
rewards = { 
{20272, 1},
	},
},

{name = "Silencer", color = 40, total = 5000, type = "once", storage = 190024, storagecount = 190025, 
rewards = { 
{20271, 1},
	},
},

{name = "Medusa", color = 40, total = 25000, type = "once", storage = 190026, storagecount = 190027, 
rewards = { 
{3393, 1},
	},
},

{name = "Demon", color = 40, total = 66000, type = "once", storage = 190028, storagecount = 190029, 
rewards = { 
{3365, 1},
	},
},

{name = "Hero", color = 40, total = 50000, type = "once", storage = 190030, storagecount = 190031, 
rewards = { 
{3394, 1},
	},
},

{name = "Cloak Of Terror", color = 40, total = 1000, type = "daily", storage = 190032, storagecount = 190033, 
rewards = { 
{"exp", 30000000},
	},
},

{name = "Vibrant Phantom", color = 40, total = 1000, type = "daily", storage = 190034, storagecount = 190035, 
rewards = { 
{"exp", 30000000},
	},
},

{name = "Courage Leech", color = 40, total = 1000, type = "daily", storage = 190036, storagecount = 190037, 
rewards = { 
{"exp", 30000000},
	},
},

{name = "Brachiodemon", color = 40, total = 1000, type = "daily", storage = 190038, storagecount = 190039, 
rewards = { 
{"exp", 30000000},
	},
},

{name = "Infernal Demon", color = 40, total = 50000, type = "once", storage = 190040, storagecount = 190041, 
rewards = { 
{34109, 2},
	},
},

{name = "Infernal Phantom", color = 40, total = 1000, type = "daily", storage = 190042, storagecount = 190043, 
rewards = { 
{"exp", 30000000},
	},
},

{name = "Juggernaut", color = 40, total = 50420, type = "once", storage = 190044, storagecount = 190045, 
rewards = { 
{3422, 1},
	},
},

{name = "Dawnfire Asura", color = 40, total = 1000, type = "daily", storage = 190046, storagecount = 190047, 
rewards = { 
{"exp", 20000000},
	},
},

{name = "Girtablilu Warrior", color = 40, total = 5000, type = "once", storage = 190052, storagecount = 190053, 
rewards = {   
{"exp", 100000000},
	},
},

{name = "Dark Carnisylvan", color = 40, total = 25000, type = "once", storage = 190062, storagecount = 190063, 
rewards = { 
{"exp", 100000000},
	},
},
}

squareWaitTime = 5000
taskQuestLog = 65000 -- A storage so you get the quest log
dailyTaskWaitTime = 20 * 60 * 60 

function Player.getCustomActiveTasksName(self)
local player = self
	if not player then
		return false
	end
local tasks = {}
	for i, data in pairs(taskConfiguration) do
		if player:getStorageValue(data.storagecount) ~= -1 then
		tasks[#tasks + 1] = data.name
		end
	end
	return #tasks > 0 and tasks or false
end


function getTaskByStorage(storage)
	for i, data in pairs(taskConfiguration) do
		if data.storage == tonumber(storage) then
			return data
		end
	end
	return false
end

function getTaskByMonsterName(name)
	for i, data in pairs(taskConfiguration) do
		if data.name:lower() == name:lower() then
			return data
		end
	end
	return false
end

function Player.startTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	if player:getStorageValue(taskQuestLog) == -1 then
		player:setStorageValue(taskQuestLog, 1)
	end
	player:setStorageValue(storage, player:getStorageValue(storage) + 1)
	player:setStorageValue(data.storagecount, 0)
	return true
end

function Player.canStartCustomTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	if data.type == "daily" then
		return os.time() >= player:getStorageValue(storage)
	elseif data.type == "once" then
		return player:getStorageValue(storage) == -1
	elseif data.type[1] == "repeatable" and data.type[2] ~= -1 then
		return player:getStorageValue(storage) < (data.type[2] - 1)
	else
		return true
	end
end

function Player.endTask(self, storage, prematurely)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
end
	if prematurely then
		if data.type == "daily" then
			player:setStorageValue(storage, -1)
		else
			player:setStorageValue(storage, player:getStorageValue(storage) - 1)
	end
	else
		if data.type == "daily" then
			player:setStorageValue(storage, os.time() + dailyTaskWaitTime)
		end
	end
	player:setStorageValue(data.storagecount, -1)
	return true
end

function Player.hasStartedTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	return player:getStorageValue(data.storagecount) ~= -1
end


function Player.getTaskKills(self, storage)
local player = self
	if not player then
		return false
	end
	return player:getStorageValue(storage)
end

function Player.addTaskKill(self, storage, count)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	local kills = player:getTaskKills(data.storagecount)
	if kills >= data.total then
		return false
	end
	if kills + count >= data.total then
		if taskOptions.selectLanguage == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, task_pt_br.messageCompleteTask)
		else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Task System] You have finished this task! To claim your rewards, return to the quest board and claim your reward.")
		end
		return player:setStorageValue(data.storagecount, data.total)
	end
		player:say('Task: '..data.name ..' - ['.. kills + count .. '/'.. data.total ..']', TALKTYPE_MONSTER_SAY)
		return player:setStorageValue(data.storagecount, kills + count)
end