import wollok.game.*
import miposicion.*
import utils.*
import movil.*
import covid.*
import cartel.*
import display.*
import barrera.*

object player inherits Movil{

	//estado  1 "victoria", -1 "derrota", 0 "en juego"
	var property estado = enJuego
	
	override method init()
	{
		self.image("nave_arriba.png")
		self.anchoImg(utils.getPixel(40))
		self.alturaImg(utils.getPixel(40))
		
		self.position(new MiPosicion(x = game.width() - self.anchoImg(), y = 0))
		self.direccion(quieto)
		self.velocidad(10)
		
	}
	override method actualizarImagen()
	{
		self.image("nave_" + self.direccion().toString() + ".png")
	}

	method enJuego() = estado == enJuego
	
	method avanzarTimer()
	{
		var val = display.valor()
		
		if(val > 0){
			val -=1
			display.mostrarNum(val)
		}
		else
			self.finalizarJuego(ganador)
	 	
	}
	method finalizarJuego(est)
	{
		estado = est
		game.removeVisual(self)
		game.removeVisual(covid)
		game.removeVisual(barrera)
		estado.mostrarCartel()
		game.removeTickEvent("timer")
		game.removeTickEvent("mover pjs")
		game.removeTickEvent("covidBar")
		
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