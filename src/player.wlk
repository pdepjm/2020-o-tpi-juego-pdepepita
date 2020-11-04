import wollok.game.*
import miposicion.*
import utils.*
import movil.*
import covid.*
import cartel.*
import display.*
import barrera.*
import powerup.*

object player inherits Movil{

	//estado  1 "victoria", -1 "derrota", 0 "en juego"
	var property estado = enJuego
	var property displayTimer 
	var property timer = true
	var frame = 1
	
	override method init()
	{
		image = "amiguito_arriba1.png"
		anchoImg = utils.getPixel(40)
		alturaImg = utils.getPixel(40)
		
		position = new MiPosicion(x = game.width() - self.anchoImg(), y = 0)
		direccion = quieto
		velocidad = 6
		powerUpsPosibles = [reduccionTiempo, aumentarVelocidadPlayer, barbijo, alcoholEnGel, separador]
		
		posicionPowerUpX = [utils.getPixel(380), utils.getPixel(420), utils.getPixel(460), utils.getPixel(500)]
		
		displayTimer = new Display()
		displayTimer.mostrarNum(50) //Arrancar timer en 50s
	}
	
	override method actualizarImagen()
	{
		frame%=4
		frame++
		self.image("amiguito_" + direccion.toString() + frame.toString()+ ".png")
	}

	method enJuego() = estado == enJuego
	
	method avanzarTimer()
	{
		if(utils.juegoIniciado()) 
		{
			var val = displayTimer.valor()
			if(timer)
			{
				if(val > 0)
				{
					val -=1
					displayTimer.mostrarNum(val)
				}
				else
					self.finalizarJuego(ganador)
			}
		}
	}
	
	method finalizarJuego(est)
	{
		estado = est
		utils.removerOnTicks()
		game.removeVisual(self)
		game.removeVisual(covid)
		
		barrera.eliminarComponentes()
		estado.mostrarCartel()
		
	}
}

object ganador 
{
	method mostrarCartel()
	{
		cartelFinal.image("victoria.png")
		game.addVisual(cartelFinal)
	}
}

object perdedor
{
	method mostrarCartel()
	{
		cartelFinal.image("derrota.png")
		game.addVisual(cartelFinal)
	}
}

object enJuego
{
	method mostrarCartel(){} //solo para polimorfismo
}