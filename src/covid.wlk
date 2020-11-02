import utils.*
import wollok.game.*
import miposicion.*
import movil.*
import powerup.*

object covid inherits Movil{

	
	override method init()
	{
		image = "covid.png"
		anchoImg = utils.getPixel(40)
		alturaImg = utils.getPixel(40)
		
		powerUpsPosibles = [extensionTiempo, acelerarContagio, aumentarVelocidadCovid, aumentarRango, acercar]
		posicionPowerUpX = [utils.getPixel(50), utils.getPixel(90), utils.getPixel(130), utils.getPixel(170)]
		
		position = new MiPosicion(x = 0, y = utils.alturaJuego() - self.alturaImg())
		direccion = quieto
		velocidad = 2
	}
	
	override method actualizarImagen()
	{
		//self.image("covid_" + self.direccion().toString() + ".png")
		self.image("covid0.png")
	}
	
	
	
}
