import miposicion.*
import wollok.game.*
import utils.*

object cartelFinal
{
	var property position = new MiPosicion(
	x = game.width() / 2 - utils.getPixel(140), 
	y = game.height() / 2 - utils.getPixel(60)
	)
	var property image 
}


class CartelPowerUp
{
	var property position =  new MiPosicion(
		x = game.width() / 2 - utils.getPixel(200), 
		y = game.height() / 2 - utils.getPixel(60)
	)
	var property image //warning
	
	method eliminar() 
	{
		if(game.hasVisual(self))
			game.removeVisual(self)
	}
	method mostrar()
	{
		if(game.hasVisual(self))
			self.eliminar()
		game.addVisual(self)
		game.schedule(2000, { if(game.hasVisual(self)) self.eliminar() })
	}
}

object cartelColision inherits CartelPowerUp
{
	
}

object cartelActivado inherits CartelPowerUp
{
	
}

