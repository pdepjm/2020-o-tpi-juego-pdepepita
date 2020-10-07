import wollok.game.*
import nave.*
import covid.*

object utils {
	const cellSize = 2	

	method cellSize() = cellSize
	
	method random(a,b){ return (a..b).anyOne()}
	
	method getCell(num) = (num * cellSize).truncate(0)
	
	method getPixel(num) = (num / cellSize).truncate(0)
	
	method configTeclas()
	{
		//keyboard.w().onPressDo {jugador.saltar()}
		//keyboard.s().onPressDo {jugador.deslizarse()}
		keyboard.w().onPressDo {nave.direccion(4)}
		keyboard.a().onPressDo {nave.direccion(3)}
		keyboard.s().onPressDo {nave.direccion(2)}
		keyboard.d().onPressDo {nave.direccion(1)}
		keyboard.c().onPressDo {nave.direccion(0)}
		
		keyboard.up().onPressDo {covid.direccion(4)}
		keyboard.left().onPressDo {covid.direccion(3)}
		keyboard.down().onPressDo {covid.direccion(2)}
		keyboard.right().onPressDo {covid.direccion(1)}
		keyboard.l().onPressDo {covid.direccion(0)}
		//cierro el juego con P, buscar escape?
		keyboard.p().onPressDo {game.stop()}
	}
	
	method validarBordes(position, speed) = 
		position.x() < game.width() - (speed + 2)
		&& position.x() > (speed + 2)
		&& position.y() < game.height() - (speed + 2)
		&& position.y() > (speed + 2) 			
				 
	
	
	
}
