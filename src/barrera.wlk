import miposicion.*
import utils.*
import wollok.game.*
import display.*

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
	var property position = new MiPosicion( x= utils.getPixel(75), y = utils.getPixel(55))
	//var property componentes = [new ComponenteBarrera(position = position, image = "barrerasH.png", ancho=utils.getPixel(550), altura= utils.getPixel(10))]
	var property componentes = []
	var property maxBarreras = 4

	//var displayColision = new Display(position =  new MiPosicion(x = game.width()/2, y = game.height()/2))
	
	/*Cambio entre barreras horizontales y verticales */
	method cambiar()
	{
		if(orientacion.equals(barreraHorizontal))
			orientacion = barreraVertical
		else
			orientacion = barreraHorizontal
		
		self.eliminarComponentes()
		self.generarComponentes()
		self.mostrarComponentes()
	}
	
	method eliminarComponentes() 
	{
		if(componentes.size() > 0)
		{
			componentes.forEach{componente => game.removeVisual(componente)}
			componentes.clear()
		}
	}
	
	method generarComponentes()
	{
		const posicionRelativa = new MiPosicion(x = position.x(), y = position.y())
		const desplazamiento = orientacion.obtenerDesp(maxBarreras)
		new Range( start = 0, end = maxBarreras).forEach{indice => orientacion.nuevaBarrera(posicionRelativa, desplazamiento, componentes) }
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
	
}


object barreraHorizontal{
	const img = "barreraH.png"
	const ancho = utils.getPixel(550)
	const altura = utils.getPixel(10)
	
	//method obtenerDesp(cant) = utils.getPixel(((550 - 10*cant) / (cant-1) ) + 10)
	method obtenerDesp(cant) = ((ancho - altura*cant) / (cant - 1)) + altura
	method nuevaBarrera(posicion, desplazamiento, componentes)
	{
		const nuevaPos = new MiPosicion (x = posicion.x(), y = posicion.y())
		const bar = new ComponenteBarrera(position = nuevaPos, ancho = ancho, altura = altura, image = img)
		componentes.add(bar)
		posicion.up(desplazamiento)
	}
	
}

object barreraVertical{
	const img = "barreraV.png"
	const ancho = utils.getPixel(10)
	const altura = utils.getPixel(550)
	
	method obtenerDesp(cant) = ((altura - ancho*cant) / (cant-1) ) + ancho
	
	method nuevaBarrera(posicion, desplazamiento, componentes)
	{
		const nuevaPos = new MiPosicion (x = posicion.x(), y = posicion.y())
		const bar = new ComponenteBarrera(position = nuevaPos, ancho = ancho, altura = altura, image = img)
		componentes.add(bar)
		posicion.right(desplazamiento)
	}
}