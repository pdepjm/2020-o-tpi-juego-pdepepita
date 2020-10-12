import miposicion.*
import wollok.game.*
import nave.*
object alerta {
	var property position = new MiPosicion(x = 0, y = 0)
	var property image = "redBack0.png"
	
	var property alertando = false
	var estado = 0
	var dir = 0
	method actualizar()
	{
		if(alertando){
			if(dir == 0)
			{
				if(estado < 3)
					estado++
				else
					dir = 1
			}
			else
			{
				if(estado > 0)
					estado--
				else
					dir = 0
			}
			
				
			image = "redBack" + estado.toString() + ".png"
			//game.say(nave, estado.toString())		
		}
		else{
			estado = 0
			dir = 0
			image = "redBack0.png"
		}
	}
}
