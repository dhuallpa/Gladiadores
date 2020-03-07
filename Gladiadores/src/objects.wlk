import gladiadores.*
import acciones.*
import juego.*
import wollok.game.*

class Jugador{

	var property gladiador
	var property pos = 0
	var property posjug = 0
	var property jugador = ""
	method image() {
		return gladiador.image()
	}

	method nombre() {
		return gladiador.nombre()
	}

	method position() {
		return gladiador.position()
	}

	method rotarUp() {
		gladiador = gladiador.rotarUp()
	}

	method rotarDown() {
		gladiador = gladiador.rotarDown()
	}
		

}

class Accion {

	var property accion

	method image() {
		return accion.image()
	}

	method position() {
		return accion.position()
	}

	method rotar() {
		game.sound("select.wav")
		accion = accion.rotar()
	}

}

class Visual {

	var property image
	var property position = game.origin()

}

class Turno {

	var property image
	var property position = game.origin()

	method cambiarj2() {
		position = game.at(16, 4)
	}

	method cambiarj1() {
		position = game.at(3, 4)
	}

	method acabar() {
		if (position == game.at(3, 4)) {
			juego.accion(juego.j1())
			self.cambiarj2()
		} else {
			juego.accion(juego.j2())
			self.cambiarj1()
		}
	}

}

