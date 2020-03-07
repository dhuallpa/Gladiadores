import wollok.game.*
import juego.*
import objects.*
import acciones.*


object dado {

	var caras = [ 1, 2, 3, 4, 5, 6 ]
	var property cara = caras.anyOne()
	var property position = game.center()

 	method dado() {
		cara = caras.anyOne()
	}

	method image() {
		return cara.stringValue() + ".png"
	}


	method tirar() {
		position = turno.position().up(1)
		if (self.esAtaque()) {
			game.sound("tirardado.mp3")
			game.onTick(250, "dado", { self.dado()})
			game.schedule(1250, { self.colisionar()})
		} else {
			game.schedule(500, { self.colisionar2()})
		}
	}
	method esAtaque(){
		return acciones.accion() == atacar
	}
	method colisionar2() {
		position = position.down(1)
		game.schedule(250, { self.position(game.center())})
	}
	method colisionar() {
		game.removeTickEvent("dado")
		self.colisionar2()
	}

}

class HabilidadEspecialRyan {

	var marca = 0

	method realizar(glad, rival) {
		marca = self.resto(marca)
		marca = marca + self.resto(0.25 * dado.cara())
		glad.aumentarAtaque(marca.truncate(0) + (0.25 * dado.cara()).truncate(0))
		glad.ataque(self.maximo(glad))
	}
	method maximo(glad){
		return 100.min(glad.ataque())
	}
	method resto(algo) {
		return algo - algo.truncate(0)
	}

}

class HabilidadEspecialBald {

    method condicionEspecial() = dado.cara() > 3

	method realizar(glad, rival) {
		if (self.condicionEspecial()){
			glad.curar(2)
		    rival.disminuirDefensa(1)
		    }
	}
}

class HabilidadEspecialRagn {

	method condicionEspecial() = dado.cara() == 6

	method realizar(glad, rival) {
		if (self.condicionEspecial()) {
			glad.aumentarAtaque(2)
			glad.aumentarDefensa(2)
		}
	}

}

class HabilidadEspecialTarkus {

	method condicionEspecial() = dado.cara().even()

	method realizar(glad, rival) {
		if (self.condicionEspecial()) {
			glad.aumentarDefensa(1)
		}
	}

}

const ryanHab = new HabilidadEspecialRyan()
const baldHab = new HabilidadEspecialBald()
const ragnHab = new HabilidadEspecialRagn()
const tarkusHab = new HabilidadEspecialTarkus()


class Gladiador {

	var property vida
	var property ataque
	var property defensa
	var  habilidadEspecial

	method inicializar(vi, atk, def) {
		vida = vi
		ataque = atk
		defensa = def
	}
	method habilidadEspecial(algo){
		habilidadEspecial = algo
	}
	method habilidadEspecial() = habilidadEspecial 

	method aumentarAtaque(val) {
		if (100 > ataque + val) {
			ataque += val
		}
	}

	method aumentarDefensa(val) {
		if (100 > defensa + val) {
			defensa += val
		}
	}
	
	method curar(val){
		if (200 > vida + val){
			vida += val
		}
	}

	method disminuirDefensa(val) {
		if (defensa > 0) {
			defensa -= val
		}
	}

	method ataqueTotal() = ataque + dado.cara()
	
	method preAtaque(rival){
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
			game.clear()
		}
	}

}

class Ryan inherits Gladiador {

	method rotarUp() {
		const bald = new Bald()
		bald.inicializar(100, 6, 2)
		bald.habilidadEspecial(baldHab)
		return bald
	}

	method rotarDown() {
		const tarkus = new Tarkus()
		tarkus.inicializar(100, 2, 6)
		tarkus.habilidadEspecial(tarkusHab)
		return tarkus
	}

	method habilidad() = "furia"

	method nombre() = "ryan"

	method image() = "gladiador11.png"

	method position() = game.at(0, 10)

	method atacar(rival) {
		self.preAtaque(rival)
		habilidadEspecial.realizar(self, rival)
	}

}

class Bald inherits Gladiador {

	method condicionEspecial() = true

