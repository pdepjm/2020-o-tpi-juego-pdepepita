import wollok.game.*
import nave.*
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
	method alturaJuego() = game.height() - self.getPixel(40)
	
	method configTeclas()
	{
		//keyboard.w().onPressDo {jugador.saltar()}
		//keyboard.s().onPressDo {jugador.deslizarse()}
		keyboard.w().onPressDo {nave.direccion(arriba)}
		keyboard.s().onPressDo {nave.direccion(abajo)}
		keyboard.a().onPressDo {nave.direccion(izquierda)}
		keyboard.d().onPressDo {nave.direccion(derecha)}
		keyboard.c().onPressDo {nave.direccion(quieto)}
		
		keyboard.up().onPressDo {covid.direccion(arriba)}
		keyboard.down().onPressDo {covid.direccion(abajo)}
		keyboard.left().onPressDo {covid.direccion(izquierda)}
		keyboard.right().onPressDo {covid.direccion(derecha)}
		keyboard.l().onPressDo {covid.direccion(quieto)}
		//cierro el juego con P, buscar escape?
		keyboard.p().onPressDo {game.stop()}
		
		keyboard.y().onPressDo {barrera.cambiar()}
	}
	
	/*
	method validarBordes(position, speed) = 
		position.x() < game.width() - (speed + 2)
		&& position.x() > (speed + 2)
		&& position.y() < game.height() - (speed + 2)
		&& position.y() > (speed + 2) 			
 	*/		 
	
	
	
}
