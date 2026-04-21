document.getElementById('padre').addEventListener('click', () => {
  console.log('Padre en captura');
}, true); // captura

document.getElementById('hijo').addEventListener('click', () => {
  console.log('Hijo en burbuja');
}); // burbuja (por defecto)

document.getElementById('nieto').addEventListener('click', () => {
  console.log('Nieto clickeado');
}); // burbuja (por defecto)