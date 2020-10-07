import wollok.game.*
import cohete.*
import miposicion.*
import utils.*
import movil.*
import covid.*
import cartel.*

object nave inherits Movil{

	//self.direccion()//a donde se esta moviendo
	//var property orientacion = 4//a donde apunta, no necesariamente a donde se esta moviendo
	//var property position = new MiPosicion(x = game.width()/2, y = game.height()/2) //Este objeto nos permite saber nuestra posicion, ver miposicion.wlk
	var property cohetes = []
	//var property image = "nave4.png"
	//var property velocidad = 3
	/*Este metodo se ejecuta todo el tiempo para mover a la nave, en el caso de que la direccion sea 10 se frena en el lugar (default) 
	--->falta validar bordes
	* */
	//estado  1 "victoria", -1 "derrota", 0 "en juego"
	var estado = 0
	
	override method init()
	{
		self.image("nave4.png")
		self.position(new MiPosicion(x = game.width()/2, y = game.height()/2))
		self.direccion(0)
		self.orientacion(4)
		self.velocidad(3)
		
	}
	override method actualizarImagen(dir)
	{
		self.image("nave" + self.direccion().toString() + ".png")
	}
	method gano() = estado == 1
	method perdio() = estado == -1
	
	method estado(est) { 
		estado = est
		
		game.removeVisual(self)
		game.removeVisual(covid)
		if(estado == -1)
			cartel.image("derrota.png")
		else if (estado == 1)
			cartel.image("victoria.png")
		game.addVisual(cartel)
	}
	
	/*
	/*Se activa al apretar espacio, crea un cohete, lo añade a la lista de cohetes y lo muestra 
	method dispararCohete()
	{
		//La declaracion/inicializacion rara es porque a Cohete le tengo que pasar una posicion, 
		//y creo una con MiPosicion, que le tengo que mandar x e y
		
		const cohete = new Cohete(position = new MiPosicion(x = position.x(), y = position.y()) )
		
		//Aca va orientacion y no direccion porque en el caso de que dispares quieto, el cohete tendria direccion 10 (no se moveria)
		cohete.cambiarDir(self.orientacion())  
		
		cohetes.add(cohete)
		game.addVisual(cohete)
	}
	method eliminarCohete(cohete)
	{
		cohetes.remove(cohete)
	} */
	
}

