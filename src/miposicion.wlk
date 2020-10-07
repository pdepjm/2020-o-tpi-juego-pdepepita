/*Para mejorar performance, esta clase usa atributos variables en vez de constantes
(las posiciones van a estar cambiando, es ridiculo e implica tener que crear nuevos 
objetos Posicion cada vez, lo cual destruye performance porque el garbage colector 
no los elimina correctamente lo suficientemente rapido al hacer multiples movimientos
por segundo como [Movil].mover() )
*/
class MiPosicion 
{
	var property x
	var property y
	//metodos para mover una posicion una cierta cantidad en una direccion
	method up(cantidad)
	{
		y += cantidad
		
	}
	method down(cantidad)
	{
		y -= cantidad
	}
	method left(cantidad)
	{
		x -= cantidad
	}
	method right(cantidad)
	{
		x += cantidad
	}
	//Metodo
	method distance(position) 
	{
	    self.checkNotNull(position, "distance")
	    const deltaX = x - position.x()
	    const deltaY = y - position.y()
	    return (deltaX.square() + deltaY.square()).squareRoot() 
  	}
}