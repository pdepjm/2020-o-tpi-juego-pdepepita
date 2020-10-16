import wollok.game.*
import utils.*
import barrera.*
class Movil{
	var property position 
	var property image
	var property direccion 
	var property orientacion = direccion
	var property velocidad
	var property anchoImg
	var property alturaImg
	var property multiplicadorRebote = 3
	var enZonaDeBarreras = false
	method init()
	
	method actualizarImagen()
	//direccion es obj arriba|abajo|izquierda|derecha
	method mover(){ 
		direccion.mover(self)
	}
	
	method obtenerDistancia(pj) = self.position().distance(pj.position())
	
	method verificarColision()
	{
		/*
		if (barrera.verificarColision(self))
			direccion.rebotar(self)
			*/
	}
	method verificarZonaDeBarreras()
	{ 
		const previo = enZonaDeBarreras
		
		enZonaDeBarreras = position.x() + anchoImg >= barrera.position().x() 
		and position.x() <= barrera.position().x() + barrera.largoBarreras() 
		and position.y() + alturaImg >= barrera.position().y() 
		and position.y() <= barrera.position().y() + barrera.largoBarreras()
		
		//Si entro a la zona, lo centro
		if (previo != enZonaDeBarreras and enZonaDeBarreras)
			self.centrarEnBarrera()
	}
	method centrarEnBarrera()
	{
		position = barrera.obtenerCentroCercano(self)
	}
	
	method verificarDireccion(dir)
	{
		//Solo permitir el movimiento paralelo a las barreras en esa zona
		if(enZonaDeBarreras) 
		{
			//self.centrarEnBarrera()
			
			if(barrera.orientacion().equals(barreraHorizontal))
				return dir.equals(izquierda) or dir.equals(derecha)
			else
				return dir.equals(arriba) or dir.equals(abajo)
		}
		return true
	}
	
	method cambiarDireccion(dir)
	{
		if(self.verificarDireccion(dir))
			direccion = dir
	}
	
}

object derecha
{
	method mover(movil)
	{
		movil.actualizarImagen()
		movil.orientacion(movil.direccion())
		if(movil.position().x() <= game.width()- movil.velocidad() - movil.anchoImg())
		{	
			movil.position().right(movil.velocidad())
		}
		else{
			movil.position().x(game.width() - movil.anchoImg())
			movil.direccion(quieto)
		}
	}
	method rebotar(movil)
	{
		movil.position().left(movil.velocidad()* movil.multiplicadorRebote())
		movil.direccion(quieto)	
	}
}

object izquierda
{
	method mover(movil)
	{
		movil.actualizarImagen()
		movil.orientacion(movil.direccion())
		if(movil.position().x() >= movil.velocidad()){
			movil.position().left(movil.velocidad())
			
		}
		else{
			movil.position().x(0)
			movil.direccion(quieto)
		}
	}
	method rebotar(movil)
	{
		movil.position().right(movil.velocidad()*movil.multiplicadorRebote())
		movil.direccion(quieto)	
	}
}

object arriba
{
	method mover(movil)
	{
		movil.actualizarImagen()
		movil.orientacion(movil.direccion())
		if(movil.position().y() <= utils.alturaJuego() - movil.velocidad() - movil.alturaImg()){
			movil.position().up(movil.velocidad())					
		}
		else{
			movil.position().y(utils.alturaJuego() - movil.alturaImg())
			movil.direccion(quieto)
		}
	}
	
	method rebotar(movil)
	{
		movil.position().down(movil.velocidad()*movil.multiplicadorRebote())
		movil.direccion(quieto)	
	}
}

object abajo
{
	method mover(movil)
	{
		movil.actualizarImagen()
		movil.orientacion(movil.direccion())
		if(movil.position().y() >= movil.velocidad()){
			movil.position().down(movil.velocidad())
			
		}
		else{
			movil.position().y(0)
			movil.direccion(quieto)
		}
	}
	
	method rebotar(movil)
	{
		movil.position().up(movil.velocidad()*movil.multiplicadorRebote())
		movil.direccion(quieto)
	}
	
}

object quieto
{
	//validar colision con barrera
	method mover(movil){} //para cumplir Polimorfismo
	
	method rebotar(movil)
	{
		movil.orientacion().rebotar(movil)
	}
}