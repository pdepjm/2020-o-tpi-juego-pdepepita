
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
	//var property position
	//utilizada para los caracteres
	var property posicionesX = [game.width() - utils.getPixel(90), game.width() - utils.getPixel(72) ]
	var property posicionY = game.height() - utils.getPixel(30)
	
	//var property posicionRelativa = game.at(0,0)
	//Para lectura del valor numerico (timer)
	var property valor = 0
	//var property separacion = utils.getPixel(18) // toco aca era 16
	var property caracteres = [] //Objetos de clase caracter
	
	method init()
	{
		// Limpio el display de objetos anteriores
		caracteres.forEach{objCaracter => game.removeVisual(objCaracter)}
		caracteres.clear()
		// la posicion relativa de cada caracter a partir de la posicion del display
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
		var sector = 0
		lista_caracteres.forEach{caracter => self.agregar(caracter, sector) sector++}
		//clase caracter	
		caracteres.forEach{objCaracter => game.addVisual(objCaracter )}
	}
	
	method obtenerImg(caracter) = caracter + ".png"


	
	method agregar(caracter,sector)
	{
		const imagen = self.obtenerImg(caracter)
		
		const x = posicionesX.get(sector)
		const nuevaPos = new MiPosicion(x = x, y = posicionY)
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
