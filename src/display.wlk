
import wollok.game.*
import miposicion.*
import utils.*
import player.*

class Caracter
{
	var property position
	var property image
}

class Display 
{
	var property position
	//utilizada para los caracteres
	var property posicionRelativa = game.at(0,0)
	//Para lectura del valor numerico (timer)
	var property valor = 0
	var property separacion = utils.getPixel(18) // toco aca era 16
	var property caracteres = [] //Objetos de clase caracter
	
	method init()
	{
		// Limpio el display de objetos anteriores
		caracteres.forEach{objCaracter => game.removeVisual(objCaracter)}
		caracteres.clear()
		// la posicion relativa de cada caracter a partir de la posicion del display
		posicionRelativa = new MiPosicion(x = position.x(), y = position.y())
	}
	
	method mostrarNum(numero)
	{
		valor = numero
		self.mostrarString(numero.toString())
	}	
	
	/* ---------------------------revisarlo ---------------------------------*/
	method mostrarString(string)
	{
		self.init()
		//caracteres simples
		const lista_caracteres = utils.stringToCharList(string)
		lista_caracteres.forEach{caracter => self.agregar(caracter)}
		//clase caracter	
		caracteres.forEach{objCaracter => game.addVisual(objCaracter )}
	}
	
	method obtenerImg(caracter)
	{
		//Correccion de espacio en string
		if(caracter == " ")
			return "espacio.png"
		else
			return caracter + ".png"
	}
	
	method correccionPosicion(caracter)
	{
		//si es uno de estos caracteres, corrijo la posicion
		if(caracter == 'g' or caracter == 'j' or caracter == 'p' or 
			caracter == 'q' or caracter == 'y' )
			posicionRelativa.down(utils.getPixel(6))
	}
	
	method correccionSeparacion(caracter)
	{		
		if(caracter == 'm' or caracter == 'w')
			separacion += utils.getPixel(6)
		else if(caracter == 'i' or caracter == 'l')
			 separacion -= utils.getPixel(8)
	}
	
	method restaurarParametros(yPrevio, separacionPrevia)
	{
		posicionRelativa.y(yPrevio)
		separacion = separacionPrevia
	}
	
	method agregar(caracter)
	{
		const imagen = self.obtenerImg(caracter)
		
		const yPrevio = posicionRelativa.y()
		const separacionPrevia = separacion
		
		self.correccionPosicion(caracter)
		self.correccionSeparacion(caracter)
		
		const nuevaPos = new MiPosicion(x = posicionRelativa.x(), y = posicionRelativa.y())
		
		//Desplazo la pos para que no se quede un caracter arriba de otro
		posicionRelativa.right(separacion)
		
		//restauro a caracteres en posicion y separacion estandar
		self.restaurarParametros(yPrevio, separacionPrevia)	
		
		//Creo el objeto visible caracter
		const nuevoCaracter = new Caracter(position = nuevaPos, image = imagen)
		caracteres.add(nuevoCaracter)
	}

}
/* --------------------------------------------------------------------------- */
object background 
{
	var property image = "controles.png"
	var property position = new MiPosicion(x = 0, y = 0)
}
