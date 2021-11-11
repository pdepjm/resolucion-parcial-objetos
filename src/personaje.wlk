class Personaje{
	var copas = 0
	
	method ganarCopas(nuevasCopas){
		copas+=nuevasCopas
	}
	
	method perderCopas(copasAPerder){
		copas-=copasAPerder
	}
	
	method copas() = copas
}

class Arquero inherits Personaje{
	const agilidad
	const rango
	
	method destreza() = agilidad*rango
	
	method tieneEstrategia() = rango > 100
}

class Guerrera inherits Personaje{
	const tieneEstrategia
	const fuerza
	
	method destreza() = fuerza * 1.5
	method tieneEstrategia() = tieneEstrategia
}

class Ballestero inherits Arquero{
	override method destreza() = super() * 2
}