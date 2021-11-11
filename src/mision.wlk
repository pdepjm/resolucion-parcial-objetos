import tipoMision.*

class Mision {
	const participantes
	const tipo
	
	method puedeSerSuperada()
	method puedeRealizarse()
	method copasEnJuego() = tipo.copasEnJuego(self)
	
	
	method realizarse(){
		
		if(!self.puedeRealizarse()){
			throw new DomainException(message = "Misión no puede empezar")
		}
		
		if(self.puedeSerSuperada()){
			participantes.forEach({participante => participante.ganarCopas(self.copasEnJuego())})
		}
		else{
			participantes.forEach({participante => participante.perderCopas(self.copasEnJuego())})
		}
	}
	
	method cantidadParticipantes() = participantes.size()
}

class MisionIndividual inherits Mision{
	const dificultad
	
	method copasBase() = 2*dificultad

	override method puedeSerSuperada() = self.participante().tieneEstrategia() || self.participante().destreza() > dificultad
	
	override method puedeRealizarse() = self.participante().copas() >=10

	method participante() = participantes.get(0) //Me hace ruido.

}

class MisionPorEquipo inherits Mision{
	
	method copasBase() = 50/participantes.size()
	
	override method puedeSerSuperada(){
		const participantesConEstrategia = participantes.filter({participante => participante.tieneEstrategia()})
		return participantesConEstrategia.size() > participantes.size()/2 ||  participantes.all({participante => participante.destreza() > 400})
	}
	
	override method puedeRealizarse() = participantes.sum({personaje => personaje.copas()}) >= 60
	
	
}