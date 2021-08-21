Config = {}

Config.ComandoSair = 'sairpvp'  -- NOME DO COMANDO PARA SAIR DO MODO PVP

Config.LocalSaida = {
    vector3(1729.689453125,3297.0339355469,41.223472595215), -- CORDENADA QUE O PLAYER VAI QUANDO USA O COMANDO DE SAIR DO PVP
}

Config.bliplocal = {
    { 1730.6500244141,3308.9821777344,41.223449707031 }   -- LOCAL DO BLIP DE ENTRADA
}


Config.bliptext = 'PRESSIONE ~r~E~w~ PARA ENTRAR NA ~r~ARENA FENIX PVP~w~\n VALOR DE ENTRADA: ~r~1 TICKET PVP'  -- TEXTO QUE APARECE AO CHEGAR PERTO DO BLIP


Config.spawnCoords = {
    [1] = { ['x'] = 2360.43, ['y'] = 3126.18, ['z'] = 48.21 },
    [2] = { ['x'] = 2366.56, ['y'] = 3157.83, ['z'] = 48.21 },
    [3] = { ['x'] = 2402.39, ['y'] = 3136.97, ['z'] = 48.16 },
    [4] = { ['x'] = 2432.1, ['y'] = 3095.41, ['z'] = 48.35 },
    [5] = { ['x'] = 2398.97, ['y'] = 3052.36, ['z'] = 48.16 },
    [6] = { ['x'] = 2353.12, ['y'] = 3055.89, ['z'] = 48.16 },
    [7] = { ['x'] = 2335.32, ['y'] = 3120.24, ['z'] = 48.21 },
}

Config.QuantidadeCords = 7  -- ALTERAR AQUI CASO ALTERE O NUMERO DE CORDENDAS DE SPAWN

Config.Armas = { -- ARENA PVP PISTOL
    [1] = 'WEAPON_PISTOL_MK2',
    [2] = 'WEAPON_PISTOL',
    [3] = 'WEAPON_COMBATPISTOL',
    [4] = 'WEAPON_SNSPISTOL',
    [5] = '',
    [6] = '',
    [7] = '',
    [8] = '',
    [9] = '',
    [10] = '',
    [11] = '',
    [12] = '',
}

Config.Armas2 = { -- ARENA PVP FUZIL
    [1] = 'WEAPON_CARBINERIFLE_MK2',
    [2] = 'WEAPON_CARBINERIFLE',
    [3] = 'WEAPON_SPECIALCARBINE',
    [4] = 'WEAPON_ASSAULTRIFLE_MK2',
    [5] = 'WEAPON_SPECIALCARBINE_MK2',
    [6] = 'WEAPON_SMG_MK2',
    [7] = '',
    [8] = '',
    [9] = '',
    [10] = '',
    [11] = '',
    [12] = '',
}

Config.ItemCobrado = 'ticketpvp'  -- NOME DO ITEM COBRADO

Config.ValorCobrado = 1   -- VALOR DO ITEM COBRADO

Config.MensagemEntrada = 'Você entrou no <b> Modo PvP</b> com sucesso!'  -- MENSAGEM DE NOTIFICAÇÃO QUANDO O PLAYER ENTRA NO PVP

Config.MensagemSemItem = 'Você <b>não</b> tem a quantidade necessária do item!' -- MENSAGEM DE NOTIFICAO SE O PLAYER NAO TIVER A QUANTIDADE NECESSARIA DO ITEM PARA ENTRAR NO PVP

Config.MsgConfirmar = 'Para entrar, você perderá suas armas atuais caso tenha. Deseja confirmar a entrada?'

Config.MsgArena = 'Digite "1" para ir para Arena de Pistola. Digite "2" para ir para a Arena de Fuzil'