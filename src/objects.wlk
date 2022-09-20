object minionSinArmas inherits Exception{}
object sinMinionsAsignados inherits Exception{}

class Minion{
	var property bananas
	var property armas=[]
	var property color=  amarillo
	var maldades = 0
//	recordar sacar igual si no pongo valor de variable
	
	method comerBanana(){
		bananas-=1
		bananas.max(0)
//		recordar al usar metodos que reducen cantidades que no pueden ser negativas
	}
	
	method alimentar(numero){
		bananas+=numero
	}
	
	method agregarMaldad(){
		maldades+=1
	}
	
	method otorgarArma(arma){
		armas.add(arma)
		
	}
	
	method tieneArma(arma){
		return armas.contains(arma)
	}
	
	method esPeligroso()={
		return (armas.size()>2)
	}
	
	method consumirSueroMutante(){
		color.consumirSueroMutante(self)
		self.comerBanana()
	}
	
method poderArmaMasPoderosa(){
	if (armas.isEmpty())
		throw minionSinArmas
	return armas.max{a=>a.poder()}.poder()
//	puedo usar max para un bloque de codigo, y usarlo como objeto para un metodod
}
	
	method nivelDeConcentracion(){
		return color.nivelDeConcentracion(self)
	}
	
	method perderArmas(){
		armas.clear()
	}
		
}

object amarillo{
	method consumirSueroMutante(minion){
		minion.color(violeta)
		minion.perderArmas()
	}
	
	method nivelDeConcentracion(minion){
		return (minion.poderArmasMasPoderosa()+ minion.bananas())
	}
}

object violeta{
//	SIEMPRE PRELIGROSOS
	method consumirSueroMutante(minion){
		minion.color(amarillo)
	}
	
	method nivelDeConcentracion(minion)=minion.bananas()
}

class Villano{
	var property ciudad 
	var minions=[]
	
	method nuevoMinion(){		
		const minion = new Minion(bananas=5)
		const rayoCongelante= new Arma (nombre="Rayo Congelante",poder=10)
//		poner nombre de variable antes de valor al instanciar
		minions.otorgarArma(rayoCongelante)
		minions.add(minion)
//		llenando una lista de objetos instancias de la clase Minion
	} 
	
	method agregarMinion(nombre){
		minions.add(nombre)
	}
	
	method planificar(maldad){
		maldad.asignarMinions(minions.filter{a=>maldad.esApto(a)})
//		se asignan distinto segun la maldad, pero lo que cambia son las condiciones para que sean aptos
		
	}
// como hago un solo metodo planificar para congelar y robar, si para robar necesito un parametro mas
	method realizar(maldad){
		maldad.realizar(ciudad)
//	puedo pasar por parametro una variable del objeto
	}
	
	method minionMasUtil(){
		return minions.max{a=>a.maldades()}
	}
	
	method minionInutil(){
		return minions.filter{a=>a.maldades()==0}
	}
	
}

class Maldad{
	var property minionsAsignados=[]
	
	method asignarMinions(minions){
		minionsAsignados.addAll(minions)
		
	}
	
	method realizar(ciudad){
		if (minionsAsignados.empty()){
			throw sinMinionsAsignados}
		self.realizarEn(ciudad)
		minionsAsignados.forEach{minion=> self.realizarCon(minion) minion.agregarMaldad()}
		}
	method realizarEn(ciudad){}
	
	method realizarCon(minino){}
	
	}
	
class Congelar inherits Maldad{

	method esApto(minion){
		return (minion.tieneArma() && minion.nivelDeConcentracion()==500)
	}
	override
	method realizarEn(ciudad){
		ciudad.reducirTemperatura(30)
	}
	override	
	method realizarCon(minion){
		minion.alimentar(10)
	}
	
	
}
	
class Robo inherits Maldad{
	var property objetivo

	method esApto(minion){
		return (minion.esPeligroso() && objetivo.esApto(minion))
	}
	override
	method realizarEn(ciudad){
		ciudad.perderPosesion(objetivo)
	}
	override
	method realizarCon(minion){
		objetivo.realizarCon(minion)
	}
}

robo

class piramide{
	var altura
//	es clase porque pueden haber muchas que varian por la altura
	method esApto(minion){
		return (minion.nivelDeConcentracion()>=altura/2)
		
	}
	
	method realizarCon(minion){
		minion.alimentar(10)
	}
}

object sueroMutante{
	method esApto(minion){
		return minion.bananas()>=100
}
	
	method realizarCon(minion){
		minion.consumirSueroMutante()	
	}
}

object luna{
	method esApto(minion){
		return (minion.armas().contains("Rayo para encoger"))
	}
	
	method realizarCon(minion){
		minion.otorgarArma(new Arma(nombre="Rayo Congelante", poder=10))
	}
	
}
	
class Ciudad{
	var temperatura
	var posesiones=[]
	
	method perderPosesiones(objetivo){
		posesiones.remove(objetivo)
	}
	
	method reducirTemperatura(grados){
		temperatura-=grados
		
	}
	
}

class Arma{
	
	var property nombre
	var property poder
}

