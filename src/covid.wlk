import utils.*
import wollok.game.*
import miposicion.*
import movil.*
import powerup.*

object covid inherits Movil{

	
	override method init()
	{
		self.image("covid.png")
		self.anchoImg(utils.getPixel(38))
		self.alturaImg(utils.getPixel(40))
		
		self.powerUpsPosibles([extensionTiempo, acelerarContagio, aumentarVelocidad, aumentarRango])
		self.posicionPowerUpX(utils.getPixel(40))
		self.position(new MiPosicion(x = 0, y = utils.alturaJuego() - self.alturaImg()))
		self.direccion(quieto)
		self.velocidad(2)
	}
	
	override method actualizarImagen()
	{
		//self.image("covid_" + self.direccion().toString() + ".png")
		self.image("covid.png")
	}
	
	
	
}
