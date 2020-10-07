import utils.*
import wollok.game.*
import miposicion.*
import movil.*

object covid inherits Movil{

	override method init()
	{
		self.image("jugador.png")
		self.position(new MiPosicion(x = utils.getPixel(10), y = game.height() - utils.getPixel(40)))
		self.direccion(0)
		self.orientacion(4)
		self.velocidad(2)
	}
	
	override method actualizarImagen(dir)
	{
		self.image("jugador.png")
	}
	
	method obtenerDistancia(pj) = self.position().distance(pj.position())
}
