import wollok.game.*
import juego.*
// oas
object atacar {

	method image() = "ataque1.png"

	method position() = game.at(8, 10)

	method realizar(jugador) {
		game.onTick(500,"lucha",{game.sound("espadas.mp3")})
		game.schedule(500, {game.removeTickEvent("lucha")})
		if (jugador == juego.j1()) {
			jugador.gladiador().atacar(juego.j2().gladiador())
		} else {
			jugador.gladiador().atacar(juego.j1().gladiador())
		}
	}

	method rotar() = incrementarDefensa

}

object incrementarDefensa {

	method image() = "escudo.png"

	method position() = game.at(8, 10)

	method realizar(jugador) { 
		game.sound("incrementar.mp3")
		jugador.gladiador().aumentarDefensa(1)
	}

	method rotar() = incrementarAtaque

}

object incrementarAtaque {

	method image() = "espada.png"

	method position() = game.at(8, 10)

	method realizar(jugador) {
		game.sound("incrementar.mp3")
		jugador.gladiador().aumentarAtaque(1)
	}

	method rotar() = curar

}

object curar {

	method image() = "curar.png"

	method position() = game.at(8, 10)

	method realizar(jugador) {
		game.sound("incrementar.mp3")
		jugador.gladiador().curar(3)
	}

	method rotar() = atacar

}

