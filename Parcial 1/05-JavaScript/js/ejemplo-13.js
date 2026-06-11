document.addEventListener('DOMContentLoaded', () => {
	// Obtenciones por ID
	const addCommentButton = document.querySelector('#addCommentButton'); 
	const changeColorButton = document.querySelector('#changeColorButton');
	const commentsContainer = document.getElementById('commentsContainer');
    
	let commentId = 0; // Contador para asignar un ID único a cada comentario

	addCommentButton.addEventListener('click', () => {
			const newCommentId = `comment-${commentId++}`;
			
			const column = document.createElement('div');
			column.classList.add('col-6', 'col-md-4'); // Ajusta para dispositivos pequeños a 2 por fila, medianos y grandes a 3 por fila

			const commentCard = document.createElement('div');
			commentCard.classList.add('card', 'p-3');
			commentCard.setAttribute('id', newCommentId);
			commentCard.innerHTML = `
					<p>Este es el comentario número ${commentId}.</p>
					<button onclick="removeComment('${newCommentId}')" class="btn btn-danger">Eliminar</button>
			`;
			
			column.appendChild(commentCard);
			commentsContainer.appendChild(column);
	});

	changeColorButton.addEventListener('click', () => {
		const cards = document.querySelectorAll('#commentsContainer .card');
		cards.forEach(card => {
				card.style.backgroundColor = '#e9ecef'; // Cambiar el color de fondo a gris claro
		});
	});

	// Función global
	window.removeComment = (commentId) => {
			const commentToRemove = document.getElementById(commentId).parentNode;
			commentsContainer.removeChild(commentToRemove);
	};
});
