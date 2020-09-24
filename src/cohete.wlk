import wollok.game.*
import miposicion.*
import nave.*

/*Esto es una clase, porque voy a tener muchos cohetes con estas caracteristicas, en una lista (ver nave.wlk) */
class Cohete {
	var property position
	
	var imagenCohete = coheteArriba //aca se guardan los objetos que estan al final, con las distintas imagenes
	var direccion = 0
	
	/*Este metodo se ejecuta para todos los cohetes en pantalla, y hace que se muevan en su direccion
	 cuando llegan al borde de la pantalla, se los elimina de la lista de cohetes y de la pantalla, para liberar memoria
	 */
	method mover()
	{
		if(direccion == 1){
			if(position.x() < game.width())
				position.der(1)
			else
				self.destroy()
		}
		else if(direccion == 2)
			if(position.y() > 0)
				position.abajo(1)
			else
				self.destroy()
		else if(direccion == 3)
			if(position.x() > 0)
				position.izq(1)
			else
				self.destroy()
		else if(direccion == 4)
			if(position.y() < game.height())
				position.arriba(1)
			else
				self.destroy()
	}
	method destroy()
	{
		game.removeVisual(self)
		nave.eliminarCohete(self)
	}
	//Util para modificar la direccion una vez creado el cohete
	method cambiarDir(dir)
	{
		direccion = dir
		//game.say(self, direccion.toString())
		if(direccion == 1)
			imagenCohete = coheteDer
		else if(direccion == 2)
			imagenCohete = coheteAbajo
		else if(direccion == 3)
			imagenCohete = coheteIzq
		else
			imagenCohete = coheteArriba
		
	}
	//method position() = posicion
	method image() = imagenCohete.img()
}

object coheteArriba
{
	method img() = "coheteU.png"
}
object coheteAbajo
{
	method img() = "coheteD.png"
}
object coheteIzq
{
	method img() = "coheteL.png"
}
object coheteDer
{
	method img() = "coheteR.png"
}