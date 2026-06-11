// Ejemplo de hoisting con var
// La variable no existe pero no da error al tratar de usarla solo retorna UNDEFINED
console.log(miVar);  // undefined 
var miVar = "Hola";
console.log(miVar);  // Hola

// Ejemplo de error por hoisting con let y const
// Estoy tratando de usarlas antes de definirlas ERROR! 
try {
  console.log(miLet);  // ReferenceError: Cannot access 'miLet' before initialization
}
catch(e) {
  console.log("Sin declarar:", e);
}

try {
  console.log(miConst);  // ReferenceError: Cannot access 'miConst' before initialization
}
catch(e) {
  console.log("Sin declarar:", e);
}

let miLet = "Mundo";
const miConst = "!";
console.log(miLet);  // Mundo
console.log(miConst);  // !

// Función para demostrar el alcance de las variables
function demoScope() {
  var varDentroFuncion = "Soy var dentro de una función";
  if (true) {
    var varDentroIf = "Soy var dentro de un if";
    let letDentroIf = "Soy let dentro de un if";
    const constDentroIf = "Soy const dentro de un if";
    console.log(varDentroIf);  // Soy var dentro de un if
    console.log(letDentroIf);  // Soy let dentro de un if
    console.log(constDentroIf);  // Soy const dentro de un if
  }
  console.log(varDentroFuncion);  // Soy var dentro de una función
  console.log(varDentroIf);  // Soy var dentro de un if
  // Estas variables solo existen dentro del bloque en que fueron definidas por eso dan ERROR
  try {
    console.log(letDentroIf);  // Error: letDentroIf is not defined
  }
  catch(e) {
    console.log("Fuera de bloque:", e);
  }
  
  try {
    console.log(constDentroIf);  // Error: constDentroIf is not defined
  }
  catch(e) {
    console.log("Fuera de bloque:", e);
  }
}

demoScope();

// Intentando acceder a variables de la función desde fuera
// En este caso las variables definidas con var no son globales sino de bloque
try {
  console.log(varDentroFuncion);  // Error: varDentroFuncion is not defined
}
catch(e) {
  console.log("Fuera de función", e);
}

try {
  console.log(varDentroIf);  // Error: varDentroIf is not defined
}
catch(e) {
  console.log("Fuera de función:", e);
}

// Declaración de función con hoisting
console.log(declarada());  // Funciona: "Función declarada"

function declarada() {
  return "Función declarada";
}

// Expresión de función sin hoisting
try {
  console.log(expresada());  // Error: expresada is not a function
} 
catch (e) {
  console.log("Función var sin declarar:", e);
}

var expresada = function () {
  return "Función expresada";
};

console.log(expresada());  // Funciona: "Función expresada"

// Expresión de función con let y const (TDZ: Temporal Dead Zone)
try {
  console.log(expresadaLet());  // Error: Cannot access 'expresadaLet' before initialization
} 
catch (e) {
  console.log("Función let sin declarar:", e);
}

let expresadaLet = function () {
  return "Función expresada con let";
};

console.log(expresadaLet());  // Funciona: "Función expresada con let"

try {
  console.log(expresadaConst());  // Error: Cannot access 'expresadaConst' before initialization
} 
catch (e) {
  console.log("Función const sin declarar:", e);
}

const expresadaConst = function () {
  return "Función expresada con const";
};

console.log(expresadaConst());  // Funciona: "Función expresada con const"
