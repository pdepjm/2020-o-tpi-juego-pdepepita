import wollok.game.*
import cohete.*
import miposicion.*
/* jugador con animacion para correr, hacer que implemente mover ? en el caso de ser usado*/
object jugador {

	var property image = "run1.png"
	var property position = new MiPosicion(x = game.width()/2, y = game.height()/2)
	
	var property estado = corriendo
	
	method mover() = estado.mover(self)
	
	
	method saltar()
	{
		estado = saltando
	}
	method deslizarse()
	{
		estado = deslizandose
	}
	method correr()
	{
		estado = corriendo
	}
	
}

object corriendo
{
	var indiceImagen = 0
	method mover(jugador)
	{
		var img = "run" + (indiceImagen + 1).toString() + ".png"
		jugador.image(img)
		
		if(indiceImagen < 11)
			indiceImagen+=1
		else
			indiceImagen = 0
		
	}
}
object saltando
{
	const tiempoMax = 16
	var tiempo = 0
	const multiplicador = 1
	
	method mover(jugador)
	{
		
		
		if(tiempo < tiempoMax)
		{
			
			if(tiempo < tiempoMax/2)
			{
				jugador.position().up(multiplicador)
				jugador.image("jump.png")	
			}
			else
			{
				jugador.position().down(multiplicador)
				jugador.image("fall.png")	
			}
			tiempo+=1
			
		}
		else
		{
			tiempo = 0
			jugador.correr()
		}
		
	}
}
object deslizandose
{
	const tiempoMax = 8
	var tiempo = 0
	
	method mover(jugador)
	{
		if(tiempo < tiempoMax)
		{
			jugador.image("slide.png")
			tiempo +=1
		}
		else
		{
			tiempo = 0
			jugador.correr()
		}
	}
}
