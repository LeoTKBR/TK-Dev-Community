<?xml version="1.0" encoding="UTF-8"?>

<mod name="Automatic Raids" version="1.0" author="Vodkart And xotservx" contact="tibiaking.com" enabled="yes"> 
<config name="raids_func">
-- Mini-tutorial de configuração
-- Não esqueça de configurar os horários que o evento vai iniciar (OBS: O script sempre pega o horário da maquina caso a sua maquina ou vps
-- usar horário de outros lugares vai ter atraso dependendo do fuso-horário
-- nome =  Nome do evento que vai mostrar em mensagem vermelha para o servidor todo
-- pos = fromPosition = Canto Superior Direito
-- pos = toPosition = Canto Inferior Esquerdo
-- Configurando a pos corretamente pode formar um quadrado ou retangulo para os monstro não nascerem um em cima do outro
-- m = Quantidade e tipos de monstro a serem criados, pode seguir a lógica do nome do evento podendo colocar Orc porém na invasão vai ter orc, orc shaman, orc spear etc...
-- Time = Tempo que a invasão vai durar caso colocar time = 10 a invasão vai durar 10 minutos depois de 10 minutos os monstros restantes serão removidos

<![CDATA[
days = {
-- Segunda
["Monday"] = {
["10:32"] = {nome = "renegados", pos = {fromPosition = {x=1011, y=910, z=7},toPosition = {x=1024, y=915, z=7}}, m = {"8 Renegade", "6 Bandit", "4 Shinobi Archer"}, Time = 1},
["22:00"] = {nome = "Dragon", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}},m = {"100 Dragon"}, Time = 20}
},
-- Terça
["Tuesday"] = {
["17:00"] = {nome = "Demon", pos = {fromPosition = {x=202, y=11, z=7},toPosition = {x=204, y=12, z=7}}, m = {"1 Demon"}, Time = 15},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
-- Quarta
["Wednesday"] = {
["17:00"] = {nome = "Demon", pos = {fromPosition = {x=202, y=11, z=7},toPosition = {x=204, y=12, z=7}}, m = {"1 Demon"}, Time = 15},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
-- Quinta
["Tursday"] = {
["17:00"] = {nome = "Demon", pos = {fromPosition = {x=202, y=11, z=7},toPosition = {x=204, y=12, z=7}}, m = {"1 Demon"}, Time = 15},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
-- Sexta
["Friday"] = {
["17:00"] = {nome = "Demon", pos = {fromPosition = {x=202, y=11, z=7},toPosition = {x=204, y=12, z=7}}, m = {"1 Demon"}, Time = 15},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
-- Sábado
["Saturday"] = {
["17:00"] = {nome = "Demon", pos = {fromPosition = {x=202, y=11, z=7},toPosition = {x=204, y=12, z=7}}, m = {"1 Demon"}, Time = 15},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
-- Domingo
["Sunday"] = {
["10:05"] = {nome = "renegados", pos = {fromPosition = {x=1011, y=910, z=7},toPosition = {x=1024, y=915, z=7}}, m = {"8 Renegade", "6 Bandit", "4 Shinobi Archer"}, Time = 1},
["22:00"] = {nome = "Hydra", pos = {fromPosition = {x=197, y=57, z=7},toPosition = {x=203, y=60, z=7}}, m = {"7 Hydra", "4 Cyclops"}, Time = 20}
},
}
]]></config>
<globalevent name="AutomaticRaids" interval="60" event="script"><![CDATA[
domodlib('raids_func')
function onThink(interval, lastExecution)	
	function isWalkable(pos) -- by Nord / editado por Omega
		if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then
			return false
		elseif isCreature(getTopCreature(pos).uid) then
			return false
		elseif getTileInfo(pos).protection then
			return false
		elseif hasProperty(getThingFromPos(pos).uid, 3) or hasProperty(getThingFromPos(pos).uid, 7) then
			return false
		end
		return true
	end
	
	if days[os.date("%A")] then
		hours = tostring(os.date("%X")):sub(1, 5)
		tb = days[os.date("%A")][hours]
		if tb then
			function removeCreature(tb)
				for x = ((tb.pos.fromPosition.x)-20), ((tb.pos.toPosition.x)+20) do
					for y = ((tb.pos.fromPosition.y)-20), ((tb.pos.toPosition.y)+20) do
						local m = getTopCreature({x=x, y=y, z= tb.pos.fromPosition.z}).uid
						if m ~= 0 and isMonster(m) then
							doSendMagicEffect(getCreaturePosition(m), 54) -- Efeito no monstro quando for removido
							doSendMagicEffect(getCreaturePosition(m), 3) -- Efeito no monstro quando for removido
							doRemoveCreature(m)
						end
					end
				end
			end
			doBroadcastMessage("Uma orda de " .. tb.nome .. " esta invadindo a cidade ajude a defende-la") -- Mensagem que vai aparecer para todos do servidor quando a invasão iniciar
			for _ , x in pairs(tb.m) do
				local c = tonumber(x:match("%d+"))
				if c > 0 then
					repeat
						local pos = {x = math.random(tb.pos.fromPosition.x, tb.pos.toPosition.x), y = math.random(tb.pos.fromPosition.y, tb.pos.toPosition.y), z = tb.pos.fromPosition.z}
						if isWalkable(pos) then
							doCreateMonster(x:match("%s(.+)"), pos)
							local pos2 = {x=pos.x+1, y=pos.y+0, z=pos.z+0}
							doSendMagicEffect(pos2, 111) -- Efeito no monstro quando ele nascer
							doSendMagicEffect(pos, 621) -- Efeito no monstro quando ele nascer
							c = c-1 
						end
					until c == 0
				end
			end
			addEvent(removeCreature, tb.Time*60*1000, tb)
			addEvent(doBroadcastMessage, tb.Time*60*1000, "A invas�o de " .. tb.nome .. " acabou, os sobreviventes fugiram") -- Mensagem que vai aparecer para todos do servidor quando a invasão iniciar
		end
	end
	return true
end
]]></globalevent>
</mod>