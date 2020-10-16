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
	
	method verificarColision(xi, yi, xf, yf)
	{
		const bXi = position.x()
		const bXf = position.x() + ancho
		const bYi = position.y()
		const bYf = position.y() + altura
		
		
		return 	bXi <= xf and xi <= bXf and 
				bYi <= yf and yi <= bYf
		   
	}
}
object barrera {
	var property orientacion = barreraHorizontal
	var property position = new MiPosicion( x= utils.getPixel(100), y = utils.getPixel(100))
	//var property componentes = [new ComponenteBarrera(position = position, image = "barrerasH.png", ancho=utils.getPixel(550), altura= utils.getPixel(10))]
	var property componentes = []
	var property maxBarreras = 4
	var property largoBarreras = utils.getPixel(380)
	var property anchoBarreras = utils.getPixel(20)
	//var displayColision = new Display(position =  new MiPosicion(x = game.width()/2, y = game.height()/2))
	
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
	
	method verificarColision(obj)
	{
		const xi = obj.position().x()
		const yi = obj.position().y()
		const xf = obj.position().x() + obj.anchoImg()
		const yf = obj.position().y() + obj.alturaImg()
		
		return componentes.any{componente => componente.verificarColision(xi, yi, xf, yf)}
		

	}
	
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
		//console.println("x "+nuevaPos.x() + ", y "+nuevaPos.y())
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
		//const nuevaPos = new MiPosicion( x = 0, y = 0)
		centros.forEach{centro => console.println("c "+centro.toString())}
		const centro = centros.min{centro => (centro - nuevaPos.y()).abs()}
		const min = centros.min()
		const max = centros.max()
		
		//const min= 0
		//console.println("y="+nuevaPos.y()+" min "+min.toString())
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
		//const nuevaPos = new MiPosicion( x = 0, y = 0)
		const centro = centros.min{centro => (centro - nuevaPos.x()).abs()}
		//const min= 0
		const min = centros.min()
		const max = centros.max()
		
		if (centro == min or centro == max)
			movil.direccion(quieto)
				
		nuevaPos.x(centro)
		//console.println("min "+min.toString())
		return nuevaPos
	}
	method centroAfuera(posicion, desplazamiento)
	{
		centros.add(posicion.x() - (desplazamiento - ancho)/2 )
	}
}
