.nds
.thumb

.include "armips/include/animscriptcmd.s"

.include "asm/include/abilities.inc"
.include "asm/include/items.inc"
.include "asm/include/species.inc"
.include "asm/include/moves.inc"

// ---------------------------------------------------------------
// Animacion de BRILLO SOLAR (MOVE_BRILLO_SOLAR, 923)
//
//  1. El fondo se tine de dorado calido.
//  2. Aparece un sol radiante sobre el campo (particulas de Dia Soleado).
//  3. Un destello de luz cae sobre el rival (particulas de Brillo Magico).
//  4. El rival brilla en dorado y tiembla por el impacto.
//  5. Todo vuelve a la normalidad.
//
// Colores en formato BGR555 de la DS:
//   13311 = dorado calido (el mismo tono que usa Rayo Solar)
// ---------------------------------------------------------------

.create "build/move/move_anim/0_923", 0

a010_923:
    // --- carga de particulas: slot 0 = sol (spa 259), slot 1 = destello (spa 426)
    initspriteresource
    loadspriteresource 0
    loadspriteresource 1
    loadspriteresource 2
    loadspriteresource 3
    loadspritemaybe 4, 0, 0, 0
    loadspritemaybe 5, 0, 1, 1
    loadspritemaybe 6, 0, 2, 2
    loadspritemaybe 7, 0, 3, 3
    callfunction 78, 1, 0, "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN"
    loadparticle 0, 259
    waitstate
    unloadspriteresource
    resetsprite 0
    resetsprite 1
    resetsprite 2
    resetsprite 3
    initspriteresource
    loadspriteresource 0
    loadspriteresource 1
    loadspriteresource 2
    loadspriteresource 3
    loadspritemaybe 4, 0, 0, 0
    loadspritemaybe 5, 0, 1, 1
    loadspritemaybe 6, 0, 2, 2
    loadspritemaybe 7, 0, 3, 3
    callfunction 78, 1, 0, "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN", "NaN"
    loadparticle 1, 426
    waitstate
    unloadspriteresource
    resetsprite 0
    resetsprite 1
    resetsprite 2
    resetsprite 3

    // --- 1. el fondo se tine de dorado
    callfunction 33, 5, 0, 1, 0, 10, 13311, "NaN", "NaN", "NaN", "NaN", "NaN"
    waitstate

    // --- 2. sale el sol
    addparticle 0, 1, 0
    addparticle 0, 2, 0
    addparticle 0, 0, 0
    playsepan 1531, 0
    wait 30

    // --- 3. destello de luz sobre el rival
    playsepan 2088, 117
    addparticle 1, 2, 17
    wait 15

    // --- 4. el rival brilla en dorado y tiembla
    callfunction 34, 6, 8, 0, 2, 13311, 14, 0, "NaN", "NaN", "NaN", "NaN"
    callfunction 36, 5, 4, 0, 1, 12, 264, "NaN", "NaN", "NaN", "NaN", "NaN"
    playsepanmod 1958, -117, 117, 4, 2
    waitparticle
    unloadparticle 0
    unloadparticle 1

    // --- 5. vuelta a la normalidad
    callfunction 33, 5, 0, 1, 10, 0, 13311, "NaN", "NaN", "NaN", "NaN", "NaN"
    waitstate
    end

.close
