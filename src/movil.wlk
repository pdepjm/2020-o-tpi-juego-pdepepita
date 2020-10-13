import wollok.game.*
import utils.*

class Movil{
	var property position 
	var property image
	var property direccion 
	var property velocidad
	var property anchoImg
	var property alturaImg
	
	method init()
	
	method actualizarImagen()
	//direccion es obj arriba|abajo|izquierda|derecha
	method mover(){ direccion.mover(self) }
	
	method obtenerDistancia(pj) = self.position().distance(pj.position())

}

object derecha
{
	method mover(movil)
	{
		//validar colision con barrera
		movil.actualizarImagen()
		if(movil.position().x() <= game.width()- movil.velocidad() - movil.anchoImg())
			movil.position().right(movil.velocidad())
		else{
			movil.position().x(game.width() - movil.anchoImg())
			movil.direccion(quieto)
		}
	}
}

object izquierda
{
	method mover(movil)
	{
		//validar colision con barrera
		movil.actualizarImagen()
		if(movil.position().x() >= movil.velocidad())
			movil.position().left(movil.velocidad())
		else{
			movil.position().x(0)
			movil.direccion(quieto)
		}
	}
}

object arriba
{
	method mover(movil)
	{
		//validar colision con barrera
		movil.actualizarImagen()
		if(movil.position().y() <= utils.alturaJuego() - movil.velocidad() - movil.alturaImg())
			movil.position().up(movil.velocidad())
		else{
			movil.position().y(utils.alturaJuego() - movil.alturaImg())
			movil.direccion(quieto)
		}
	}
}

object abajo
{
	method mover(movil)
	{
		//validar colision con barrera
		movil.actualizarImagen()
		if(movil.position().y() >= movil.velocidad())
			movil.position().down(movil.velocidad())
		else{
			movil.position().y(0)
			movil.direccion(quieto)
		}
	}
}

object quieto
{
	//validar colision con barrera
	method mover(movil){} //para cumplir Polimorfismo
}