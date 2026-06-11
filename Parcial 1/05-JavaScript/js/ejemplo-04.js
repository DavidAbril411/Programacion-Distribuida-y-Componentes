function calcularCosto(event) {
	event.preventDefault();

	// Obtener valores de entrada
	let precio = parseFloat(document.getElementById('precio').value);
	let cantidad = parseInt(document.getElementById('cantidad').value);
	let impuesto = parseFloat(document.getElementById('impuesto').value);
	let descuento = parseFloat(document.getElementById('descuento').value);

	// Asegurar que el descuento sea un número válido y mayor que cero
	descuento = isNaN(descuento) || descuento < 0 ? 0 : descuento;

	// Calcular el subtotal
	let subtotal = precio * cantidad;

	// Calcular descuento sólo si es aplicable
	let totalDescuento = (descuento / 100) * subtotal;

	// Recalculo subtotal con el descuento
	subtotal -= totalDescuento;

	// Calcular impuesto sobre el monto después de aplicar el descuento
	let totalImpuesto = (subtotal * impuesto) / 100;

	// Calcular total sumando el subtotal, restando el descuento y sumando el impuesto
	let total = subtotal + totalImpuesto;

	// Mostrar resultado
	document.getElementById('resultado').innerText = `El costo total del pedido con IVA (21%) es: $ ${total.toFixed(2)}`;
}
