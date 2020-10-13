import wollok.game.*
import miposicion.*
import utils.*
import movil.*
import covid.*
import cartel.*

object nave inherits Movil{

	//estado  1 "victoria", -1 "derrota", 0 "en juego"
	var estado = enJuego
	
	override method init()
	{
		self.image("nave_arriba.png")
		self.anchoImg(utils.getPixel(40))
		self.alturaImg(utils.getPixel(40))
		
		self.position(new MiPosicion(x = game.width() - self.anchoImg(), y = 0))
		self.direccion(quieto)
		self.velocidad(3)
		
	}
	override method actualizarImagen()
	{
		self.image("nave_" + self.direccion().toString() + ".png")
	}

	method enJuego() = estado == enJuego
	
	method finalizarJuego(est)
	{
		estado = est
		game.removeVisual(self)
		game.removeVisual(covid)
		estado.mostrarCartel()
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