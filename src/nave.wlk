import wollok.game.*
import cohete.*
import miposicion.*

object nave {

	var property direccion = 10 //a donde se esta moviendo
	var property orientacion = 4//a donde apunta, no necesariamente a donde se esta moviendo
	var property position = new MiPosicion(x = game.width()/2, y = game.height()/2) //Este objeto nos permite saber nuestra posicion, ver miposicion.wlk
	var imagenNave = imgArriba //aca se guardan los objetos que estan al final, con las distintas imagenes
	var property cohetes = []
	
	/*Este metodo se ejecuta todo el tiempo para mover a la nave, en el caso de que la direccion sea 10 se frena en el lugar (default) 
	--->falta validar bordes
	* */
	method mover()
	{
		if(direccion >=1 && direccion <=4)
		{
			orientacion = direccion
			if(direccion == 1){
				position.der(1)
				imagenNave = imgDer
				
			}
			else if(direccion == 2){
				position.abajo(1)
				imagenNave = imgAbajo
			}
			else if(direccion == 3){
				position.izq(1)
				imagenNave = imgIzq
			}
			else if(direccion == 4){
				position.arriba(1)
				imagenNave = imgArriba
			}
		}
	}	
	/*Se activa al apretar espacio, crea un cohete, lo añade a la lista de cohetes y lo muestra */
	method dispararCohete()
	{
		/*La declaracion/inicializacion rara es porque a Cohete le tengo que pasar una posicion, 
		y creo una con MiPosicion, que le tengo que mandar x e y
		*/
		const cohete = new Cohete(position = new MiPosicion(x = position.x(), y = position.y()) )
		
		//Aca va orientacion y no direccion porque en el caso de que dispares quieto, el cohete tendria direccion 10 (no se moveria)
		cohete.cambiarDir(orientacion)  
		
		cohetes.add(cohete)
		game.addVisual(cohete)
	}
	method eliminarCohete(cohete)
	{
		cohetes.remove(cohete)
	}
	
	method image() = imagenNave.img()

}

object imgArriba
{
	method img() = "naveU.png"
}
object imgAbajo
{
	method img() = "naveD.png"
}
object imgIzq
{
	method img() = "naveL.png"
}
object imgDer
{
	method img() = "naveR.png"
}
