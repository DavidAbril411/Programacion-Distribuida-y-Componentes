document.addEventListener('DOMContentLoaded', (event) =>  {
	const formulario = document.getElementById('iform');

	const email = document.getElementById('iemail');
	const clave = document.getElementById('iclave');
	const confirmarClave = document.getElementById('iconfirmar_clave');
	const equipo = document.getElementById('iequipo');
	const hobbies = document.getElementsByName('hobbies');

	// Limpiar mensajes personalizados al modificar los campos
	email.addEventListener('input', (event) => {
		event.target.setCustomValidity('');
	});

	clave.addEventListener('input', (event) =>   {
		confirmarClave.setCustomValidity('');
	});

	confirmarClave.addEventListener('input', (event) =>   {
		event.target.setCustomValidity('');
	});

	equipo.addEventListener('change', (event) =>   {
		event.target.setCustomValidity('');
	});

	hobbies.forEach(h => h.addEventListener('change', (event) =>   {
		hobbies[0].setCustomValidity('');
	}));

	formulario.addEventListener('submit', (event) => {
		event.preventDefault();
		let formValido = true;

		const regex = new RegExp("^[a-zA-Z0-9._%+\\-]+@(?:[a-zA-Z0-9\\-]+\\.)+[a-zA-Z]{2,}$");
		if (!regex.test(email.value)) {
			email.setCustomValidity('Ingrese un correo válido con al menos dos partes en el dominio. Ej: usuario@dominio.com');
			email.reportValidity();
			formValido = false;
		}

		// Validar que ambas claves coincidan
		if (clave.value !== confirmarClave.value) {
			confirmarClave.setCustomValidity('Las claves no coinciden');
			confirmarClave.reportValidity();
			formValido = false;
		}

		// Validar que se hayan seleccionado hasta dos equipos
		const equiposSeleccionados = equipo.querySelectorAll("option:checked");
		if (equiposSeleccionados.length > 2) {
			equipo.setCustomValidity("Debe informar hasta dos equipos");
			equipo.reportValidity();
			formValido = false;
		}

		// Validar que se haya seleccionado al menos un hobby
		const hobbiesSeleccionados = formulario.querySelectorAll("input[name='hobbies']:checked");
		if (hobbiesSeleccionados.length == 0) {
			// Se asigna el error al primer checkbox para que se muestre el mensaje
			hobbies[0].setCustomValidity("Debe informar al menos un hobby");
			hobbies[0].reportValidity();
			formValido = false;
		}

		// Si todo es válido, se limpian los mensajes y se envía el formulario
		if (formValido) {
			email.setCustomValidity('');
			clave.setCustomValidity('');
			confirmarClave.setCustomValidity('');
			equipo.setCustomValidity('');
			hobbies[0].setCustomValidity('');

			formulario.submit();
		}
	});

	// Mostrar/Ocultar el campo "Otra Nacionalidad" según corresponda
	document.getElementById("inacionalidad").addEventListener("change", (event) => {
		const otraNacionalidad = document.getElementById("iotranac");
		if(event.target.value == "-1") {
			otraNacionalidad.parentNode.classList.remove("d-none");
			otraNacionalidad.disabled = false;
			otraNacionalidad.focus();
		}
		else {
			otraNacionalidad.parentNode.classList.add("d-none");
			otraNacionalidad.disabled = true;
			otraNacionalidad.value = "";
		}
	});
});