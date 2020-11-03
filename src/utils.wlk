import wollok.game.*
import player.*
import covid.*
import barrera.*
import movil.*
import display.*
import miposicion.*
import bar.*
import alerta.*
import powerup.*
object utils {
	const cellSize = 2	
	var property juegoIniciado = false
	method cellSize() = cellSize
	
	method random(a,b){ return (a..b).anyOne()}
	
	method getCell(num) = (num * cellSize).truncate(0)
	
	method getPixel(num) = (num / cellSize).truncate(0)
	
	/*Altura sin barra superior*/
	method alturaJuego() = game.height() - self.getPixel(80)
	
	method iniciarJuego()
	{
		juegoIniciado = true
		background.image("background.png")
		//game.boardGround("background.png") no tiene efecto.
		
		// Metodos que inicializan las variables de los objetos player y covid
		// (necesario porque ambos heredan de la clase abstracta Movil, 
		// que tiene el metodo Mover() implementado, y de manera abstracta
		// los metodos actualizarImagen() e init()
		// con sesto evitamos repetir el movimiento de los jugadores
		
		player.init()
		covid.init()
		gestorJugadores.agregarJugador(player)
		gestorJugadores.agregarJugador(covid)
		//game.addVisual(barrera)
		game.addVisual(alerta)
		
		// ver bar.wlk, esta es la barra de covid por proximidad
		covidBar.mostrar()
		
		//mostro las barreras
		barrera.init()
		//self.onTicks()
	}
	method onTicks()
	{
		game.onTick(25, 	"mover pjs", 	{ gestorJugadores.moverJugadores() })
		game.onTick(1000, 	"timer", 		{ player.avanzarTimer() })
		game.onTick(50, 	"covidBar", 	{ covidBar.actualizar(covid.obtenerDistancia(player)) })
		game.onTick(50,		"alerta", 		{ alerta.actualizar() })
		game.onTick(8000,	"cajaSorpresa",	{ cajaSorpresa.aparecer() })
		game.onTick(100,	"colisionCaja", { cajaSorpresa.verificarColisiones() })
		game.onTick(100, 	"zonaBarreras", { gestorJugadores.colisionesJugadores() })
	}
	method removerOnTicks()
	{
		game.removeTickEvent("mover pjs")
		game.removeTickEvent("timer")
		game.removeTickEvent("covidBar")
		game.removeTickEvent("cajaSorpresa")
		game.removeTickEvent("colisionCaja")
		game.removeTickEvent("zonaBarreras")
		
	}
	method configTeclas()
	{
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
		
		keyboard.space().onPressDo {barrera.cambiar()}
		keyboard.t().onPressDo {player.timer(false)}
	}
	/* Convierto un string en una lista con sus caracteres*/
	method stringToCharList(string)
	{
		const charList = []
		const range = new Range(start = 0, end = string.length() -1 )
		range.forEach { index => charList.add(string.charAt(index).toLowerCase()) }
		return charList
	}	
	/* Muestra un string en la pantalla  */
	method mostrarMensaje(string)
	{
		const display = new Display(position = 
			new MiPosicion(	x = self.getPixel(100), 
							y = game.height()/2 ))
		
		display.separacion(self.getPixel(18))
		display.mostrarString(string)
		
		game.schedule(2000, {display.init() })
	}
	
}
