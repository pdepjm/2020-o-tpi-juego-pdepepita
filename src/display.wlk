
import wollok.game.*
import miposicion.*
import utils.*
import player.*

class Caracter{
	var property position
	var property image
}

object display { //class ?
	var property position
	//utilizada para los caracteres
	
	var property posicionRelativa
	var property valor = 0
	
	var property caracteres = [] //Objetos de clase caracter
	
	method mostrarNum(numero)
	{
		valor = numero
		self.mostrarString(numero.toString())
	}	
	
	method mostrarString(string)
	{
		caracteres.forEach{objCaracter => game.removeVisual(objCaracter)}
		caracteres.clear()
		
		posicionRelativa = new MiPosicion(x = position.x(), y = position.y())
		
		//caracteres simples
		const lista_caracteres = utils.stringToCharList(string)
		lista_caracteres.forEach{caracter => self.agregar(caracter)}
		//clase caracter
		caracteres.forEach{objCaracter => game.addVisual(objCaracter )}
	}
		
	method agregar(caracter)
	{
		const imagen = caracter + ".png"
		
		posicionRelativa.right(utils.getPixel(16))
		const nuevaPos = new MiPosicion(x = posicionRelativa.x(), y = posicionRelativa.y())
		
		const nuevoCaracter = new Caracter(position = nuevaPos, image = imagen)
		caracteres.add(nuevoCaracter)
		
	}
}

