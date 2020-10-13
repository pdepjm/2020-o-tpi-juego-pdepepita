
import wollok.game.*
import miposicion.*
import utils.*
import player.*

class Cifra{
	var property position
	var property image = "0.png"
	
	method valor(numero)
	{
		image = numero.toString() + ".png"
	}
}

object display { //class ?
	var property position
	var property valor = 0
	
	var property cifras = []
	
	//Esto es horrendo, si a alguien se le ocurre una mejor manera cambie esto 
	method mostrarNum(numero)
	{
		valor = numero
		if(cifras.size() > 0)
		{
			cifras.forEach{cifra => game.removeVisual(cifra)}
			cifras.clear()
		}
		var posRelativa = new MiPosicion(x = position.x(), y = position.y())
		
		if(numero < 10){
			var cifra = new Cifra(position = posRelativa) 
			cifra.valor(numero.truncate(0))
			cifras.add(cifra)//str = numero.toString() + ".png"
			//game.say(nave, numero.toString())
		
		}
		else if(numero < 100)
		{
			var cifra = new Cifra(position = new MiPosicion(x = position.x(), y = position.y()))
			cifra.valor((numero/10).truncate(0))
			cifras.add(cifra)
			cifra = new Cifra(position = new MiPosicion(x = position.x() + utils.getPixel(16), y = position.y()))
			//game.say(nave, (numero%10).toString())
			cifra.valor((numero%10).truncate(0))
			cifras.add(cifra)
		}
		else if(numero < 1000)
		{
			var val
			var cifra 
			cifra = new Cifra(position = new MiPosicion(x = position.x(), y = position.y()))
			val = (numero/100).truncate(0)
			cifra.valor(val)
			cifras.add(cifra)
			

			cifra = new Cifra(position = new MiPosicion(x = position.x() + utils.getPixel(16), y = position.y()))
			val =((numero%100)/10 ).truncate(0)
			cifra.valor(val)
			cifras.add(cifra)
			
			cifra = new Cifra(position = new MiPosicion(x = position.x() + utils.getPixel(32), y = position.y()))
			val = ((numero%100)%10).truncate(0)
			cifra.valor(val)
			cifras.add(cifra)
		}
		if(cifras.size() > 0)
			cifras.forEach{cifra => game.addVisual(cifra)}
		
	}
}

