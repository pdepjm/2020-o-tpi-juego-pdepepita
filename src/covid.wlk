import utils.*
import wollok.game.*
import miposicion.*
import movil.*

object covid inherits Movil{

	const powerUps = []
	override method init()
	{
		self.image("covid.png")
		self.anchoImg(utils.getPixel(38))
		self.alturaImg(utils.getPixel(40))
		
		self.position(new MiPosicion(x = 0, y = utils.alturaJuego() - self.alturaImg()))
		self.direccion(quieto)
		self.velocidad(2)
	}
	
	override method actualizarImagen()
	{
		//self.image("covid_" + self.direccion().toString() + ".png")
		self.image("covid.png")
	}
	
	method agregarPowerUp(powerUp)
	{
		powerUps.add(powerUp)
		console.println("agarro "+ powerUp.toString())
		//agregar a display
	}
	
	method usarPowerUp()
	{
		if(powerUps.size() > 0)
		{
			const unPowerUp = powerUps.first()
			powerUps.remove(unPowerUp)
			console.println("uso "+ unPowerUp.toString())
			unPowerUp.usar(self)			
		}
	}
	
}
