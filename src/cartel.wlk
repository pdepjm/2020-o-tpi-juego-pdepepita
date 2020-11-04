import miposicion.*
import wollok.game.*
import utils.*
object cartel 
{
	var property position = new MiPosicion(
		x = game.width() / 2 - utils.getPixel(140), 
		y = game.height() / 2 - utils.getPixel(60)
	)
	var property image //warning
}

// si lo hago de esta manera se cierra tirando exception
object cartelPowerUp
{
	var property position = new MiPosicion(
		x = game.width() / 2 - utils.getPixel(200), 
		y = game.height() / 2 - utils.getPixel(60)
	)
	var property image //warning
}