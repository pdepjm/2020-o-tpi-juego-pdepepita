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
		
		displayTimer = new Display (position = new MiPosicion(x = game.width() - utils.getPixel(90), y = game.height() - utils.getPixel(30)))
		displayTimer.mostrarNum(30) //Arrancar timer en 30s
	}
	
	override method actualizarImagen()
	{
		if(frame < 4)
			frame++
		else
			frame = 1
		
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
		game.removeVisual(self)
		game.removeVisual(covid)
		barrera.eliminarComponentes()
		estado.mostrarCartel()
		utils.removerOnTicks()
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