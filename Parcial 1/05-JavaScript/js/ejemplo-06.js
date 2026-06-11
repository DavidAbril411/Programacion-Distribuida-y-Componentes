class Persona {

  constructor(nombre) {
    this.nombre = nombre;
  }

  saludar() {
    console.log(`Hola, mi nombre es ${this.nombre}`);
  }

}

class Empleado extends Persona {
  
  constructor(nombre, puesto) {
    super(nombre); // Llama al constructor de Persona
    this.puesto = puesto;
  }

  saludar() {
    super.saludar(); // Llama al método saludar de Persona
    console.log(`Mi puesto es ${this.puesto}`);
  }

}

const empleado = new Empleado("Miguel", "Desarrollador");
empleado.saludar(); // Hola, mi nombre es Miguel
                    // Mi puesto es Desarrollador

