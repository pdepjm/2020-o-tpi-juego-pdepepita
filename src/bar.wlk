import wollok.game.*
import utils.*
import miposicion.*
import player.*
import alerta.*

object covidBar
{
	var property valor = 0
	
	method mostrar()
	{
		game.addVisual(fill)
		game.addVisual(border)
	}
	method actualizar(distancia)
	{
		//valor = val
		
		if(distancia < 100)
		{
			//alerta.alertando(true)
			alerta.iniciarAlerta()
			
			valor += ((100-distancia)*0.05)
			
			if(valor >= 100)
			{
				valor = 100	
				player.finalizarJuego(perdedor)
			}
		}
		else
			alerta.finalizarAlerta()
		//alerta.alertando(false)
		//conversion para mover el rectangulo rojo dependiendo del valor [0-100]
		//valor deberia ser 0-100
		//var x = ((valor * 1.96) - 194).truncate(0)
		//var x = ((valor * 0.99) - 98).truncate(0)
		var x = ((valor * 0.98) - 97).truncate(0)
		fill.position().x(x)
	}
}
object fill
{
	var property position = new MiPosicion( x = utils.getPixel(-194), y = game.height()-utils.getPixel(29))
	var property image = "barFill.png"		
}

object border 
{
	var property position =  new MiPosicion( x =0,y =game.height()-15)
	var property image = "barBorder.png"
}
