import wollok.game.*
import utils.*

class Movil{
	var property position 
	var property image
	var property direccion 
	var property orientacion
	var property velocidad
	method init()
	
	method mover()
	{
		if(direccion >=1 && direccion <=4)
		{
			self.actualizarImagen(direccion)
			orientacion = direccion
			if(direccion == 1){
				if(position.x() < game.width() - velocidad)
					position.right(velocidad)
				else{
					position.left(velocidad)
					direccion = 0
				}
			}
			else if(direccion == 2){
				if(position.y() > velocidad)
					position.down(velocidad)
				else{
					position.up(velocidad)
					direccion = 0
				}
			}
			else if(direccion == 3){
				if(position.x() > velocidad)
					position.left(velocidad)
				else{
					position.right(velocidad)
					direccion = 0		
				}
			}
			else if(direccion == 4){
				if(position.y() < game.height() - utils.getPixel(40) - velocidad)
					position.up(velocidad)
				else{
					position.down(velocidad)
					direccion = 0
				}
			}		
		}
	}
	method actualizarImagen(dir)

}
