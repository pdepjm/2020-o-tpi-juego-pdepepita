import miposicion.*
import utils.*
import wollok.game.*
import display.*
import movil.*

class ComponenteBarrera
{
	var property position
	var property image
	var property ancho
	var property altura
}

object barrera {
	var property orientacion = barreraHorizontal
	var property position = new MiPosicion( x= utils.getPixel(100), y = utils.getPixel(100))
	var property componentes = []
	var property maxBarreras = 4
	var property largoBarreras = utils.getPixel(380)
	var property anchoBarreras = utils.getPixel(20)
	
	method init()
	{
		self.eliminarComponentes()
		self.generarComponentes()
		self.mostrarComponentes()
	}
	/*Cambio entre barreras horizontales y verticales */
	method cambiar()
	{
		if(orientacion.equals(barreraHorizontal))
			orientacion = barreraVertical
		else
			orientacion = barreraHorizontal
		
		self.init()
		//reubico los jugadores que hagan falta
		gestorJugadores.reubicar(orientacion)
	}
	
	method eliminarComponentes() 
	{
		if(componentes.size() > 0)
		{
			componentes.forEach{componente => game.removeVisual(componente)}
			componentes.clear()
		}
		barreraHorizontal.centros().clear()
		barreraVertical.centros().clear()
	}
	/*Me permite generar los componentese de las barreras*/
	method generarComponentes()
	{
		const posicionRelativa = new MiPosicion(x = position.x(), y = position.y())
		
		const desplazamiento = utils.getPixel(100) + anchoBarreras
		orientacion.centroAfuera(posicionRelativa, desplazamiento)
		//creo tantas nuevas barreras como diga el maximo declarado
		new Range( start = 0, end = maxBarreras -1 ).forEach{indice => orientacion.nuevaBarrera(posicionRelativa, desplazamiento, componentes) }
	}
	
	method mostrarComponentes() 
	{ 
		componentes.forEach{componente => game.addVisual(componente)}
	}
	
	/*los "centros" son los puntos x o y entre barreras*/
	method obtenerCentroCercano(movil) = orientacion.obtenerCentro(movil) 
	
}

//objetos orientacion
object barreraHorizontal{
	const img = "barreraH.png"
	const ancho = utils.getPixel(380)
	const altura = utils.getPixel(20)
	const centros = [] //posicion Y entre cada barrera
	
	method nuevaBarrera(posicion, desplazamiento, componentes)
	{
		const nuevaPos = new MiPosicion (x = posicion.x(), y = posicion.y())
		const bar = new ComponenteBarrera(position = nuevaPos, ancho = ancho, altura = altura, image = img)
		componentes.add(bar)
		centros.add(posicion.y() + (desplazamiento - altura)/2)
		posicion.up(desplazamiento)
	}
	
	method centros() = centros
	
	method obtenerCentro(movil)
	{
		const nuevaPos = new MiPosicion( x = movil.position().x(), y = movil.position().y())
		// obtengo el "centro" con menor distancia a la posicion del movil
		const centro = centros.min{centro => (centro - nuevaPos.y()).abs()}
		// obtengo los externos a la zona de barreras, para saber si tengo que hacer rebotar al movil
		const min = centros.min()
		const max = centros.max()
		
		if (centro == min or centro == max)
			movil.direccion(quieto)
			
		nuevaPos.y(centro)
		return nuevaPos
	}	
	/* es un "centro" adicional para que si el movil choca la barrera por afuera, rebote y no entre a la zona*/
	method centroAfuera(posicion, desplazamiento) 
	{
		centros.add(posicion.y() - (desplazamiento - altura)/2)
	}
}

object barreraVertical{
	const img = "barreraV.png"
	const ancho = utils.getPixel(20)
	const altura = utils.getPixel(380)
	const centros = [] //posicion X entre cada barrera
	
	method nuevaBarrera(posicion, desplazamiento, componentes)
	{
		const nuevaPos = new MiPosicion (x = posicion.x(), y = posicion.y())
		const bar = new ComponenteBarrera(position = nuevaPos, ancho = ancho, altura = altura, image = img)
		componentes.add(bar)
		centros.add(posicion.x() + (desplazamiento - ancho)/2)
		posicion.right(desplazamiento)
	}
	
	method centros() = centros
	
	method obtenerCentro(movil)
	{
		const nuevaPos = new MiPosicion( x = movil.position().x(), y = movil.position().y())
		// obtengo el "centro" con menor distancia a la posicion del movil
		const centro = centros.min{centro => (centro - nuevaPos.x()).abs()}
		// obtengo los externos a la zona de barreras, para saber si tengo que hacer rebotar al movil
		const min = centros.min()
		const max = centros.max()
		
		if (centro == min or centro == max) //lo freno para evitar repeticiones de rebote
			movil.direccion(quieto)
		
		nuevaPos.x(centro)
		return nuevaPos
	}
	/* es un "centro" adicional para que si el movil choca la barrera por afuera, rebote y no entre a la zona*/
	method centroAfuera(posicion, desplazamiento)
	{
		centros.add(posicion.x() - (desplazamiento - ancho)/2 )
	}
}
