import utils.*
import wollok.game.*
import miposicion.*
import movil.*
import powerup.*

object covid inherits Movil{

	
	override method init()
	{
		self.image("covid.png")
		self.anchoImg(utils.getPixel(40))
		self.alturaImg(utils.getPixel(40))
		
		//self.powerUpsPosibles([extensionTiempo, acelerarContagio, aumentarVelocidadCovid, aumentarRango, acercar])
		self.powerUpsPosibles([acercar])
		self.posicionPowerUpX(utils.getPixel(50))
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
