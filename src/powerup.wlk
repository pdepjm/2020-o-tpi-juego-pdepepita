import wollok.game.*
import utils.*
import miposicion.*
import movil.*
import bar.*
import player.*
import covid.*

class PowerUp {
	var property position = new MiPosicion( x = 0, y = 0)
	var property image = "powerOculto.png"
	var property anchoImg = utils.getPixel(50)
	var property alturaImg = utils.getPixel(54)
	method usar(jugador)
}
object oculto inherits PowerUp
{
	override method usar(jugador)
	{}
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
}
object mutarVirus inherits PowerUp
{
	override method usar(jugador)
	{
		covidBar.multiplicadorMutacion(0.08)
		game.schedule(3000, {covidBar.multiplicadorMutacion(0.05)})
	}
}

object aumentarVelocidad inherits PowerUp
{
	override method usar(jugador)
	{
		const valorPrevio = jugador.velocidad()
		jugador.velocidad(valorPrevio + 1)
		game.schedule(3000, {jugador.velocidad(valorPrevio)})
	}
}
object barbijo inherits PowerUp
{
	override method usar(jugador)
	{
		covidBar.puedeContagiar(false)
		game.schedule(3000, {covidBar.puedeContagiar(true)})
	}
}

object alcoholEnGel inherits PowerUp
{
	override method usar(jugador)
	{
		covidBar.valor(0)
	}
}

object separador inherits PowerUp
{
	override method usar(jugador)
	{
		gestorJugadores.separarJugadores()		
	}
}

object gestorPowerUps
{
	//posibles, no asignados
	const playerPowerUps = [reduccionTiempo, aumentarVelocidad, barbijo, alcoholEnGel, separador]
	const covidPowerUps = [extensionTiempo, mutarVirus, aumentarVelocidad]
	var mostrando = false
	
	//Muestra el powerup (?) en pantalla
	method aparecer() {
		oculto.position().x(utils.random(0, game.width() - oculto.anchoImg()))
		oculto.position().y(utils.random(0, game.width() - oculto.alturaImg()))
		mostrando = true
		game.addVisual(oculto)
		game.schedule(3000, { if(mostrando) self.eliminar() })
	}
	method eliminar()
	{
		mostrando = false
		game.removeVisual(oculto)
	}
	
	//verifica la colision con los jugadores si se esta mostrando
	method verificarColisiones()
	{
		if(mostrando)
		{
			//no quiero un error(excepcion) si no encuentra colision, por eso findOrElse
			var encontrado = true 
			const jugador = gestorJugadores.jugadores().findOrElse({jugador => self.colisiono(jugador)}, {encontrado = false}) 	
			
			if(encontrado)
			{
				if(jugador.equals(player))
					jugador.agregarPowerUp(playerPowerUps.anyOne())
				else if(jugador.equals(covid))
					jugador.agregarPowerUp(covidPowerUps.anyOne())	
				
				self.eliminar()
			}
		}
		
	}
	//algoritmo Axis-Aligned Bounding Box
	method colisiono(jugador) = 
		oculto.position().x() < jugador.position().x() + jugador.anchoImg() and
		jugador.position().x() < oculto.position().x() + oculto.anchoImg() 
		and
		oculto.position().y() < jugador.position().y() + jugador.alturaImg() and
		jugador.position().y() < oculto.position().y() + oculto.alturaImg() 	
}