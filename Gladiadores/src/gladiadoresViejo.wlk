import wollok.game.*

object dado {

	var caras = [ 1, 2, 3, 4, 5, 6 ]
	var property cara = caras.anyOne()
	var property position = game.center()

	method image() {
		return cara.stringValue() + ".png"
	}

	method tirar() {
		cara = caras.anyOne()
	}

}

class Ryan {

	var property vida = 100
	var property ataque = 4
	var property defensa = 4
	var marca = 0

	method rotar() = new Bald()

	method habilidad() = "furia"

	method nombre() = "ryan"

	method image() = "gladiador11.png"

	method position() = game.at(0, 10)

	method habilidadEspecial() {
		marca = marca + 0.25 * dado.cara() - (0.25 * dado.cara()).truncate(0)
		ataque = ataque + marca.truncate(0)
		ataque = ataque + (0.25 * dado.cara()).truncate(0)
		ataque = 100.min(ataque)
	}

	method aumentarDefensa() {
		if (defensa < 99) {
			defensa += 1
		}
	}

	method aumentarAtaque() {
		if (ataque < 99) {
			ataque += 1
		}
	}

	method curar() {
		if (vida < 197) {
			vida += 3
		}
	}

	method disminuirDefensa() {
		if (defensa > 0) {
			defensa -= 1
		}
	}

	method ataqueTotal() = ataque + dado.cara()
 
	method atacar(rival) {
		if (self.ataqueTotal() >= rival.defensa()) {
			rival.danioRecibido(self.ataqueTotal() - rival.defensa())
		} else {
			self.danioRecibido(rival.defensa() - self.ataqueTotal())
		}
		self.habilidadEspecial()
	}

	method danioRecibido(danio) {
		if (vida > danio) {
			vida -= danio
		} else {
			vida = 0
		game.removeTickEvent("ass")
			
		}
	}

}

class Bald {

	var property vida = 100
	var property ataque = 6
	var property defensa = 2

	method condicionEspecial() = true

	method rotar() = new Ragn()

	method habilidad() = "letal"

	method nombre() = "bald"

	method position() = game.at(0, 10)

	method image() = "gladiador21.png"

	method habilidadEspecial(rival) {
		rival.disminuirDefensa()
	}

	method aumentarDefensa() {
		if (defensa < 99) {
			defensa += 1
		}
	}

	method aumentarAtaque() {
		if (ataque < 99) {
			ataque += 1
		}
	}

	method curar() {
		if (vida < 197) {
			vida += 3
		}
	}

	method disminuirDefensa() {
		if (defensa > 0) {
			defensa -= 1
		}
	}

	method ataqueTotal() = ataque + dado.cara()

	method atacar(rival) {
		self.habilidadEspecial(rival)
		if (self.ataqueTotal() >= rival.defensa()) {
			rival.danioRecibido(self.ataqueTotal() - rival.defensa())
		} else {
			self.danioRecibido(rival.defensa() - self.ataqueTotal())
		}
	}

	method danioRecibido(danio) {
		if (vida > danio) {
			vida -= danio
		} else {
			vida = 0
		}
	}

}

class Ragn {

	var property vida = 100
	var property ataque = 3
	var property defensa = 5

	method condicionEspecial() = dado.cara() == 6

	method rotar() = new Tarkus()

	method habilidad() = "confianza"

	method nombre() = "ragn"

	method position() = game.at(0, 10)

	method image() = "gladiador31.png"

	method habilidadEspecial() {
		if (self.condicionEspecial()) {
			ataque += 2
			defensa += 2
		}
	}

	method aumentarDefensa() {
		if (defensa < 99) {
			defensa += 1
		}
	}

	method aumentarAtaque() {
		if (ataque < 99) {
			ataque += 1
		}
	}

	method curar() {
		if (vida < 197) {
			vida += 3
		}
	}

	method disminuirDefensa() {
		if (defensa > 0) {
			defensa -= 1
		}
	}

	method ataqueTotal() = ataque + dado.cara()

	method atacar(rival) {
		if (self.ataqueTotal() >= rival.defensa()) {
			rival.danioRecibido(self.ataqueTotal() - rival.defensa())
		} else {
			self.danioRecibido(rival.defensa() - self.ataqueTotal())
		}
		self.habilidadEspecial()
	}

	method danioRecibido(danio) {
		if (vida > danio) {
			vida -= danio
		} else {
			vida = 0
		}
	}

}

class Tarkus {

	var property vida = 100
	var property ataque = 2
	var property defensa = 6

	method condicionEspecial() = dado.cara().even()

	method rotar() = new Ryan()

	method habilidad() = "dureza"

	method nombre() = "tarkus"

	method position() = game.at(0, 10)

	method image() = "gladiador41.png"

	method habilidadEspecial() {
		if (self.condicionEspecial()) {
			defensa += 1
		}
	}

	method aumentarDefensa() {
		if (defensa < 99) {
			defensa += 1
		}
	}

	method aumentarAtaque() {
		if (ataque < 99) {
			ataque += 1
		}
	}

	method curar() {
		if (vida < 197) {
			vida += 3
		}
	}

	method disminuirDefensa() {
		if (defensa > 0) {
			defensa -= 1
		}
	}

	method ataqueTotal() = ataque + dado.cara()

	method atacar(rival) {
		if (self.condicionEspecial()) {
			self.habilidadEspecial()
			rival.danioRecibido(ataque)
		} else {
			if (self.ataqueTotal() >= rival.defensa()) {
				rival.danioRecibido(self.ataqueTotal() - rival.defensa())
			} else {
				self.danioRecibido(rival.defensa() - self.ataqueTotal())
			}
		}
	}

	method danioRecibido(danio) {
		if (vida > danio) {
			vida -= danio
		} else {
			vida = 0
		}
	}

}

class Ryan2 inherits Ryan {



	override method position() = game.origin()

	override method rotar() = new Bald2()

	override method image() = "gladiador12.png"

}

class Bald2 inherits Bald {



	override method position() = game.origin()

	override method rotar() = new Ragn2()

	override method image() = "gladiador22.png"

}

class Ragn2 inherits Ragn {



	override method position() = game.origin()

	override method rotar() = new Tarkus2()

	override method image() = "gladiador32.png"

}

class Tarkus2 inherits Tarkus {


	override method position() = game.origin()

	override method rotar() = new Ryan2()

	override method image() = "gladiador42.png"

}
