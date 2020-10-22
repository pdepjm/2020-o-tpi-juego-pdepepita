import wollok.game.*
import utils.*
import miposicion.*
import player.*
import alerta.*

object covidBar
{
	var property valor = 0
	var property puedeContagiar = true
	var property multiplicadorMutacion = 0.05
	var property distanciaDeContagio = 100
	method mostrar()
	{
		game.addVisual(fill)
		game.addVisual(border)
	}
	method actualizar(distancia)
	{
		//valor = val
		if(utils.juegoIniciado())
		{
			if(distancia < distanciaDeContagio)
			{
				/* powerup barbijo */
				if(puedeContagiar){
					alerta.iniciarAlerta()
					
					valor += ((100-distancia)*multiplicadorMutacion)
					
					if(valor >= 100)
					{
						valor = 100	
						player.finalizarJuego(perdedor)
					}
					
				}
			}
			else
				alerta.finalizarAlerta()
				
		}
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
	var property position = new MiPosicion( x = utils.getPixel(-194), y = game.height()-utils.getPixel(34))
	var property image = "barFill.png"		
}

object border 
{
	var property position =  new MiPosicion( x =0,y =game.height()-utils.getPixel(36))
	var property image = "barBorder.png"
}
