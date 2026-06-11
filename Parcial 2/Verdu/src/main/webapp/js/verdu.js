// Listener para cambios de estado en los Checkbox (evento 'change')
document.getElementById('contenedorPedidos').addEventListener('change', async function (event) {
    const target = event.target;
    
    // Verificar si el evento cambio provino de un checkbox de listo para entrega
    if (target.tagName.toLowerCase() === 'input' && target.type === 'checkbox' && target.id.startsWith('check-')) {
        const id = target.id.replace('check-', '');
        const checked = target.checked;
        const card = target.closest('.card');
        
        // Si el botón "Ver más" no existe en la tarjeta, significa que está expandido
        const isExpanded = card && !card.querySelector('.btn-ver-mas');
        
        try {
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.classList.add('d-none');
            }
            
            const response = await fetch("check.jsp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: `id=${id}&checked=${checked}&expand=${isExpanded}`
            });

            if (!response.ok) {
                const text = await response.text();
                throw new Error(text || response.statusText);
            }
            
            // Reemplazar la tarjeta anterior por el fragmento HTML actualizado
            const html = await response.text();
            if (card) {
                card.insertAdjacentHTML('beforebegin', html);
                card.remove();
            }
        } catch (e) {
            // Revertir el estado del checkbox si falla la actualización
            target.checked = !checked;
            
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.textContent = "Error al actualizar el estado de entrega: " + e.message;
                errorDiv.classList.remove('d-none');
            }
        }
    }
});

// Listener para los clicks en los botones de "Quitar" y "Ver más" (evento 'click')
document.getElementById('contenedorPedidos').addEventListener('click', async function (event) {
    const target = event.target;
    
    // 1. Caso: Botón de "Quitar" producto
    if (target.classList.contains('btn-quitar')) {
        const pedidoId = target.getAttribute('data-pedido-id');
        const productoId = target.getAttribute('data-producto-id');
        const card = target.closest('.card');
        const isExpanded = card && !card.querySelector('.btn-ver-mas');
        
        try {
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.classList.add('d-none');
            }
            
            const response = await fetch("quitar.jsp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: `pedidoId=${pedidoId}&productoId=${productoId}&expand=${isExpanded}`
            });

            if (!response.ok) {
                const text = await response.text();
                throw new Error(text || response.statusText);
            }
            
            // Reemplazar la tarjeta con el producto tachado
            const html = await response.text();
            if (card) {
                card.insertAdjacentHTML('beforebegin', html);
                card.remove();
            }
        } catch (e) {
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.textContent = "Error al quitar el producto: " + e.message;
                errorDiv.classList.remove('d-none');
            }
        }
    }
    
    // 2. Caso: Botón "Ver más productos" (Expandir listado)
    if (target.classList.contains('btn-ver-mas')) {
        const id = target.getAttribute('data-id');
        const card = target.closest('.card');
        
        try {
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.classList.add('d-none');
            }
            
            const response = await fetch(`expandir.jsp?id=${id}`);
            
            if (!response.ok) {
                const text = await response.text();
                throw new Error(text || response.statusText);
            }
            
            // Reemplazar la tarjeta con el listado completo de productos
            const html = await response.text();
            if (card) {
                card.insertAdjacentHTML('beforebegin', html);
                card.remove();
            }
        } catch (e) {
            const errorDiv = document.getElementById('iError');
            if (errorDiv) {
                errorDiv.textContent = "Error al expandir el pedido: " + e.message;
                errorDiv.classList.remove('d-none');
            }
        }
    }
});