	method rotarUp() {
		const ragn = new Ragn()
		ragn.inicializar(100, 3, 5)
		ragn.habilidadEspecial(ragnHab)
		return ragn
	}

	method rotarDown() {
		const ryan = new Ryan()
		ryan.inicializar(100, 4, 4)
		ryan.habilidadEspecial(ryanHab)
		return ryan
	}

	method habilidad() = "letal"

	method nombre() = "bald"

	method position() = game.at(0, 10)

	method image() = "gladiador21.png"

	method atacar(rival) {
		habilidadEspecial.realizar(self, rival)
		self.preAtaque(rival)
	}

}

class Ragn inherits Gladiador {

	method rotarUp() {
		const tarkus = new Tarkus()
		tarkus.inicializar(100, 2, 6)
		tarkus.habilidadEspecial(tarkusHab)
		return tarkus
	}

	method rotarDown() {
		const bald = new Bald()
		bald.inicializar(100, 6, 2)
		bald.habilidadEspecial(baldHab)
		return bald
	}

	method habilidad() = "confianza"

	method nombre() = "ragn"

	method position() = game.at(0, 10)

	method image() = "gladiador31.png"

	method atacar(rival) {
		self.preAtaque(rival)
		habilidadEspecial.realizar(self, rival)
	}

}

class Tarkus inherits Gladiador {

	method rotarUp() {
		const ryan = new Ryan()
		ryan.inicializar(100, 4, 4)
		ryan.habilidadEspecial(ryanHab)
		return ryan
	}

	method rotarDown() {
		const ragn = new Ragn()
		ragn.inicializar(100, 3, 5)
		ragn.habilidadEspecial(ragnHab)
		return ragn
	}

	method habilidad() = "dureza"

	method nombre() = "tarkus"

	method position() = game.at(0, 10)

	method image() = "gladiador41.png"

	method atacar(rival) {
		if (habilidadEspecial.condicionEspecial()) {
			habilidadEspecial.realizar(self, rival)
			rival.danioRecibido(ataque)
		} else {
			self.preAtaque(rival)
		}
	}

}

class Ryan2 inherits Ryan {

	override method position() = game.origin()

	override method rotarUp() {
		const bald2 = new Bald2()
		bald2.inicializar(100, 6, 2)
		bald2.habilidadEspecial(baldHab)
		return bald2
	}

	override method rotarDown() {
		const tarkus2 = new Tarkus2()
		tarkus2.inicializar(100, 2, 6)
		tarkus2.habilidadEspecial(tarkusHab)
		return tarkus2
	}

	override method image() = "gladiador12.png"

}

class Bald2 inherits Bald {

	override method position() = game.origin()

	override method rotarUp() {
		const ragn2 = new Ragn2()
		ragn2.inicializar(100, 3, 5)
		ragn2.habilidadEspecial(ragnHab)
		return ragn2
	}

	override method rotarDown() {
		const ryan2 = new Ryan2()
		ryan2.inicializar(100, 4, 4)
		ryan2.habilidadEspecial(ryanHab)
		return ryan2
	}

	override method image() = "gladiador22.png"

}

class Ragn2 inherits Ragn {

	override method position() = game.origin()

	override method rotarUp() {
		const tarkus2 = new Tarkus2()
		tarkus2.inicializar(100, 2, 6)
		tarkus2.habilidadEspecial(tarkusHab)
		return tarkus2
	}

	override method rotarDown() {
		const bald2 = new Bald2()
		bald2.inicializar(100, 6, 2)
		bald2.habilidadEspecial(baldHab)
		return bald2
	}
	override method image() = "gladiador32.png"

}

class Tarkus2 inherits Tarkus {

	override method position() = game.origin()

	override method rotarUp() {
		const ryan2 = new Ryan2()
		ryan2.inicializar(100, 4, 4)
		ryan2.habilidadEspecial(ryanHab)
		return ryan2
	}

	override method rotarDown() {
		const ragn2 = new Ragn2()
		ragn2.inicializar(100, 3, 5)
		ragn2.habilidadEspecial(ragnHab)
		return ragn2
	}


	override method image() = "gladiador42.png"

}
