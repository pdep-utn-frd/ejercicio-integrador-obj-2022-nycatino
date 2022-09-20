
class Villano{
	var ciudad = new Ciudad(temperatura=0)
	var property minions=[]
	
	method nuevoMinion(){
		const minion= new Minion(5)
		const rayoCongelante= new Arma("Rayo Congelante",10)
		minions.add(minion)
	} 
	
	method agregarMinion(nombre){
		minions.add(nombre)

	}
	
	method planificar(maldad, objetivo){
		maldad.asignarMinions(self)
		
	}
// como hago un solo metodo planificar para congelar y robar, si para robar necesito un parametro mas
	method realizar(maldad){
		if (maldad.minionsAsignados().isEmpty()){
			throw new Exception (message= "La maldad no tiene ningun minion asignado")
		}
		maldad.realizar(self)
	}
	
}

class Robo{
	var property minionsAsignados=[]
	method asignarMinions(villano, objetivo){
		minionsAsignados= villano.Minions().filter({minion=> minion.estado() =="Peligroso"})
		minionsAsignados= objetivo.asignarMinions(self)
	}
	method realizar(villano, objetivo){
		objetivo.realizar(self, villano)
		villano.Ciudad().posesiones().remove(objetivo)
	}
	
}

object piarmide{
	var altura
	method asignarMinions(robo){
		return robo.minionsAsignados().filter({minion=>minion.nivelDeConcentracion()>=altura/2})
	}
	
	method realizar(robo, villano){
		robo.minionsAsignados().forEach({minion=> minion.bananas(minion.bananas()+10)})
	}
}

object sueroMutante{
	method asignarMinions(robo){
		return robo.minionsAsignados().filter({minion=>minion.bananas()>=100 and minion.nivelDeConcentracion()>23})
	}
	
	method realizar(robo, villano){
		robo.minionsAsignados().forEach({minion=> minion.consumirSueroMutante()})
		
	}
}

object luna{
	method asignarMinions(robo){
		return robo.minionsAsignados().filter{minion=> minion.armas().nombre()=="rayoEncogedor"}
	}
	
	method realizar(robo, villano){
		robo.minionsAsignados().forEach({minion=> minion.otorgarArma("rayoCongelante", 10)})
	}
}

class Congelar{
	var minionsAsignados=[]
	method asignarMinions(villano){
//		rayo congelante, nivel de concentracion 50.
		minionsAsignados= villano.Minions().filter({minion=>self.rayo(minion) and self.concentracion(minion)})
	}
	
	method rayo(minion){
		return minion.armas().nombre()=="rayoCongelante"
	}
	
	method concentracion(minion){
		return minion.nivelDeConcentracion()==50	
	}
	
	method realizar(villano){
		villano.Ciudad().temperatura(villano.Ciudad().temperatura()-30)
		minionsAsignados.forEach({minion=> minion.bananas(minion.bananas()+10)})
	}
	
}

//class Minion{
//	var property bananas=
//	var property armas=[]
////	se puede instanciar dentro de una lista?
//	var property color=  Amarillo
//	var property estado = "Normal"
//	var property nivelDeConcentracion=15
//	
//	method nivelDeConcentracion(){
//		return color.nivelDeConcentracion(self)
//	}
//	
//	method consumirSueroMutante(){
//		color.consumirSueroMutante(self)
//	}
//	
//	method otorgarArma(arma, potencia){
//		armas.add(new Arma(nombre=arma, poder=potencia))
////		como agrego una nueva instancia arma a la lista
//		
//	}
//	
//	method tieneArma(arma){
//		return armas.contains(arma)
//	}
//	
//	method alimentar(numero){
//		bananas+=numero
//	}
//	
//	method comerBanana(){
//		bananas-+1
//	}
//	
//	method esPeligroso()={
//		if (armas.size()>=2){
//			estado = "Peligroso"
//		}
//		else
//		estado ="Normal"
//		return estado =="Peligroso"
//	}
//		
//}


object Violeta{
	
	method consumirSueroMutante(minion){
		minion.color(Amarillo)
		minion.bananas(minion.bananas()-1)
	}
	
	method nivelDeConcentracion(minion)= minion.bananas()
	
}

object Amarillo{
	var potencia=0
	
	method consumirSueroMutante(minion){
		minion.color(Violeta)
		minion.armas().clear()
		minion.bananas(minion.bananas()-1)
		minion.estado("Peligroso") 
			
	}
	
	method nivelDeConcentracion(minion){ 
		minion.armas().forEach({arma=> if (arma.poder()>potencia) {potencia=arma.poder()}})
		return (potencia+ minion.bananas())
	}
}



class Arma{
	var property nombre
	var property poder
	
}

class Ciudad{
	var property temperatura
	var posesiones=["piramide", "sueroMutante", "luna"]
}