import wollok.game.*
import utils.*
import barrera.*
import player.*
import covid.*

class Movil{
	var property position 
	var property image
	var property direccion 
	var property orientacion = direccion
	var property velocidad
	var property anchoImg
	var property alturaImg
	var property multiplicadorRebote = 3
	var property enZonaDeBarreras = false
	var property powerUpsPosibles
	var property posicionPowerUpX
	var property posicionPowerUpY = utils.getPixel(586)
	const powerUps = []
	
	var desplazamiento = 0
	method init()
	
	method actualizarImagen()
	//direccion es obj arriba|abajo|izquierda|derecha
	method mover(){ 
		direccion.mover(self)
	}
	
	method obtenerDistancia(pj) = self.position().distance(pj.position())
	
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
	method agregarEn(powerUp)
	{
		powerUp.position().x(desplazamiento)
		powerUp.position().y(posicionPowerUpY)
		powerUp.init()
		game.addVisual(powerUp)
		desplazamiento+=utils.getPixel(40);
	}
	method quitarPower(powerUp)
	{
		if(game.hasVisual(powerUp)) game.removeVisual(powerUp)
	}
	method actualizarBarraSuperior(){
		desplazamiento = posicionPowerUpX;
		
		if(powerUps.size() > 0)
			powerUps.forEach{ powerUp => self.quitarPower(powerUp)}
		
		powerUps.forEach{ powerUp => self.agregarEn(powerUp)}

	} //implementar imagenes en barrera superior
	
	method noTiene(powerUp)	= not powerUps.contains(powerUp)
	method agregarPowerUp()
	{
		if(powerUps.size() < 4)
		{
			const powerUp = powerUpsPosibles.anyOne()
			
			if(self.noTiene(powerUp))
			{
				powerUps.add(powerUp)
				console.println("agarro "+ powerUp.toString())
				self.actualizarBarraSuperior()
				utils.mostrarMensaje("powerup "+powerUp.toString())
				//agregar a display
			}
		}
	}
	
	method usarPowerUp()
	{
		if(powerUps.size() > 0)
		{
			const powerUp = powerUps.first()
			self.quitarPower(powerUp)
			powerUps.remove(powerUp)
			console.println("uso "+ powerUp.toString())
			
			utils.mostrarMensaje("activado "+powerUp.toString())
			powerUp.usar(self)			
		}
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

object gestorJugadores
{
	var property jugadores = []
	
	method agregarJugador(jugador){ 
		jugadores.add(jugador)
		game.addVisual(jugador)
	}
	method moverJugadores(){ jugadores.forEach{jugador=> jugador.mover()} }
	method colisionesJugadores() {jugadores.forEach{jugador => jugador.verificarZonaDeBarreras()}}
	/* esto se llama cuando ocurre un cambio de orientacion de barreras */
	method reubicar(orientacion)
	{
		jugadores.forEach{jugador => 
			if(jugador.enZonaDeBarreras())
			{
				jugador.centrarEnBarrera()
				jugador.direccion(quieto)
			}
		}
	}
	/*powerup separar */
	method separarJugadores()
	{
		covid.position().x(0)
		covid.position().y(utils.alturaJuego() - covid.alturaImg())
		
		player.position().y(0)
		player.position().x(game.width() - player.anchoImg())
		
		jugadores.forEach{jugador => jugador.direccion(quieto)}
	}
	
}