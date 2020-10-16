import miposicion.*
import wollok.game.*
import utils.*

object alerta {
	var property position = new MiPosicion(x = 0, y = utils.getPixel(-80))
	var property image
	
	var alertando = false
	
	var property aumentando = false
	var property disminuyendo = false
	const valorMaximo = 30
	const valorMinimo = 0
	
	method iniciarAlerta()
	{
		if(!alertando)
		{
			alertando = true
			aumentando = true
		}
	}
	method finalizarAlerta()
	{
		alertando = false
	}
	method actualizar()
	{
		if(alertando){
			if(aumentando)
				opacidadAlerta.aumentar(valorMaximo)
			else
				opacidadAlerta.disminuir(valorMinimo)
			
			image = opacidadAlerta.img()

		}
		else
			image = "alerta0.png"
	}
	
	
}
object opacidadAlerta {
	var opacidad = 0
	
	method img() = "alerta" + opacidad.toString() + ".png"
	
	method aumentar(maximo) { 
		if (opacidad < maximo)
			opacidad+=10
		else
		{
			alerta.aumentando(false)
			alerta.disminuyendo(true)
		}
	}
	method disminuir(minimo)
	{
		if(opacidad > minimo)
			opacidad-=10
		else
		{
			alerta.aumentando(true)
			alerta.disminuyendo(false)
		}
			
	}
}
