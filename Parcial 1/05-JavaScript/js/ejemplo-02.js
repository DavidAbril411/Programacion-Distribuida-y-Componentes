// Tipos primitivos
let nombre = "Ámbar"; // String
let edad = 10; // Number
let esMayorDeEdad = true; // Boolean
let variableSinDefinir; // Undefined
let valorNulo = null; // Null
let idUnico = Symbol('id'); // Symbol
let numeroGrande = BigInt(9007199254740991); // BigInt

console.log(nombre, edad, esMayorDeEdad, variableSinDefinir, valorNulo, idUnico, numeroGrande);

// Tipos de objeto
let persona = { nombre: "Ámbar", edad: 10 }; // Object
let frutas = ["manzana", "banana", "cereza"]; // Array
let muestraMensaje = function(mensaje) { 
    console.log("Mensaje de función:", mensaje); 
}; // Function
let hoy = new Date(); // Date
let patron = /ab+c/; // RegExp

console.log(persona, frutas, muestraMensaje, hoy, patron);

// Funciones para demostrar uso
muestraMensaje();
muestraMensaje("¡Hola Mundo!");

// Añadir elementos al array
frutas.push("mango");
console.log("Valores del array:", frutas);

// Acceder a propiedades del objeto
console.log("Nombre de la persona:", persona.nombre);

// Uso de Date
console.log("Fecha del día:", hoy.toDateString());

// Uso de RegExp
console.log("Validación del patrón:", patron.test("abc")); // true
