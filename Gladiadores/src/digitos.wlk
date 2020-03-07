import wollok.game.*
import gladiadores.*
import objects.*

object caracteristicasGladiador {

	const posicionDefensa = game.at(7, 10)
	const posicionAtaque = game.at(7, 12)
	const posicionHabilidad = game.at(9, 10)
	const posicionVida = game.at(17, 12)
	
	const posicionDefensa2 = game.at(6, 10)
	const posicionAtaque2 = game.at(6, 12)
	const posicionVida2 = game.at(0, 12)
	const posatkdef = game.at(3, 10)

	method dibujarGladiador(el) {
		game.addVisualIn(new Visual(image = "ATKDEF.png"), game.at(4, el.pos()))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().defensa().div(10)), posicionDefensa.down(el.pos()))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().defensa() % 10), posicionDefensa.down(el.pos()).right(1))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().ataque().div(10)), posicionAtaque.down(el.pos()))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().ataque() % 10), posicionAtaque.down(el.pos()).right(1))
		game.addVisualIn(convertirNumero.imagenHabilidad(el.gladiador().habilidad()), posicionHabilidad.down(el.pos()))
		game.addVisualIn(new Visual(image = "vida.png"), posicionVida.down(el.pos()))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().vida().div(100)), posicionVida.down(2 + el.pos()))
		game.addVisualIn(convertirNumero.imagenDeNumero((el.gladiador().vida() % 100).div(10)), posicionVida.down(2 + el.pos()).right(1))
		game.addVisualIn(convertirNumero.imagenDeNumero(el.gladiador().vida() % 10), posicionVida.down(2 + el.pos()).right(2))
	}
	// 12
	method dibujarElegido(jug, pos) {
		game.addVisualIn(new Visual(image = "vida.png"), posicionVida2.right(pos))
		game.addVisualIn(new Visual(image = "ATKDEF.png"), posatkdef.right(pos))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().defensa().div(10)), posicionDefensa2.right(pos))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().defensa() % 10), posicionDefensa2.right(pos+1))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().ataque().div(10)), posicionAtaque2.right(pos))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().ataque() % 10), posicionAtaque2.right(pos+1))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().vida().div(100)), posicionVida2.down(2).right(pos))
		game.addVisualIn(convertirNumero.imagenDeNumero((jug.gladiador().vida() % 100).div(10)), posicionVida2.down(2).right(pos+1))
		game.addVisualIn(convertirNumero.imagenDeNumero(jug.gladiador().vida() % 10), posicionVida2.down(2).right(pos+2))
	}

}

object convertirNumero {

	method imagenDeNumero(number) {
		return new Visual(image = "n" + number.toString() + ".png")
	}

	method imagenHabilidad(habilidad) {
		return new Visual(image = habilidad + ".png")
	}

}

