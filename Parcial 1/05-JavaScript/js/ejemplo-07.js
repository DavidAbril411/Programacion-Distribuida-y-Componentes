// Copia superficial de un Array
let arrayOriginal = [1, 2, 3, 4];
let copiaSuperficialArray = arrayOriginal.slice(); // Usando slice para crear una copia superficial
//let copiaSuperficialArray = [...arrayOriginal]; // Usando operador de propagación

// Modificando la copia no afecta el original
copiaSuperficialArray.push(5);
console.log("Array original:", arrayOriginal); // [1, 2, 3, 4]
console.log("Copia superficial de array:", copiaSuperficialArray); // [1, 2, 3, 4, 5]

// Copia superficial de un Objeto
let objetoOriginal = { a: 1, b: 2 };
let copiaSuperficialObjeto = Object.assign({}, objetoOriginal); // Usando Object.assign para copia superficial

// Modificando la copia no afecta el original
copiaSuperficialObjeto.b = 3;
console.log("Objeto original:", objetoOriginal); // { a: 1, b: 2 }
console.log("Copia superficial de objeto:", copiaSuperficialObjeto); // { a: 1, b: 3 }

// Copia profunda usando JSON
let objetoComplejo = { a: 1, b: { c: 2, d: 3 } };
let copiaProfundaObjeto = JSON.parse(JSON.stringify(objetoComplejo));

// Modificando la copia no afecta el original
copiaProfundaObjeto.b.c = 4;
console.log("Objeto complejo original:", objetoComplejo); // { a: 1, b: { c: 2, d: 3 } }
console.log("Copia profunda de objeto complejo:", copiaProfundaObjeto); // { a: 1, b: { c: 4, d: 3 } }

// Nota: JSON.parse(JSON.stringify()) no puede copiar funciones, fechas, undefined, RegExp, etc.


