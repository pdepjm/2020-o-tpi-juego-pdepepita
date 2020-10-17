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
		// implementar de alguna forma que el jugador se frene (?) y se centre al cambiar 
		// de direccion la barrera (sino las atraviesa)
		// cambiar direccion quizas
		self.init()
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
	
	method generarComponentes()
	{
		const posicionRelativa = new MiPosicion(x = position.x(), y = position.y())
		
		const desplazamiento = utils.getPixel(100) + anchoBarreras
		orientacion.centroAfuera(posicionRelativa, desplazamiento)
		new Range( start = 0, end = maxBarreras -1 ).forEach{indice => orientacion.nuevaBarrera(posicionRelativa, desplazamiento, componentes) }
	}
	
	method mostrarComponentes() { componentes.forEach{componente => game.addVisual(componente)} }
	

	method obtenerCentroCercano(movil) = orientacion.obtenerCentro(movil) 
	
}


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
	method centroAfuera(posicion, desplazamiento)
	{
		centros.add(posicion.y() - (desplazamiento - altura)/2)
	}
	method obtenerCentro(movil)
	{
		const nuevaPos = new MiPosicion( x = movil.position().x(), y = movil.position().y())
		const centro = centros.min{centro => (centro - nuevaPos.y()).abs()}
		const min = centros.min()
		const max = centros.max()
		
		if (centro == min or centro == max)
			movil.direccion(quieto)
			
		nuevaPos.y(centro)
		return nuevaPos
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
		const centro = centros.min{centro => (centro - nuevaPos.x()).abs()}
		const min = centros.min()
		const max = centros.max()
		
		if (centro == min or centro == max)
			movil.direccion(quieto)
				
		nuevaPos.x(centro)
		return nuevaPos
	}
	method centroAfuera(posicion, desplazamiento)
	{
		centros.add(posicion.x() - (desplazamiento - ancho)/2 )
	}
}
