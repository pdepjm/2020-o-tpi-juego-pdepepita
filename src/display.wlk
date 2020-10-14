
import wollok.game.*
import miposicion.*
import utils.*
import player.*

class Caracter{
	var property position
	var property image
}

class Display { //class ?
	var property position
	//utilizada para los caracteres
	var property posicionRelativa = game.at(0,0)
	//Para lectura del valor numerico (timer)
	var property valor = 0
	
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
	
	method mostrarString(string)
	{
		self.init()
		//caracteres simples
		const lista_caracteres = utils.stringToCharList(string)
		lista_caracteres.forEach{caracter => self.agregar(caracter)}
		//clase caracter	
		caracteres.forEach{objCaracter => game.addVisual(objCaracter )}
	}
		
	method agregar(caracter)
	{
		const imagen = caracter + ".png"
		//Desplazo la pos para que no se quede un caracter arriba de otro
		posicionRelativa.right(utils.getPixel(16))
		const nuevaPos = new MiPosicion(x = posicionRelativa.x(), y = posicionRelativa.y())
		
		const nuevoCaracter = new Caracter(position = nuevaPos, image = imagen)
		caracteres.add(nuevoCaracter)
		
	}

}

