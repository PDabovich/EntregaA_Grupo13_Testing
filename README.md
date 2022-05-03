# Entrega A Grupo13 Testing

## Iniciar el juego 

Para iniciar el juego, dentro de la carpeta raíz es necesario ejecutar el siguiente comando:

```
ruby main.rb
```

## Selección de dificultad

Lo primero que hay que hacer es seleccionar la dificultad, es necesario ingresar un número en consola, 1 para dificultad fácil y 2 para difícil, la dificultad modifica el tamaño del tablero y la cantidad de barcos.

## Preparativos

Ahora hay que ingresar los barcos en el tablero del jugador, dependiendo de la dificultad serán 5 para fácil y 8 para difícil, se debe ingresar uno por uno, colocando la posición del centro del barco (el cual es siempre de tamaño 3), por ejemplo C2. Luego colocar la orientación, H para horizontal y V para vertical, debe ser siempre con mayúscula.

## Iniciando el juego

Una vez ingresado la totalidad de barcos necesarios se inicia el juego, el jugador ahora deberá ingresar la posición de donde quiere realizar un tiro en el tablero enemigo, una vez realizado esto la cpu realizará también un tiro, si el tiro ha dado en el blanco de algún barco aparecerá en consola, al igual si se ha hundido algún barco.

Una vez hundido todos los barcos o pasado cierto número de turnos se terminará el juego dando por ganador al jugador que haya hundido todos los barcos.
