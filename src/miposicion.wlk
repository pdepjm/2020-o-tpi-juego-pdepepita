/*Para mejorar performance, esta clase usa atributos variables en vez de constantes
(las posiciones van a estar cambiando, es ridiculo e implica tener que crear nuevos 
objetos Posicion cada vez, lo cual destruye performance porque el garbage colector 
no los elimina correctamente lo suficientemente rapido)
*/
class MiPosicion 
{
	var property x
	var property y
	//metodos para mover una posicion una cierta cantidad en una direccion
	method arriba(cantidad)
	{
		y += cantidad
		
	}
	method abajo(cantidad)
	{
		y -= cantidad
	}
	method izq(cantidad)
	{
		x -= cantidad
	}
	method der(cantidad)
	{
		x += cantidad
	}
}