import tipoMision.*

class Mision {
	const tipo
	
	method puedeSerSuperada()
	method puedeRealizarse()
	method ganar()
	method perder()
	method copasEnJuego() = tipo.copasEnJuego(self)
	
	
	method realizarse(){
		
		if(!self.puedeRealizarse()){
			throw new DomainException(message = "Misión no puede empezar")
		}
		
		if(self.puedeSerSuperada()){
			self.ganar()
		}
		else{
			self.perder()
		}
	}
	
	method premiarParticipante(participante){
		participante.ganarCopas(self.copasEnJuego())
	}
	
	method castigarParticipante(participante){
		participante.perderCopas(self.copasEnJuego())
	}
	
}

class MisionIndividual inherits Mision{
	const dificultad
	const participante
	
	method copasBase() = 2*dificultad

	override method puedeSerSuperada() = participante.tieneEstrategia() || participante.destreza() > dificultad
	
	override method puedeRealizarse() = participante.copas() >=10

	method cantidadParticipantes() = 1
	
	override method ganar(){
		self.premiarParticipante(participante)
	}
	
	override method perder(){
		self.castigarParticipante(participante)
	}
}

class MisionPorEquipo inherits Mision{
	const participantes
	
	method copasBase() = 50/participantes.size()
	
	override method puedeSerSuperada(){
		const participantesConEstrategia = participantes.filter({participante => participante.tieneEstrategia()})
		return participantesConEstrategia.size() > participantes.size()/2 ||  participantes.all({participante => participante.destreza() > 400})
	}
	
	override method puedeRealizarse() = participantes.sum({personaje => personaje.copas()}) >= 60
	
	override method ganar(){
		participantes.forEach({participante => self.premiarParticipante(participante)})
	}
	
	override method perder(){
		participantes.forEach({participante => self.castigarParticipante(participante)})
	}
	
	
}