Config = {}

Config.AbertoAll = true
Config.TotalGaragem = 3
Config.Veiculos = {
    {
        categoria = {title = "Comum", id = "comum"},
        veiculos = {
            {title = "panto", model = "panto", mala = 10, preco = 10000, estoque = 300},
            {title = "rhapsody", model = "rhapsody", mala = 20, preco = 12000, estoque = 200},
            {title = "prairie", model = "prairie", mala = 30, preco = 15000, estoque = 200},
            {title = "f620", model = "f620", mala = 25, preco = 25000, estoque = 200},
            --
            {title = "zion", model = "zion", mala = 30, preco = 30000, estoque = 50},
            {title = "asea", model = "asea", mala = 30, preco = 30000, estoque = 50},
            {title = "brioso", model = "brioso", mala = 20, preco = 40000, estoque = 50},
            {title = "vigero", model = "vigero", mala = 15, preco = 45000, estoque = 50},
            --
            {title = "picador", model = "picador", mala = 80, preco = 55000, estoque = 50}, -- Aumentar báu para 80kg
            {title = "asterope", model = "asterope", mala = 25, preco = 55000, estoque = 50},
            {title = "alpha", model = "alpha", mala = 20, preco = 58000, estoque = 50},
            {title = "jackal", model = "jackal", mala = 40, preco = 62000, estoque = 50},
            --
            {title = "exemplar", model = "exemplar", mala = 30, preco = 68000, estoque = 50},
            {title = "oracle2", model = "oracle2", mala = 30, preco = 74000, estoque = 50},
            {title = "buffalo2", model = "buffalo2", mala = 20, preco = 80000, estoque = 50},
            {title = "cognoscenti", model = "cognoscenti", mala = 40, preco = 85000, estoque = 50},
            --
            {title = "ruston", model = "ruston", mala = 10, preco = 102000, estoque = 50},
            {title = "gauntlet", model = "gauntlet", mala = 25, preco = 110000, estoque = 50},
            {title = "futo", model = "futo", mala = 25, preco = 115000, estoque = 50},
            --                                                             
            {title = "massacro", model = "massacro", mala = 10, preco = 115000, estoque = 50},
            {title = "dominator", model = "dominator", mala = 25, preco = 125000, estoque = 50},
            {title = "jester", model = "jester", mala = 10, preco = 130000, estoque = 50},
            {title = "dominator3", model = "dominator3", mala = 20, preco = 138000, estoque = 50},
            --
            {title = "kuruma", model = "kuruma", mala = 30, preco = 150000, estoque = 50},
            {title = "raiden", model = "raiden", mala = 40, preco = 170000, estoque = 50},
            {title = "ninef", model = "ninef", mala = 10, preco = 175000, estoque = 50},
            {title = "neon", model = "neon", mala = 25, preco = 180000, estoque = 50},
            --
            {title = "sentinel3", model = "sentinel3", mala = 25, preco = 195000, estoque = 50},
            {title = "sultanrs", model = "sultanrs", mala = 25, preco = 198000, estoque = 50},
            {title = "bullet", model = "bullet", mala = 10, preco = 200000, estoque = 50},
            {title = "khamelion", model = "khamelion", mala = 10, preco = 202000, estoque = 50},
            --                                                                                                                                           
            {title = "rapidgt", model = "rapidgt", mala = 15, preco = 220000, estoque = 50},
            {title = "furoregt", model = "furoregt", mala = 10, preco = 235000, estoque = 50},
        },
    },
    {
        categoria = {title = "Importado", id = "importado"},
        veiculos = {
            {title = "Nissan 180SX (Drift)", model = "180sx", mala = 20, preco = 600000, estoque = 10},
            {title = "Dodge Charger", model = "defiant", mala = 20, preco = 650000, estoque = 10},
            {title = "Plymouth GTX", model = "71gtx", mala = 20, preco = 750000, estoque = 10},
            {title = "Mustang Mach 1", model = "mustangmach1", mala = 0, preco = 850000, estoque = 10},
            --  
            {title = "Porsche 930", model = "porsche930", mala = 10, preco = 950000, estoque = 10},
            {title = "Mitsubishi Eclipse", model = "eclipse", mala = 0, preco = 1150000, estoque = 10},
            {title = "Civic Type R", model = "hondafk8", mala = 30, preco = 1200000, estoque = 10},
            {title = "Mazda RX7", model = "mazdarx7", mala = 10, preco = 1300000, estoque = 10},
            --
            {title = "Lancer Evolution 9", model = "lancerevolution9", mala = 20, preco = 1400000, estoque = 15},
            {title = "Toyota Supra", model = "toyotasupra", mala = 0, preco = 1500000, estoque = 20},
            {title = "Nissan 370Z", model = "nissan370z", mala = 0, preco = 1600000, estoque = 10},
            {title = "Nissan GTR", model = "nissangtr", mala = 10, preco = 1700000, estoque = 10},
            --
            {title = "focus RS", model = "focusrs", mala = 10, preco = 1800000, estoque = 10},
            {title = "Tesla Prior", model = "teslaprior", mala = 30, preco = 1900000, estoque = 10},
            {title = "Ford Raptor", model = "raptor2017", mala = 80, preco = 2000000, estoque = 10},
            {title = "amarok", model = "amarok", mala = 80, preco = 2100000, estoque = 10},
            --  
            {title = "Aston Martin DB11", model = "db11", mala = 10, preco = 2150000, estoque = 10},
            {title = "Mercedes AMG C63-S", model = "rmodamgc63", mala = 20, preco = 2250000, estoque = 10},
            {title = "Camaro ZL1", model = "2018zl1", mala = 10, preco = 2300000, estoque = 10},
            {title = "Ford Mustang GT", model = "fordmustang", mala = 10, preco = 2300000, estoque = 10},
            --    
            {title = "Mercedes AMG A45", model = "mercedesa45", mala = 20, preco = 2350000, estoque = 10},
            {title = "Porsche Panamera", model = "palameila", mala = 30, preco = 2450000, estoque = 10},
            {title = "Audi RS7", model = "audirs7", mala = 40, preco = 2550000, estoque = 10},
            {title = "Audi RS6", model = "audirs6", mala = 40, preco = 2550000, estoque = 10},
            --
            {title = "Jaguar F-type", model = "19ftype", mala = 20, preco = 2650000, estoque = 10},
            {title = "Ford GT", model = "gt17", mala = 0, preco = 2750000, estoque = 10},
            {title = "Porsche 911R", model = "911r", mala = 0, preco = 2950000, estoque = 10},
            {title = "Ferrari California", model = "fc15", mala = 20, preco = 3000000, estoque = 10},

            -- RMOD
            {title = "Chevrolet Camaro ZL1 Widebody", model = "rmodzl1", mala = 20, preco = 2500000, estoque = 10},
            {title = "Chevrolet Camaro ZL1", model = "rmodcamaro", mala = 20, preco = 2300000, estoque = 10},
            {title = "Nissan 350Z RB", model = "rmodz350pandem", mala = 20, preco = 1500000, estoque = 10},
            {title = "Mercedes-AMG E63 S", model = "rmode63s", mala = 20, preco = 2000000, estoque = 10},
            {title = "Bentley Continental GT", model = "rmodbentleygt", mala = 20, preco = 1100000, estoque = 10},
            {title = "VW Golf MK7 Pandem", model = "rmodmk7", mala = 20, preco = 1400000, estoque = 10},
            {title = "McLaren Speedtail", model = "rmodspeed", mala = 20, preco = 1100000, estoque = 10},
            {title = "Aston Martin DBS Superleggera", model = "rmodmartin", mala = 20, preco = 2200000, estoque = 10},
            {title = "Bentley Continental GT", model = "rmodbentley1", mala = 20, preco = 1250000, estoque = 10},
            {title = "BMW M5 E34", model = "rmodm5e34", mala = 20, preco = 1500000, estoque = 10},
            {title = "LEXUS LFA", model = "rmodlfa", mala = 20, preco = 1100000, estoque = 10},
            {title = "Jeep Grand Cherokee", model = "rmodjeep", mala = 20, preco = 2500000, estoque = 10},
            {title = "Bentley Mulliner", model = "rmodbacalar", mala = 20, preco = 1250000, estoque = 10},
        },
    },
    {
        categoria = {title = "VIP", id = "vip"},
        veiculos = {
            {title = "lamborghinihuracan", model = "lamborghinihuracan", mala = 100, preco = 1, estoque = 0},
            {title = "corvette", model = "corvette", mala = 100, preco = 1, estoque = 0},
            {title = "nissangtrnismo", model = "nissangtrnismo", mala = 100, preco = 1, estoque = 0},
            {title = "nissanskyliner34", model = "nissanskyliner34", mala = 100, preco = 1, estoque = 0},
            {title = "nissantitan17", model = "nissantitan17", mala = 100, preco = 1, estoque = 0},
            {title = "porsche992", model = "porsche992", mala = 100, preco = 1, estoque = 0},
            {title = "msohs", model = "msohs", mala = 100, preco = 1, estoque = 0},
            {title = "amggtr", model = "amggtr", mala = 100, preco = 1, estoque = 0},
            {title = "fxxkevo", model = "fxxkevo", mala = 100, preco = 1, estoque = 0},
            {title = "aperta", model = "aperta", mala = 100, preco = 1, estoque = 0},
            {title = "lp700r", model = "lp700r", mala = 100, preco = 1, estoque = 0},
            {title = "i8", model = "i8", mala = 100, preco = 1, estoque = 0},
            {title = "bc", model = "bc", mala = 100, preco = 1, estoque = 0},
            {title = "slsamg", model = "slsamg", mala = 100, preco = 1, estoque = 0},
            {title = "veneno", model = "veneno", mala = 100, preco = 1, estoque = 0},
            {title = "bugatti", model = "bugatti", mala = 100, preco = 1, estoque = 0},
            {title = "lancerevolutionx", model = "lancerevolutionx", mala = 100, preco = 1, estoque = 0},
            {title = "r1", model = "r1", mala = 100, preco = 1, estoque = 0},
            {title = "bmws", model = "bmws", mala = 100, preco = 1, estoque = 0},
            {title = "r1250", model = "r1250", mala = 100, preco = 1, estoque = 0},
            {title = "ferrariitalia", model = "ferrariitalia", mala = 100, preco = 1, estoque = 0},
            {title = "BMW i8 Coupe", model = "rmodi8ks", mala = 100, preco = 1, estoque = 0},
            {title = "BMW EVO i8 Dark", model = "rmoddarki8", mala = 100, preco = 1, estoque = 0},
            {title = "Mercedes-Benz G65", model = "rmodg65", mala = 100, preco = 1, estoque = 0},
            {title = "Lamborghini LP670", model = "rmodlp670", mala = 100, preco = 1, estoque = 0},
            {title = "Audi RS6 C8", model = "rmodrs6", mala = 100, preco = 1, estoque = 0},
            {title = "Lamborghini Sian", model = "rmodsianr", mala = 100, preco = 1, estoque = 0},
            {title = "Toyota GR Supra", model = "rmodsuprapandem", mala = 100, preco = 1, estoque = 0},
            {title = "Mercedes-AMG C63", model = "rmodc63amg", mala = 100, preco = 1, estoque = 0},
            {title = "Koenigsegg Jesko", model = "rmodjesko", mala = 100, preco = 1, estoque = 0},
            {title = "Mercedes-AMG GT 63S", model = "rmodgt63", mala = 100, preco = 1, estoque = 0},
            {title = "BMW M8 Competition", model = "rmodbmwm8", mala = 100, preco = 1, estoque = 0},
            {title = "Bugatti La Voiture", model = "rmodbugatti", mala = 100, preco = 1, estoque = 0},
            {title = "Bugatti Chiron Super", model = "rmodchiron300", mala = 100, preco = 1, estoque = 0},
            {title = "Ferrari F12 TDF", model = "rmodf12tdf", mala = 100, preco = 1, estoque = 0},
        },
    },
    {
        categoria = {title = "Edição Especial", id = "edicaoespecial"},
        veiculos = {
            {title = "Lancer Evolution IX", model = "evo9", mala = 150, preco = 1, estoque = 0},
            {title = "Nissan 240SX", model = "rmod240sx", mala = 150, preco = 1, estoque = 0},
            {title = "Bugatti Bolide", model = "rmodbolide", mala = 150, preco = 1, estoque = 0},
            {title = "Dodge Charger 69", model = "rmodcharger69", mala = 150, preco = 1, estoque = 0},
            {title = "Escort RS Cosworth", model = "rmodescort", mala = 150, preco = 1, estoque = 0},
            {title = "Ferrari F40", model = "rmodf40", mala = 150, preco = 1, estoque = 0},
            {title = "Nissan GT R50", model = "rmodgtr50", mala = 150, preco = 1, estoque = 0},
            {title = "BMW M8 GTE", model = "rmodm8gte", mala = 150, preco = 1, estoque = 0},
            {title = "Nissan Skyline R34", model = "rmodskyline34", mala = 150, preco = 1, estoque = 0},
            {title = "Nissan Skyline R34 Japan", model = "skyline", mala = 150, preco = 1, estoque = 0},
        },
    },
    -- {
    --     categoria = {title = "Brasileiro", id = "brasileiro"},
    --     veiculos = {
    --         -- {title = "Fusca", model = "weevil", mala = 10, preco = 70000, estoque = 5},
    --         {title = "Fiat 500", model = "brioso2", mala = 10, preco = 70000, estoque = 5},
    --         --
    --         {title = "chevette", model = "chevette", mala = 10, preco = 85000, estoque = 5},
    --         {title = "Palio", model = "fugitive", mala = 10, preco = 100000, estoque = 5},
    --         {title = "GOL-S", model = "blista", mala = 20, preco = 130000, estoque = 5},
    --         {title = "Voyage", model = "blista3", mala = 10, preco = 160000, estoque = 5},
    --         {title = "Celta", model = "celta", mala = 0, preco = 180000, estoque = 5},
    --         --
    --         {title = "civic 2010", model = "civic2010", mala = 10, preco = 210000, estoque = 5},
    --         {title = "Golf", model = "vwgolf", mala = 20, preco = 240000, estoque = 5},
    --         {title = "Saveiro", model = "vwsava", mala = 30, preco = 270000, estoque = 5},
    --         {title = "civic 2016", model = "civic2016", mala = 20, preco = 300000, estoque = 5},
    --     },
    -- },
    {
        categoria = {title = "Diamond", id = "diamond"},
        veiculos = {
            {title = "Asbo", model = "asbo", mala = 10, preco = 180000, estoque = 10},
            {title = "Kanjo", model = "kanjo", mala = 10, preco = 220000, estoque = 10},
            {title = "Retinue2", model = "retinue2", mala = 10, preco = 250000, estoque = 10},
            {title = "Nebula", model = "nebula", mala = 10, preco = 275000, estoque = 10},
            --
            {title = "Zion3", model = "zion3", mala = 10, preco = 290000, estoque = 10},
            {title = "Hellion", model = "hellion", mala = 40, preco = 300000, estoque = 10},
            {title = "Yosemite2", model = "yosemite2", mala = 10, preco = 300000, estoque = 10},
            {title = "Issi7", model = "issi7", mala = 20, preco = 300000, estoque = 10},
            --
            {title = "Gauntlet4", model = "gauntlet4", mala = 20, preco = 400000, estoque = 10},
            {title = "Novak", model = "novak", mala = 40, preco = 460000, estoque = 10},
            {title = "Dynasty", model = "dynasty", mala = 20, preco = 460000, estoque = 10},
            {title = "Rebla", model = "rebla", mala = 40, preco = 500000, estoque = 10},
            --
            {title = "Imorgon", model = "imorgon", mala = 10, preco = 500000, estoque = 10},
            {title = "Paragon", model = "paragon", mala = 10, preco = 550000, estoque = 10},
            {title = "Peyote", model = "peyote", mala = 10, preco = 560000, estoque = 10},
            {title = "Drafter", model = "drafter", mala = 30, preco = 600000, estoque = 10},
            --
            {title = "S80", model = "s80", mala = 0, preco = 600000, estoque = 10},
            {title = "Gauntlet5", model = "gauntlet5", mala = 10, preco = 640000, estoque = 10},
            {title = "Caracara2", model = "caracara2", mala = 60, preco = 650000, estoque = 10},
            {title = "Locust", model = "locust", mala = 10, preco = 650000, estoque = 10},
            --
            {title = "Komoda", model = "komoda", mala = 40, preco = 700000, estoque = 10},
            {title = "Sultan2", model = "sultan2", mala = 20, preco = 700000, estoque = 10},
            {title = "Everon", model = "everon", mala = 60, preco = 700000, estoque = 10},
            {title = "Neo", model = "neo", mala = 10, preco = 780000, estoque = 10},
            --
            {title = "Sugoi", model = "sugoi", mala = 30, preco = 800000, estoque = 10},
            {title = "Emerus", model = "emerus", mala = 10, preco = 800000, estoque = 10},
            {title = "Zorrusso", model = "zorrusso", mala = 10, preco = 800000, estoque = 10},
            {title = "Krieger", model = "krieger", mala = 10, preco = 800000, estoque = 10},
            --
            {title = "Thrax", model = "thrax", mala = 10, preco = 900000, estoque = 10},
            {title = "Vstr", model = "vstr", mala = 40, preco = 900000, estoque = 10},
            {title = "Furia", model = "furia", mala = 10, preco = 900000, estoque = 10},
            {title = "Jugular", model = "jugular", mala = 40, preco = 900000, estoque = 10},
        },
    },
    {
        categoria = {title = "Esportivo", id = "esportivo"},
        veiculos = {
            {title = "specter", model = "specter", mala = 10, preco = 235000, estoque = 10},
            {title = "elegy2", model = "elegy2", mala = 10, preco = 240000, estoque = 10},
            {title = "coquette", model = "coquette", mala = 10, preco = 245000, estoque = 10},
            {title = "gb200", model = "gb200", mala = 10, preco = 250000, estoque = 10},
            {title = "elegy", model = "elegy", mala = 20, preco = 260000, estoque = 10},
            --
            {title = "flashgt", model = "flashgt", mala = 15, preco = 280000, estoque = 10},
            {title = "comet2", model = "comet2", mala = 20, preco = 295000, estoque = 10}, -- Alterar bau pra 20 kg
            {title = "italigtb", model = "italigtb", mala = 0, preco = 295000, estoque = 10},
            {title = "reaper", model = "reaper", mala = 15, preco = 300000, estoque = 10},
            --                                                                                                                                             
            {title = "gp1", model = "gp1", mala = 10, preco = 305000, estoque = 10},
            {title = "turismor", model = "turismor", mala = 0, preco = 312000, estoque = 10},
            {title = "tyrant", model = "tyrant", mala = 10, preco = 315000, estoque = 10},
            --
            {title = "comet3", model = "comet3", mala = 20, preco = 340000, estoque = 10}, -- Novo | Alterar bau pra 20 kg
            {title = "cheetah", model = "cheetah", mala = 0, preco = 340000, estoque = 10},
            {title = "entityxf", model = "entityxf", mala = 0, preco = 345000, estoque = 10},
            {title = "sheava", model = "sheava", mala = 15, preco = 350000, estoque = 10},
            --                                                                                                                                             
            {title = "lynx", model = "lynx", mala = 20, preco = 355000, estoque = 10},
            {title = "bestiagts", model = "bestiagts", mala = 35, preco = 380000, estoque = 10},
            {title = "banshee", model = "banshee", mala = 15, preco = 390000, estoque = 10},
            {title = "comet5", model = "comet5", mala = 20, preco = 390000, estoque = 10}, -- Novo | Alterar bau pra 20 kg
            --
            {title = "taipan", model = "taipan", mala = 10, preco = 395000, estoque = 10},
            {title = "entity2", model = "entity2", mala = 10, preco = 400000, estoque = 10},
            {title = "pariah", model = "pariah", mala = 20, preco = 410000, estoque = 10},
            {title = "vacca", model = "vacca", mala = 10, preco = 410000, estoque = 10},
            --                                                                                                                                           
            {title = "seven70", model = "seven70", mala = 10, preco = 412000, estoque = 10},
            {title = "t20", model = "t20", mala = 10, preco = 420000, estoque = 10},
            {title = "pfister811", model = "pfister811", mala = 10, preco = 438000, estoque = 10},
            {title = "osiris", model = "osiris", mala = 10, preco = 440000, estoque = 10},
            --
            {title = "banshee2", model = "banshee2", mala = 15, preco = 440000, estoque = 10},
            {title = "vagner", model = "vagner", mala = 0, preco = 448000, estoque = 10},
            {title = "tempesta", model = "tempesta", mala = 10, preco = 450000, estoque = 10},
            {title = "xa21", model = "xa21", mala = 15, preco = 455000, estoque = 10},
            --
            {title = "cyclone", model = "cyclone", mala = 0, preco = 460000, estoque = 10},
            {title = "nero", model = "nero", mala = 15, preco = 475000, estoque = 10},
            {title = "visione", model = "visione", mala = 0, preco = 480000, estoque = 10},
            {title = "deveste", model = "deveste", mala = 0, preco = 490000, estoque = 10},
            --
            {title = "prototipo", model = "prototipo", mala = 0, preco = 500000, estoque = 10},
            {title = "adder", model = "adder", mala = 10, preco = 530000, estoque = 10},
            {title = "italigto", model = "italigto", mala = 15, preco = 590000, estoque = 10},
            {title = "zentorno", model = "zentorno", mala = 15, preco = 590000, estoque = 10},
            {title = "italirsx", model = "italirsx", mala = 15, preco = 700000, estoque = 10}, -- Adicionar 15kg de bau

        },
    },
    {
        categoria = {title = "Conversível", id = "conversivel"},
        veiculos = {
            {title = "Issi2", model = "issi2", mala = 20, preco = 80000, estoque = 10},
            {title = "ninef2", model = "ninef2", mala = 0, preco = 185000, estoque = 10}, -- Novo - atualizar baú pra 0
            {title = "sentinel2", model = "sentinel2", mala = 30, preco = 190000, estoque = 10}, -- Novo - atualizar baú pra 30
            {title = "cogcabrio", model = "cogcabrio", mala = 30, preco = 210000, estoque = 10},
            --
            {title = "Rapidgt2", model = "rapidgt2", mala = 20, preco = 240000, estoque = 10}, -- Novo
            {title = "Surano", model = "surano", mala = 20, preco = 255000, estoque = 10}, -- atualizar baú pra 20
            {title = "Carbonizzare", model = "carbonizzare", mala = 20, preco = 260000, estoque = 10}, -- atualizar baú pra 20
            {title = "Windsor2", model = "windsor2", mala = 30, preco = 275000, estoque = 10}, -- Novo - atualizar baú pra 30                                                             
        },
    },
    {
        categoria = {title = "SUV", id = "suv"},
        veiculos = {
            --                                                           
            {title = "rocoto", model = "rocoto", mala = 50, preco = 370000, estoque = 10},
            {title = "patriot", model = "patriot", mala = 25, preco = 400000, estoque = 10},
            {title = "granger", model = "granger", mala = 50, preco = 400000, estoque = 10}, -- Novo (atualizar baú pra 50)
            {title = "huntley", model = "huntley", mala = 50, preco = 430000, estoque = 10},
            --
            {title = "stretch", model = "stretch", mala = 60, preco = 450000, estoque = 10}, -- Novo
            {title = "dubsta2", model = "dubsta2", mala = 70, preco = 470000, estoque = 10}, -- atualizar baú pra 50
            {title = "xls", model = "xls", mala = 60, preco = 490000, estoque = 10},
            {title = "patriot2", model = "patriot2", mala = 50, preco = 500000, estoque = 10},
            --
            {title = "baller4", model = "baller4", mala = 60, preco = 520000, estoque = 10}, -- atualizar baú pra 60
            {title = "toros", model = "toros", mala = 60, preco = 600000, estoque = 10}, -- atualizar baú pra 60
            {title = "mesa3", model = "mesa3", mala = 60, preco = 640000, estoque = 10},
            {title = "contender", model = "contender", mala = 70, preco = 670000, estoque = 10}, -- Novo
            --                                                                                                                                                                                                              
            {title = "dubsta3", model = "dubsta3", mala = 70, preco = 690000, estoque = 10}, -- Novo 
            {title = "kamacho", model = "kamacho", mala = 80, preco = 720000, estoque = 10}, -- Novo - atualizar baú pra 80
            {title = "guardian", model = "guardian", mala = 100, preco = 750000, estoque = 10},
        },
    },
    {
        categoria = {title = "Clássico", id = "classico"},
        veiculos = {
            {title = "ellie", model = "ellie", mala = 20, preco = 180000, estoque = 10},
            {title = "blade", model = "blade", mala = 20, preco = 180000, estoque = 10},
            {title = "chino2", model = "chino2", mala = 20, preco = 180000, estoque = 10}, -- atualizar baú pra 20
            {title = "faction2", model = "faction2", mala = 20, preco = 180000, estoque = 10},
            --
            {title = "buccaneer", model = "buccaneer", mala = 20, preco = 180000, estoque = 10}, -- atualizar baú pra 20
            {title = "buccaneer2", model = "buccaneer2", mala = 20, preco = 180000, estoque = 10},
            {title = "tampa", model = "tampa", mala = 20, preco = 210000, estoque = 10}, -- atualizar baú pra 20 
            {title = "dukes", model = "dukes", mala = 20, preco = 240000, estoque = 10},
            --
            {title = "tulip", model = "tulip", mala = 20, preco = 260000, estoque = 10},
            {title = "hustler", model = "hustler", mala = 20, preco = 290000, estoque = 10}, -- atualizar baú pra 20
            {title = "stafford", model = "stafford", mala = 20, preco = 320000, estoque = 10}, -- atualizar baú pra 20
            {title = "coquette3", model = "coquette3", mala = 20, preco = 350000, estoque = 10}, -- atualizar baú pra 20                                                             
        },
    },
    {
        categoria = {title = "Blindado", id = "blindado"},
        veiculos = {
            {title = "Cognoscenti2", model = "cognoscenti2", mala = 30, preco = 850000, estoque = 10}, -- Novo - atualizar baú pra 30                                             
            {title = "Cog552", model = "cog552", mala = 30, preco = 850000, estoque = 10}, -- Novo - atualizar baú pra 30
            {title = "Schafter6", model = "schafter6", mala = 30, preco = 850000, estoque = 10}, -- Novo - atualizar baú pra 30 | Adicionar na base (0x72934BE4) 
            {title = "XLS2", model = "xls2", mala = 50, preco = 900000, estoque = 10}, -- Novo -
            {title = "Baller6", model = "baller6", mala = 50, preco = 900000, estoque = 10}, -- Novo -
            {title = "Rumpo3", model = "rumpo3", mala = 100, preco = 1000000, estoque = 10}, -- Novo - atualizar baú pra 100
        },
    },
    {
        categoria = {title = "Van", id = "van"},
        veiculos = {
            {title = "surfer2", model = "surfer2", mala = 70, preco = 100000, estoque = 5}, -- Novo | Atualizar baú para 70 | Adicionar na base (0xB1D80E06)
            {title = "surfer", model = "surfer", mala = 80, preco = 150000, estoque = 5}, -- Novo | Atualizar baú para 80
            {title = "youga2", model = "youga2", mala = 100, preco = 220000, estoque = 5}, -- Novo | atualizar baú pra 100
            {title = "speedo", model = "speedo", mala = 100, preco = 280000, estoque = 5}, -- Novo
            {title = "gburrito2", model = "gburrito2", mala = 100, preco = 320000, estoque = 5}, -- Novo | atualizar baú pra 100 | Adicionar na base (0x11AA0E14)
        },
    },
    {
        categoria = {title = "Caminhão", id = "caminhao"},
        veiculos = {
            {title = "Mule2", model = "mule2", mala = 500, preco = 1500000, estoque = 10}, -- Novo | atualizar baú pra 500
            {title = "Benson", model = "benson", mala = 750, preco = 2000000, estoque = 10}, -- Novo | atualizar baú pra 750
            {title = "Pounder", model = "pounder", mala = 1000, preco = 2500000, estoque = 10}, -- Novo | atualizar baú pra 1000
        },
    },
    {
        categoria = {title = "Moto", id = "moto"},
        veiculos = {
            {title = "biz25", model = "biz25", mala = 15, preco = 30000, estoque = 50},
            {title = "150", model = "150", mala = 10, preco = 50000, estoque = 50},
            {title = "bros60", model = "bros60", mala = 0, preco = 150000, estoque = 50},
            --
            {title = "zombiea", model = "zombiea", mala = 0, preco = 200000, estoque = 50},
            {title = "gargoyle", model = "gargoyle", mala = 10, preco = 200000, estoque = 50},
            {title = "daemon", model = "daemon", mala = 10, preco = 200000, estoque = 50},
            {title = "chimera", model = "chimera", mala = 10, preco = 200000, estoque = 50},
            --
            {title = "manchez", model = "manchez", mala = 0, preco = 200000, estoque = 50},
            {title = "enduro", model = "enduro", mala = 0, preco = 200000, estoque = 50},
            {title = "double", model = "double", mala = 10, preco = 250000, estoque = 50},
            {title = "carbonrs", model = "carbonrs", mala = 10, preco = 250000, estoque = 50},
            --
            {title = "sanchez2", model = "sanchez2", mala = 0, preco = 250000, estoque = 50},
            {title = "sanchez", model = "sanchez", mala = 05, preco = 250000, estoque = 50},
            {title = "bf400", model = "bf400", mala = 05, preco = 300000, estoque = 50},
            {title = "bati2", model = "bati2", mala = 10, preco = 320000, estoque = 50},
            --
            {title = "bati", model = "bati", mala = 10, preco = 320000, estoque = 50},
            {title = "akuma", model = "akuma", mala = 10, preco = 330000, estoque = 50},
            {title = "hakuchou", model = "hakuchou", mala = 10, preco = 340000, estoque = 50},
            {title = "hakuchou2", model = "hakuchou2", mala = 05, preco = 350000, estoque = 50},
            --
            {title = "xt66", model = "xt66", mala = 0, preco = 500000, estoque = 10},
            {title = "hornet", model = "hornet", mala = 0, preco = 1000000, estoque = 10},
            --
            {title = "cbrr", model = "cbrr", mala = 0, preco = 1150000, estoque = 10},
            {title = "r6", model = "r6", mala = 0, preco = 1250000, estoque = 10},
            {title = "z1000", model = "z1000", mala = 0, preco = 1300000, estoque = 10},
            {title = "dm1200", model = "dm1200", mala = 0, preco = 1500000, estoque = 10},
        },
    },
}
function getVeiculo(modelo)
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do
            if carro.model == modelo then
                return carro
            end
        end
    end
end

function getVeiculos()
    local veiculos = {}
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do
            veiculos[carro.model] = carro
        end
    end

    return veiculos
end
