import wollok.game.*
import utils.*
import miposicion.*
import nave.*
import alerta.*

object covidBar
{
	var valor = 0
	
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
			alerta.alertando(true)
			if(valor < 100)
				valor += ((100-distancia)*0.05)
			else{
				
				nave.estado(-1)	
			}
		}
		else
			alerta.alertando(false)
		//conversion para mover el rectangulo rojo dependiendo del valor [0-100]
		//valor deberia ser 0-100
		//var x = ((valor * 1.96) - 194).truncate(0)
		var x = ((valor * 0.99) - 98).truncate(0)
		
		fill.position().x(x)
	}
}
object fill
{
	var property position = new MiPosicion( x = utils.getPixel(-194), y = game.height()-utils.getPixel(19))
	var property image = "barFill.png"		
}

object border 
{
	var property position =  new MiPosicion( x =0,y =game.height()-10)
	var property image = "barBorder.png"
}
