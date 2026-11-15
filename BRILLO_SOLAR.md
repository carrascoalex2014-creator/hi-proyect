# Brillo Solar — ataque nuevo para HeartGold Generations v2.0

Este repositorio es el código de **Pokémon HeartGold Generations v2.0**
(de spearmintz, rama `HeartGold-Generations-(Full-Version-2.0)` de
[spearmintz1/hg-engine](https://github.com/spearmintz1/hg-engine))
con un ataque nuevo: **Brillo Solar**.

## El ataque

| Campo | Valor |
|---|---|
| Nombre | Brillo Solar |
| Número interno | 923 (`MOVE_BRILLO_SOLAR`, primera ranura personalizada) |
| Tipo | Fuego |
| Categoría | Especial |
| Poder | 80 |
| Precisión | 100 |
| PP | 10 |
| Efecto | 30 % de bajar la precisión del rival (lo deslumbra) |
| Objetivo | Un rival |
| Concurso | Belleza |

Descripción en el juego (en inglés, como el resto del hack):
> The user shines with the light of the sun. It may also lower the target's accuracy.

### Animación

1. El fondo se tiñe de dorado.
2. Aparece un sol radiante sobre el campo.
3. Un destello de luz cae sobre el rival.
4. El rival brilla en dorado y tiembla por el impacto.
5. El fondo vuelve a la normalidad.

Reutiliza los archivos de partículas del juego (los de Día Soleado y Brillo
Mágico) combinados de forma nueva, con el tono dorado de Rayo Solar.

### Quién lo aprende (por nivel)

| Pokémon | Nivel |
|---|---|
| Charizard | 44 |
| Sunflora | 31 |
| Ho-Oh | 47 |
| Solrock | 30 |
| Volcarona | 45 |

## Archivos que cambié

| Archivo | Qué hace |
|---|---|
| `include/constants/moves.h` | Define `MOVE_BRILLO_SOLAR` = 923 y sube `NUM_OF_CUSTOM_MOVES` a 1 |
| `asm/include/moves.inc` | Lo mismo, para el código en ensamblador |
| `armips/data/moves.s` | Datos del ataque: tipo, poder, precisión, efecto, nombre y descripción |
| `data/battle_scripts/moves/move_script_0923_BRILLO_SOLAR.s` | Script de batalla (usa el efecto estándar de "bajar precisión") |
| `armips/move/move_anim/923.s` | La animación |
| `armips/data/levelupdata.s` | Lo añade a los 5 Pokémon de la tabla |

## Cómo crear tu ROM

Necesitas **tu propia ROM original de Pokémon HeartGold (EE. UU.)**, sacada de
tu cartucho. No se incluye aquí.

### Opción fácil: Docker (Windows, Mac o Linux)

1. Instala [Docker Desktop](https://www.docker.com/products/docker-desktop/) y [Git](https://git-scm.com/).
2. Descarga este repositorio:
   ```
   git clone -b claude/preguntas-e9jxz6 https://github.com/carrascoalex2014-creator/hi-proyect.git
   cd hi-proyect
   ```
3. Copia tu ROM dentro de la carpeta y renómbrala a **`rom.nds`**.
4. Ejecuta:
   ```
   docker build . -t hg-engine
   ./docker-makerom.cmd
   ```
5. Al terminar tendrás **`test.nds`**: esa es tu ROM con Brillo Solar.

### Opción Linux / WSL

Sigue la sección "Build Instructions" del `README.md` original (instalar
`gcc-arm-none-eabi`, `cmake`, `python3`, etc.) y luego ejecuta `make -j$(nproc)`.

### Para probarlo rápido

- Usa **melonDS** o **DeSmuME** (DraStic da problemas con este hack).
- Un Charizard al nivel 44 lo aprende. También puedes usar el Recordador de
  movimientos con una Escama Corazón si tu Pokémon ya pasó ese nivel.

## Qué está comprobado y qué no

- **Comprobado aquí:** los datos del ataque, los textos, los aprendizajes, la
  animación y el script de batalla compilan sin errores con las mismas
  herramientas del proyecto (armips y arm-none-eabi). El ataque compilado tiene
  los valores correctos: efecto 73, especial, 80 de poder, Fuego, 100 de
  precisión, 10 PP y 30 % de probabilidad.
- **No comprobado:** no pude generar la ROM completa ni jugarla, porque hace
  falta tu ROM original. Si la animación se ve rara o algo falla, dímelo y lo
  ajusto.

## Cambiar el ataque

Todo está en `armips/data/moves.s`, busca `movedata MOVE_BRILLO_SOLAR`:

- `basepower 80` → poder
- `type TYPE_FIRE` → tipo (`TYPE_GRASS`, `TYPE_FAIRY`, ...)
- `effectchance 30` → probabilidad del efecto
- `pss SPLIT_SPECIAL` → `SPLIT_PHYSICAL` para hacerlo físico
