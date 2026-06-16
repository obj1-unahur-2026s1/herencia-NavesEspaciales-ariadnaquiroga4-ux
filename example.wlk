class Nave {
  var velocidad
  var direccion
  var combustible
  var miPiloto = UnPiloto
  method acelerar(cuanto) {
    velocidad = velocidad + cuanto.min(100000)
  }
  method desacelerar(cuanto) {
    velocidad = velocidad - cuanto.max(0)
  }
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  method irHaciaElSol() {
    direccion = 10
  }
  method escaparDelSol() {
    direccion = -10
  }
  method acercarceUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }
  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }
  method prepararViaje(cantAcelera) {
    self.acelerar(cantAcelera)
  }
  method cargarCombustible(nro) {
    combustible += nro
  }
  method descargarCombustible(nro) {
    combustible -= nro
  }
  method estaTranquila() = combustible >= 4000 && velocidad < 12000 && self.adicionalTranquila()
  method adicionalTranquila() {}
  method escapar() {}
  method avisar() {} 
  method recibirAmenaza() = self.escapar() && self.avisar()
  method estaRelajo() = self.estaTranquila() && self.tienePocaActividad()
  method tienePocaActividad() {}
}
object unPiloto {
  var property experiencia = 10 
}

class NaveBaliza inherits Nave {
  var colorBaliza = "azul"
  var colorBalizaActual
  method cambiarColorBaliza(color) {
    colorBalizaActual = color
  }
  override method prepararViaje(cantAcelera) {
    colorBalizaActual = "verde"
    self.ponerseParaleloAlSol()
    self.acelerar(cantAcelera)
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  override method adicionalTranquila() {
    colorBalizaActual != "rojo" || colorBaliza != "rojo"
  }
  //override method recibirAmenaza() {}
  override method escapar() {
    self.acercarceUnPocoAlSol()
  }
  override method avisar() {
    colorBalizaActual = "rojo"
  }
  //override method estaRelajo() {}
  override method tienePocaActividad() =colorBalizaActual == colorBaliza
}
class NavesPasajeros inherits Nave {
  var cantPasajeros
  var comidaCargada = 0
  var bebidaCargada = 0
  var cantComidaServida
  method cargarCantComida(cant) {
    comidaCargada = comidaCargada + cant
  }
  method cargarCantBebida(cant) {
    bebidaCargada = bebidaCargada + cant
  }
  override method prepararViaje(cantAcelera) {
    self.cargarCantComida(4)
    self.cargarCantBebida(6)
    self.acercarceUnPocoAlSol()
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method cantidadComidaServida() = cantComidaServida //ESTA MAL
  //override method estaTranquila() {}
  override method recibirAmenaza() {}
  override method escapar() = velocidad * 2
  override method avisar() {
    comidaCargada = comidaCargada - 1
    bebidaCargada = bebidaCargada - 2
  }
  // override method estaRelajo() {}
  override method tienePocaActividad() = cantComidaServida < 50
}
class NaveCombate inherits Nave {
  const mensajes = []
  method ponerseVisible() = !self.estaInvisible()
  method ponerseInvisible() = self.estaInvisible()
  method estaInvisible() = true
  method desplegarMisiles() = self.misilesDesplegados()
  method replegarMisiles() = !self.misilesDesplegados()
  method misilesDesplegados() = true
  method emitirMensaje(men) = men
  method mensajesEmitidos() = mensajes.size()
  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method esEscueta() = self.emitioMensaje(men).size() < 30
  method emitioMensaje(men) = mensajes.add(men)
  override method prepararViaje(cantAcelera) {
    self.ponerseVisible()
    self.cargarCombustible(30000)
    self.acelerar(500)
    self.acelerar(15000)
  }
  override method adicionalTranquila() {
    !self.misilesDesplegados()
  }
  //override method recibirAmenaza() {}
  override method escapar() {
    self.acercarceUnPocoAlSol()
    self.acercarceUnPocoAlSol()
  }
  override method avisar() {
    self.emitirMensaje("mensaje recibido")
  }
}
class NaveHospital inherits NavesPasajeros {
  var quirofanosPreparedos = true
  override method adicionalTranquila() {
   quirofanosPreparedos = false 
  }
  override method recibirAmenaza() {
    self.escapar() 
    self.avisar()
    quirofanosPreparedos = true
  }
}
class NaveCombateSigilosa inherits NaveCombate {
  override method adicionalTranquila(){ 
    !self.misilesDesplegados()
    !self.estaInvisible()
  }
  override method escapar() {
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
//  super(cantAcelera)
//inherits hereda todo lo de la clase padre, pero no se puede modificar nada de la clase padre, solo agregar cosas nuevas
//override se usa cuando queremos modificar un método de la clase padre, pero no se puede modificar el método de la clase padre, solo agregar cosas nuevas
//super se usa para llamar al método de la clase padre, pero no se puede modificar el método de la clase padre, solo agregar cosas nuevas