xD = {

	coords = {
		{['x'] = 235.61, ['y'] = -984.92, ['z'] = -98.99, heading = 96.0},
		{['x'] = 139.21, ['y'] = -1708.96, ['z'] = 29.30, heading = 50.0},
		{['x'] = -1282.00, ['y'] = -1118.86, ['z'] = 7.00, heading = 0.0},
		{['x'] = 1934.11,['y'] = 3730.73,['z'] = 32.85, heading = 122.50},
		{['x'] = 1211.07,['y'] = -475.00,['z'] = 66.21, heading = 341.18},
		{['x'] = -34.97,['y'] = -150.90,['z'] = 57.08, heading = 253.45},
		{['x'] = -280.37,['y'] = 6227.01,['z'] = 31.70, heading = 315.70},
		{['x'] = 108.13,['y'] = -1305.57,['z'] = 28.77, heading = 20.0},
		{['x'] = -1620.1,['y'] = -3017.8,['z'] = -75.2, heading = 96.0},
		{['x'] =-813.0,['y'] = 173.35,['z'] = 76.75, heading = 117.10},
		{['x'] = -1805.02,['y'] = 435.8,['z'] = 107.22, heading = 0.0},
		{['x'] = -2985.43,['y'] = 693.1,['z'] = 10.76, heading = 287.0},
		{['x'] = -1100.84,['y'] = 446.33,['z'] = 60.17, heading = 260.0},
		{['x'] =-2582.29,['y'] = 1893.54,['z'] = 140.88, heading = 195.0},
		{['x'] =392.9,['y'] = 279.24,['z'] = 95.0, heading = 96.0},
		{['x'] =-571.99,['y'] = -202.49,['z'] = 42.71, heading = 32.0},
		{['x'] =-3207.5,['y'] = 782.63,['z'] = 14.09, heading = 215.0},
		{['x'] =-1725.22,['y'] = 372.55,['z'] = 78.47, heading = 206.0},
		{['x'] =-893.99, ['y'] = 47.98,['z'] = 36.71, heading = 53.0},
		{['x'] =-1473.89,['y'] = -37.93,['z'] = 44.5, heading = 308.0},
		{['x'] =-1981.9,['y'] = -499.5,['z'] = 20.74, heading = 230.0},
		{['x'] =129.91,['y'] = -756.88,['z'] = 242.16, heading = 70.0},
	}, -- Coordenadas dos blips.

	blockedItems = {
        ['M'] = {
            [0] = {}, -- defeitos
			[1] = {}, -- barba
			[2] = {}, -- sombrancelhas
			[3] = {}, -- envelhecimento
			[4] = {}, -- maquiagem
			[5] = {}, -- blush
			[6] = {}, -- rugas
			[8] = {}, -- batom
			[9] = {}, -- sardas
			[10] = {}, -- peito
			[12] = {}, -- cabelo
        },
        ['F'] = {
			[0] = {},
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = {},
			[6] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[12] = {},
        },
    }, -- Itens para remover da NUI

	
	parts = {
		defeitos = {"blemishesModel",0,opacity = "blemishesOpacity"},
		barba = {"beardModel",1,color = "beardColor",opacity = "beardOpacity"},
		sombrancelhas = {"eyebrowsModel",2,color = "eyebrowsColor",opacity = "eyebrowsOpacity"},
		envelhecimento = {"ageingModel",3,opacity = "ageingOpacity"},
		maquiagem = {"makeupModel",4,opacity = "makeupOpacity"},
		blush = {"blushModel",5,color = "blushColor",opacity = "blushOpacity"},
		rugas = {"complexionModel",6,opacity = "complexionOpacity"},
		batom = {"lipstickModel",8,color = "lipstickColor",opacity = "lipstickOpacity"},
		sardas = {"frecklesModel",9,opacity = "frecklesOpacity"},
		peito = {"chestModel",10,color = "chestColor",opacity = "chestOpacity"},
		cabelo = {"hairModel",12,color = "firstHairColor",secColor = "secondHairColor"},
	}, -- Alterações que aparecerão na NUI(pode remover caso não queira alguma)

	command = "openbarber", -- Comando para abrir a NUI, sem estar no blip.

	perm = "admin.permissao", -- Permissão para abrir por comando

	imgsIp = "131.196.198.119:3554", -- Local onde as imagens serão upadas.

}