import wollok.game.*
import player.*
import covid.*
import barrera.*
import movil.*
object utils {
	const cellSize = 2	

	method cellSize() = cellSize
	
	method random(a,b){ return (a..b).anyOne()}
	
	method getCell(num) = (num * cellSize).truncate(0)
	
	method getPixel(num) = (num / cellSize).truncate(0)
	
	/*Altura sin barra superior*/
	method alturaJuego() = game.height() - self.getPixel(80)
	
	method configTeclas()
	{
		//keyboard.w().onPressDo {jugador.saltar()}
		//keyboard.s().onPressDo {jugador.deslizarse()}
		/*
		keyboard.w().onPressDo {player.direccion(arriba)}
		keyboard.s().onPressDo {player.direccion(abajo)}
		keyboard.a().onPressDo {player.direccion(izquierda)}
		keyboard.d().onPressDo {player.direccion(derecha)}
		*/
		keyboard.w().onPressDo {player.cambiarDireccion(arriba)}
		keyboard.s().onPressDo {player.cambiarDireccion(abajo)}
		keyboard.a().onPressDo {player.cambiarDireccion(izquierda)}
		keyboard.d().onPressDo {player.cambiarDireccion(derecha)}
		keyboard.e().onPressDo {player.usarPowerUp()}
		
		keyboard.c().onPressDo {player.direccion(quieto)}
		
		keyboard.up().onPressDo {covid.cambiarDireccion(arriba)}
		keyboard.down().onPressDo {covid.cambiarDireccion(abajo)}
		keyboard.left().onPressDo {covid.cambiarDireccion(izquierda)}
		keyboard.right().onPressDo {covid.cambiarDireccion(derecha)}
		keyboard.l().onPressDo {covid.direccion(quieto)}
		keyboard.m().onPressDo {covid.usarPowerUp()}
		//cierro el juego con P, buscar escape?
		keyboard.p().onPressDo {game.stop()}
		
		keyboard.y().onPressDo {barrera.cambiar()}
		keyboard.u().onPressDo {barrera.eliminarComponentes()}
		keyboard.t().onPressDo {player.timer(false)}
	}
	/* Convierto un string en una lista con sus caracteres*/
	method stringToCharList(string)
	{
		const charList = []
		const range = new Range(start = 0, end = string.length() -1 )
		range.forEach { index => charList.add(string.charAt(index)) }
		return charList
	}	
	/*
	colision con barreras
	/*
	method validarBarreras() 
			
 	*/		 
	
	
	
}
