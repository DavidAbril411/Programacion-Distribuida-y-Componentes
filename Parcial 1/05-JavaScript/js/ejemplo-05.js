 // Comparaciones con '=='
 console.log("Comparaciones con '==':");
 console.log("0 == false:", 0 == false);  // true, porque ambos se convierten a false
 console.log("'1' == 1:", '1' == 1);  // true, porque '1' se convierte a número
 console.log("'0' == false:", '0' == false);  // true, porque ambos se convierten a false
 console.log("'' == 0:", '' == 0);  // true, porque ambos se convierten a false
 console.log("'' == false:", '' == false);  // true, porque ambos se convierten a false

 // Comparaciones con '==='
 console.log("Comparaciones con '===':");
 console.log("0 === false:", 0 === false);  // false, tipos diferentes
 console.log("'1' === 1:", '1' === 1);  // false, tipos diferentes
 console.log("'0' === false:", '0' === false);  // false, tipos diferentes
 console.log("'' === 0:", '' === 0);  // false, tipos diferentes
 console.log("'' === false:", '' === false);  // false, tipos diferentes

 // Ejemplo con valores no primitivos
 const objetoA = { clave: 'valor' };
 const objetoB = { clave: 'valor' };
 const objetoC = objetoA;

 console.log("objetoA === objetoB:", objetoA === objetoB);  // false, referencia diferente
 console.log("objetoA === objetoC:", objetoA === objetoC);  // true, misma referencia

 // Comparación con null y undefined
 console.log("null == undefined:", null == undefined);  // true
 console.log("null === undefined:", null === undefined);  // false
 