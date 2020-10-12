import miposicion.*
import utils.*

object barrera {
	var property barrera = barreraHorizontal
	var property position = new MiPosicion( x= utils.getPixel(75), y = utils.getPixel(55))
	var property image = barrera.img()
	method cambiar()
	{
		if(barrera == barreraHorizontal)
			barrera = barreraVertical
		else
			barrera = barreraHorizontal
			
		image = barrera.img()
	}
	
}

object barreraHorizontal{
	method img() = "barrerasH.png"
}

object barreraVertical{
	method img() = "barrerasV.png"
}