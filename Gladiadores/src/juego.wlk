import wollok.game.*
import objects.*
import gladiadores.*
import digitos.*
import acciones.*

const eleccion = new Jugador(gladiador = new Ryan(), pos = 0)const eleccion2 = new Jugador(gladiador = new Ryan2(), pos = 10)const coliseo = new Visual(image = "coliseo.png", position = game.origin())const arena1 = new Visual(image = "arena.png", position = game.origin())const arena2 = new Visual(image = "arena.png", position = game.at(10, 0))const acciones = new Accion(accion = atacar)const turno = new Turno(image = "posicionDado.png", position = game.at(3, 4))const pantalla = new Visual(image = "pantalla.png", position = game.origin())object juego {

	var ryanhab = new HabilidadEspecialRyan()
	var property j1
	var property j2
	const anchoTotal = 20
	const altoTotal = 14

	method inicio() {
		game.title("Gladiadores")
		game.width(anchoTotal)
		game.height(altoTotal)
		game.addVisual(coliseo)
		keyboard.enter().onPressDo{ self.instrucciones()}
	}

	method instrucciones() {
		game.clear()
		game.addVisual(new Visual(image = "controles.png", position = game.origin()))
		keyboard.enter().onPressDo{ self.configurar()}
	}

	method music() {
		game.sound("crusada.corto.mp3")
	}

	method configurar() {
		game.clear()
		game.ground("suelo.png")
		game.addVisual(eleccion)
		game.addVisual(pantalla)
		game.addVisual(eleccion2)
		self.inicializarJugador(eleccion)
		self.inicializarJugador(eleccion2)
		self.music()
		game.onTick(2640, "musica", { self.music()})
		caracteristicasGladiador.dibujarGladiador(eleccion)
		caracteristicasGladiador.dibujarGladiador(eleccion2)
		keyboard.w().onPressDo{ self.rotarGladiadorUp()}
		keyboard.s().onPressDo{ self.rotarGladiadorDown()}
		keyboard.up().onPressDo{ self.rotarGladiadorUp2()}
		keyboard.down().onPressDo{ self.rotarGladiadorDown2()}
		keyboard.shift().onPressDo{ self.iniciarJuego()}
	}

	method inicializarJugador(jug) {
		jug.gladiador().inicializar(100, 4, 4)
		jug.gladiador().habilidadEspecial(ryanhab)
	}

	method rotarGladiadorUp() {
		eleccion.rotarUp()
		game.sound("select.wav")
		caracteristicasGladiador.dibujarGladiador(eleccion)
	}

	method rotarGladiadorUp2() {
		eleccion2.rotarUp()
		game.sound("select.wav")
		caracteristicasGladiador.dibujarGladiador(eleccion2)
	}

	method rotarGladiadorDown() {
		eleccion.rotarDown()
		game.sound("select.wav")
		caracteristicasGladiador.dibujarGladiador(eleccion)
	}

	method rotarGladiadorDown2() {
		eleccion2.rotarDown()
		game.sound("select.wav")
		caracteristicasGladiador.dibujarGladiador(eleccion2)
	}

	method iniciarJuego() {
		j1 = eleccion
		j2 = eleccion2
		game.clear()
		game.sound("viento.mp3")
//		game.schedule(900, { self.music()})
		game.onTick(2640, "musica", { self.music()})
//		game.sound("crusada.mp3")
//		game.schedule(162360, { game.onTick(2640, "musica", { self.music()})})
		game.addVisual(arena1)
		game.addVisual(arena2)
		game.addVisual(dado)
		game.addVisual(acciones)
		caracteristicasGladiador.dibujarElegido(j1, 0)
		caracteristicasGladiador.dibujarElegido(j2, 12)
		game.addVisualIn(j1, game.at(0, 0))
		game.addVisualIn(j2, game.at(16, 0))
		keyboard.space().onPressDo{ acciones.rotar()}
		game.addVisual(turno)
		game.onCollideDo(dado, { turno => turno.acabar()})
		keyboard.enter().onPressDo{ dado.tirar()}
		keyboard.control().onPressDo{ game.stop()}
	}

	method ganador() {
		if (j1.gladiador().vida() == 0) {
			return "j2"
		} else {
			return "j1"
		}
	}

	method accion(alg) {
		acciones.accion().realizar(alg)
		caracteristicasGladiador.dibujarElegido(j1, 0)
		caracteristicasGladiador.dibujarElegido(j2, 12)
		if (j1.gladiador().vida() == 0 || j2.gladiador().vida() == 0) {
			var ganador
			ganador = self.ganador()
			game.addVisualIn(new Visual(image = "victory" + ganador + ".png"), game.origin())
			game.schedule(2500, { game.sound("final.mp3")})
			keyboard.control().onPressDo{ game.stop()}
			keyboard.enter().onPressDo{ self.configurar()}
		}
	}

}

