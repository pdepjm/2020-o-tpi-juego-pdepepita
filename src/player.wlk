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
		self.image("amiguito_arriba1.png")
		self.anchoImg(utils.getPixel(40))
		self.alturaImg(utils.getPixel(40))
		
		self.position(new MiPosicion(x = game.width() - self.anchoImg(), y = 0))
		self.direccion(quieto)
		self.velocidad(3)
		self.powerUpsPosibles([reduccionTiempo, aumentarVelocidadPlayer, barbijo, alcoholEnGel, separador])
		self.posicionPowerUpX(utils.getPixel(380))
		displayTimer = new Display (position = new MiPosicion(x = game.width() - utils.getPixel(90), y = game.height() - utils.getPixel(30)))
		displayTimer.mostrarNum(30) //Arrancar timer en 30s
	
	}
	override method actualizarImagen()
	{
		if(frame < 4)
			frame++
		else
			frame = 1
		
		self.image("amiguito_" + self.direccion().toString() + frame.toString()+ ".png")
	}

	method enJuego() = estado == enJuego
	
	method avanzarTimer()
	{
		if(utils.juegoIniciado()) 
		{
			var val = displayTimer.valor()
			if(timer)
			{
				if(val > 0){
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
		game.removeTickEvent("timer")
		game.removeTickEvent("mover pjs")
		game.removeTickEvent("covidBar")
		game.removeTickEvent("powerUps")
	}
}

object ganador 
{
	method mostrarCartel()
	{
		cartel.image("victoria.png")
		game.addVisual(cartel)
	}
}

object perdedor
{
	method mostrarCartel()
	{
		cartel.image("derrota.png")
		game.addVisual(cartel)
	}
}

object enJuego
{
	method mostrarCartel(){} //solo para polimorfismo
}