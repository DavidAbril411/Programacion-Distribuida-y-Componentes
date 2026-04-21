const iform = document.getElementById('iform');

document.getElementById('iedad').addEventListener('input', (event) => {
   event.target.setCustomValidity("");
});

iform.addEventListener('submit', (event) => {
    event.preventDefault();
    const iform = document.getElementById('iform');
    const edad = document.getElementById('iedad');

    if (!edad.checkValidity()) {
        if (edad.validity.valueMissing) {
            edad.setCustomValidity("Por favor, ingresá tu edad");
        }
        else if (edad.validity.badInput) {
            edad.setCustomValidity("Debes informar un número");
        }
        else if (edad.validity.rangeOverflow) {
            edad.setCustomValidity("La edad máxima permitida es 99 años");
        }
    }
    else {
        edad.setCustomValidity("");
    }

    if (edad.reportValidity()) {
        iform.submit();
    }
});
