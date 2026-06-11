const STORAGE_KEY = 'shopping-list';

const form     = document.getElementById('add-form');
const input    = document.getElementById('item-input');
const list     = document.getElementById('shopping-list');
const emptyMsg = document.getElementById('empty-msg');

function load() {
  return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
}

function save(items) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(items));
}

function updateEmpty() {
  emptyMsg.hidden = list.children.length > 0;
}

function createListItem(text, id) {
  const li = document.createElement('li');
  li.className = 'list-group-item d-flex align-items-center gap-2';
  li.dataset.id = id;

  const span = document.createElement('span');
  span.className = 'flex-grow-1';
  span.textContent = text;

  const btn = document.createElement('button');
  btn.className = 'btn btn-sm btn-danger';
  btn.textContent = 'Eliminar';
  btn.setAttribute('aria-label', `Eliminar: ${text}`);
  btn.addEventListener('click', () => {
    const items = load().filter(item => item.id !== id);
    save(items);
    li.remove();
    updateEmpty();
  });

  li.append(span, btn);
  return li;
}

function render() {
  list.innerHTML = '';
  load().forEach(({ text, id }) => list.appendChild(createListItem(text, id)));
  updateEmpty();
}

form.addEventListener('submit', (e) => {
  e.preventDefault();
  const text = input.value.trim();
  if (!text) return;

  const items = load();
  const newItem = { id: Date.now(), text };
  items.push(newItem);
  save(items);

  list.appendChild(createListItem(text, newItem.id));
  input.value = '';
  input.focus();
  updateEmpty();
});

render();
input.focus();
