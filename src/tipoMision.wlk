class Boost{
	const multiplicador
	
	method copasEnJuego(mision) = mision.copasBase()*multiplicador
}

object bonus{ //tambien podrian ser clases
	method copasEnJuego(mision) = mision.copasBase() + mision.cantidadParticipantes()
}

object comun{
	method copasEnJuego(mision) = mision.copasBase()
}