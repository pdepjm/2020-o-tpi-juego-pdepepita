import wollok.game.*
import utils.*
import miposicion.*
import movil.*
import bar.*
import player.*
import covid.*

class PowerUp 
{
	var property position = new MiPosicion(x = 0, y = 0)
	var property image
	var property anchoImg = utils.getPixel(40)
	var property alturaImg = utils.getPixel(40)

	method usar(jugador)

	method init()
}

object extensionTiempo inherits PowerUp 
{
	override method usar(jugador) 
	{
		const display = player.displayTimer()
		const actual = display.valor()
		display.valor(actual + 5)
		display.mostrarNum(display.valor())
	}
	override method init() 
	{
		self.image("extensionTiempo.png")
	}
}

object reduccionTiempo inherits PowerUp 
{
	override method usar(jugador) 
	{
		const display = player.displayTimer()
		const actual = display.valor()
		display.valor(actual - 5)
		display.mostrarNum(display.valor())
	}
	override method init() 
	{
		self.image("reducirTiempo.png")
	}
}

object acelerarContagio inherits PowerUp 
{
	override method usar(jugador) 
	{
		covidBar.multiplicadorMutacion(0.08)
		game.schedule(3000, { covidBar.multiplicadorMutacion(0.05)})
	}
	override method init() 
	{
		self.image("acelerarContagio.png")
	}
}

object aumentarRango inherits PowerUp 
{
	override method usar(jugador) 
	{
		const distancia = covidBar.distanciaDeContagio()
		covidBar.distanciaDeContagio(distancia + 30)
		game.schedule(3000, { covidBar.distanciaDeContagio(distancia)})
	}
	override method init() {
		self.image("aumentarRango.png")
	}
}

object acercar inherits PowerUp 
{
	override method usar(jugador) 
	{
		gestorJugadores.acercarJugadores()
	}
	override method init() 
	{
		self.image("acercar.png")
	}
}

object aumentarVelocidadCovid inherits PowerUp 
{
	override method usar(jugador) 
	{
		const valorPrevio = jugador.velocidad()
		jugador.velocidad(valorPrevio + 2)
		game.schedule(3000, { jugador.velocidad(valorPrevio)})
	}
	override method init() 
	{
		self.image("aumentarVelocidadCovid.png")
	}
}

object aumentarVelocidadPlayer inherits PowerUp 
{
	override method usar(jugador) 
	{
		const valorPrevio = jugador.velocidad()
		jugador.velocidad(valorPrevio + 2)
		game.schedule(3000, { jugador.velocidad(valorPrevio)})
	}
	override method init() 
	{
		self.image("aumentarVelocidadPlayer.png")
	}
}

object barbijo inherits PowerUp 
{
	override method init() 
	{
		self.image("barbijo.png")
	}
	override method usar(jugador) 
	{
		covidBar.puedeContagiar(false)
		game.schedule(3000, { covidBar.puedeContagiar(true)})
	}
}

object alcoholEnGel inherits PowerUp 
{
	override method usar(jugador) 
	{
		covidBar.valor(0)
	}
	override method init() 
	{
		self.image("masVida.png")
	}
}

object separador inherits PowerUp 
{
	override method usar(jugador) 
	{
		gestorJugadores.separarJugadores()
	}
	override method init() 
	{
		self.image("separar.png")
	}
}

object cajaSorpresa 
{

//	var mostrando = false
	var property position = new MiPosicion(x = 0, y = 0)
	var property image = "powerOculto.png"
	const anchoImg = utils.getPixel(40)
	const alturaImg = utils.getPixel(40)
	// Muestra el powerup (?) en pantalla
	method aparecer() 
	{
		if (utils.juegoIniciado()) 
		{
			position.x(utils.random(0, game.width() - anchoImg))
			position.y(utils.random(0, game.width() - alturaImg))
			game.addVisual(self)
			game.schedule(5000, { if(game.hasVisual(self)) self.eliminar() })
		}
	}
	method eliminar() 
	{
		if(game.hasVisual(self))
			game.removeVisual(self)
	}
	// verifica la colision con los jugadores si se esta mostrando
	method verificarColisiones() 
	{
		if (game.hasVisual(self)) 
		{
			// no quiero un error(excepcion) si no encuentra colision, por eso findOrElse
			var encontrado = true
			const jugador = gestorJugadores.jugadores().findOrElse({ jugador => self.colisiono(jugador) }, { encontrado = false })
			if (encontrado) 
			{
				jugador.agregarPowerUp()
				self.eliminar()
			}
		}
	}
	// algoritmo Axis-Aligned Bounding Box
	method colisiono(jugador) = 
		position.x() < jugador.position().x() + jugador.anchoImg() 	and 
		jugador.position().x() < position.x() + anchoImg			and 
		position.y() < jugador.position().y() + jugador.alturaImg() and 
		jugador.position().y() < position.y() + alturaImg
}

