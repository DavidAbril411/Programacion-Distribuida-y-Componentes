# Guía de patrones comunes — Proyectos JSP / Servlets / AJAX (UBP)

Todos tus proyectos siguen la misma arquitectura: **MVC con AJAX**. El navegador nunca recarga la página completa; JavaScript intercepta los eventos, hace `fetch` a un servlet (o JSP-controlador), el servidor devuelve un **fragmento de HTML** ya renderizado, y JS lo inserta en el DOM.

```
[index.jsp + Bootstrap]
        │ evento (submit/click/change)
        ▼
[nombreProyecto.js]  ──fetch POST/GET──►  [Servlet @WebServlet]
        ▲                                      │ JDBC (DBConnection)
        │                                      ▼
        │                                 [Bean(s)] → req.setAttribute()
        │                                      │
        └── fragmento HTML ◄── forward ── [fragmento.jsp (JSTL/EL)]
```

---

## 1. Estructura de carpetas del proyecto (siempre igual)

```
proyecto/
├── pom.xml
└── src/main/
    ├── java/ar/edu/ubp/<proyecto>/
    │   ├── beans/        → XxxBean.java (modelo)
    │   ├── db/           → DBConnection.java (copiar y pegar)
    │   └── servlets/     → XxxServlet.java (controladores)
    └── webapp/
        ├── index.jsp     → (o en WEB-INF/jsp/ si hay InicioServlet)
        ├── error-modal.jsp
        ├── <fragmentos>.jsp
        ├── js/
        │   ├── utils.js  → (copiar y pegar)
        │   └── <proyecto>.js
        └── WEB-INF/web.xml
```

**Archivos que se copian tal cual entre proyectos:** `utils.js`, `DBConnection.java` (solo cambia el `package`), `error-modal.jsp`, `web.xml`, `pom.xml` (solo cambia `artifactId`/`name`).

**Archivos que programás por proyecto:** `index.jsp`, `<proyecto>.js`, los servlets, los beans y los JSP de fragmentos.

---

## 2. index.jsp

### 2.1 El `<head>` estándar (siempre igual)

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nombre del proyecto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"
            defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/[nombreProyecto].js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" defer>
</head>
```

Para qué sirve cada línea:
1. **Directiva `page`**: fija UTF-8 para que anden tildes y eñes tanto en el HTML como en los parámetros.
2. **Link bootstrap.min.css**: estilos de Bootstrap (clases `container`, `row`, `btn`, `card`, `table`, `d-none`, etc.).
3. **Script bootstrap.bundle.min.js**: componentes con JS de Bootstrap (modales, dropdowns, tooltips). `defer` = se ejecuta después de parsear el HTML, sin bloquear.
4. **utils.js SIEMPRE antes que el JS del proyecto**: tu JS usa `jUtils`, así que utils debe cargarse primero (el orden de los `defer` se respeta).
5. **bootstrap-icons**: para los `<i class="bi bi-trash">`, `bi-star`, etc. Solo lo incluís si usás íconos.

**Variante con WebJars** (aerolínea, JSTL-Core): si el `pom.xml` incluye la dependencia `org.webjars:bootstrap`, en vez del CDN usás:
```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
```
Cualquiera de las dos sirve; el CDN es lo que usás en la mayoría.

### 2.2 Formularios: `action="javascript:void(0)"`

```html
<form id="iBuscForm" action="javascript:void(0)">
```

**Cuándo lo ponés:** siempre que el submit lo va a manejar JavaScript con `fetch` (AJAX), es decir, en el 95% de tus casos. `javascript:void(0)` hace que si por algún motivo el navegador ejecuta el action nativo (por ejemplo, tu JS falló al cargar), no navegue a ningún lado ni recargue la página. Es una red de seguridad además del `event.preventDefault()` del JS.

**Cuándo NO lo ponés:** si el form hace un POST tradicional con recarga de página (como en los ejemplos de JSTL-Core: `action="ejemplo-02.jsp" method="post"`). Ahí el server procesa y devuelve la página entera.

### 2.3 Convención de IDs

Todos los elementos que JS va a tocar llevan id con prefijo `i` + descripción de lo que hacen:
- Forms: `iForm`, `iBuscForm`, `iAgrProdForm`, `iGuardarForm`, `iReservaForm`
- Contenedores de resultado/error: `iError`, `iResult`, `iTabla`, `iNew`
- Los `name` de los inputs coinciden con lo que el servlet lee con `req.getParameter("...")` → `name="cod_barra"`, `name="documento"`, etc. **Este mapping es clave**: el `name` del input es el nombre del parámetro en el servidor.

### 2.4 Contenedores vacíos y ocultos

Siempre incluís un div de error (y a veces uno de resultado) oculto con `d-none`, que jUtils muestra cuando hace falta:

```html
<div id="iError" class="d-none"></div>
<div id="iResult" class="d-none"></div>
```

### 2.5 Modal de error de Bootstrap (opcional, patrón de tickets/puntuaNet/caja)

Un `<div class="modal fade" id="errorModal">` con header rojo (`bg-danger`) que se dispara desde JS con `new bootstrap.Modal(...)`. Es la alternativa "linda" a mostrar el error en `iError`.

### 2.6 index.jsp en `/webapp` vs `/WEB-INF/jsp/`

- **En `/webapp/index.jsp`**: accesible directo, para páginas estáticas o que no necesitan datos precargados (tickets, puntuaNet, ejercicio-4).
- **En `/WEB-INF/jsp/index.jsp`**: NO accesible directo por URL; obliga a pasar por un `InicioServlet` que carga datos (catálogo, carrito de sesión) y hace forward. Se usa cuando la página necesita datos del servidor al cargar (cajaRegistradora, reclamo). El servlet se mapea así:

```java
@WebServlet(urlPatterns = {"/inicio", "/index.jsp"})
public class InicioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ...cargar datos, req.setAttribute(...)
        req.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
```
El truco de mapear también `/index.jsp` hace que aunque escriban esa URL, igual pase por el servlet.

---

## 3. [nombreProyecto].js — El controlador del cliente

### 3.1 Dos estilos de organización (los dos aparecen en tus proyectos)

**Estilo objeto-namespace** (aerolineas.js, carrito.js, cajaRegistradora.js):
```js
const jNombreProyecto = {
    accion1: async (event) => { ... },
    accion2: async (event) => { ... },
};
document.getElementById("iForm").addEventListener("submit", jNombreProyecto.accion1);
```

**Estilo funciones sueltas / listener inline** (tickets.js, puntuaNet.js, corchito.js, art.js):
```js
const form = document.getElementById("iForm");
if (form) {
    form.addEventListener("submit", buscar);
}
async function buscar(event) { ... }
```
El `if (form)` protege por si el elemento no existe en esa página.

### 3.2 Cómo se toman los eventos (los 3 patrones)

**a) Submit de formulario** (el más común):
```js
document.getElementById("iForm").addEventListener("submit", handler);
```

**b) Llamada directa a una función del JS desde el HTML del JSP** (`onclick`/`onchange` inline)

La idea general: el evento no se registra en el JS con `addEventListener`, sino que **el propio HTML lleva escrita la llamada a la función**, y el JSP (al generar ese HTML en el servidor) le incrusta el dato que la función necesita como argumento.

La división de responsabilidades es siempre esta:

**EN EL JSP** — ponés el atributo de evento con la llamada, pasando el dato dinámico como argumento:
```jsp
<%-- Forma general: --%>
<elemento onEVENTO="jNombreProyecto.funcion( DATO_DEL_SERVIDOR )">

<%-- Ejemplos reales: --%>
<button onclick="jCajaRegistradora.eliminar(${producto.nroDetalle})">   <%-- con EL --%>
<button onclick="jCajaRegistradora.eliminar(<%= p.getNro_producto() %>)"> <%-- con scriptlet --%>
<select onchange="jCajaRegistradora.agregarPorSeleccion(this.value)">   <%-- con valor del propio elemento --%>
```
Detalles de la parte JSP:
- `${producto.nroDetalle}` o `<%= ... %>` se evalúan **en el servidor** antes de mandar el HTML. El navegador recibe literalmente `onclick="jCajaRegistradora.eliminar(42)"`. O sea, cada fila/botón nace ya con su id "cableado".
- Si el dato es un String, van comillas: `onclick="jX.ver('${bean.codigo}')"`.
- `this` dentro del atributo es el propio elemento → `this.value` (select/input), `this.checked` (checkbox), `this.closest('tr')` si necesitás el contenedor.
- Este mismo patrón sirve tanto en el `index.jsp` como en los **JSP de fragmentos**: la fila que devuelve `producto.jsp` ya viene con su `onclick` puesto, por eso funciona apenas se inserta con `insertAdjacentHTML` sin registrar nada (esa es la gran ventaja frente al patrón a).

**EN EL JS** — definís la función como propiedad del objeto-namespace, recibiendo el dato como parámetro (NO recibe `event`, y por eso no hay `preventDefault`):
```js
const jNombreProyecto = {
    eliminar: async (nroDetalle) => {
        try {
            jUtils.clean("iError");
            jUtils.showLoading();

            const response = await fetch("eliminar", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                // no hay form, entonces el body se arma a mano:
                body: `nro_detalle=${encodeURIComponent(nroDetalle)}`
            });

            if (!response.ok) {
                throw new Error(await response.text() || response.statusText);
            }
            // actualizar el DOM: sacar la fila, refrescar totales, etc.
        }
        catch (e) { jUtils.show("iError", e.message); console.error(e); }
        finally { jUtils.hideLoading(); }
    }
};
```
Detalles de la parte JS:
- **El objeto debe ser global** (declarado con `const` a nivel de archivo, como siempre lo hacés): el atributo `onclick` busca `jNombreProyecto` en el scope global. Si la función estuviera encerrada en otra función, el onclick fallaría con "is not defined".
- Como no hay formulario, el body del fetch se construye con template literal: `` `clave=${encodeURIComponent(valor)}` `` (y concatenás con `&` si son varios: `` `id=${id}&checked=${checked}` ``). El nombre de la clave = lo que el servlet lee con `req.getParameter("nro_detalle")`.
- El resto del cuerpo es el mismo esqueleto try/catch/finally de siempre (3.3), solo que sin `preventDefault` ni `FormData`.

**Cuándo usar b en vez de a:** cuando el disparador no es un submit de formulario sino un elemento individual (botón de eliminar en cada fila, un select, un checkbox) y sobre todo cuando ese elemento **lleva un dato propio** (el id de SU fila) que el servidor conoce al generarlo. El patrón a manda "todo el form"; el patrón b manda "el dato de este elemento".

**c) Delegación de eventos** (Verdu): un solo listener en un contenedor estable que nunca se destruye:
```js
document.getElementById('contenedorPedidos').addEventListener('click', async (event) => {
    const boton = event.target.closest('button');
    const card = event.target.closest('.card');
    ...
});
```
**Cuándo usar delegación:** cuando el contenido interno se reemplaza por AJAX. Si atás listeners a elementos que después reemplazás con `insertAdjacentHTML`, los nuevos elementos quedan "muertos". Con delegación, el listener vive en el padre y funciona para cualquier hijo, viejo o nuevo. `event.target` es el elemento exacto clickeado; `.closest('.card')` sube en el árbol hasta encontrar el contenedor de esa tarjeta.

**d) Extras que se repiten:** limpiar el error mientras el usuario tipea:
```js
document.querySelectorAll("input").forEach(input =>
    input.addEventListener("input", limpiar));
```
E interceptar F5 para reconstruir sin recargar (cajaRegistradora).

### 3.3 El esqueleto de TODO handler AJAX (memorizalo, es siempre igual)

```js
async function accion(event) {
    try {
        event.preventDefault();          // 1. frena el submit nativo
        jUtils.clean("iError");          // 2. limpia errores previos
        jUtils.showLoading();            // 3. spinner de carga

        const data = new FormData(event.target);   // 4. junta los inputs por su "name"

        const response = await fetch("urlDelServlet", {   // 5. petición
            method: "POST",
            body: new URLSearchParams(data),
            headers: { "Content-Type": "application/x-www-form-urlencoded" }
        });

        if (!response.ok) {              // 6. si el server devolvió 400/500
            const text = await response.text();
            throw new Error(text || response.statusText);
        }

        const html = await response.text();   // 7. fragmento HTML del server
        // 8. insertarlo en el DOM (ver 3.5)
        event.target.reset();            // 9. opcional: limpiar el form
    }
    catch (e) {
        jUtils.show("iError", e.message);   // 10. mostrar error
        console.log(e);
    }
    finally {
        jUtils.hideLoading();            // 11. SIEMPRE sacar el spinner
    }
}
```

Puntos clave:
- **`Content-Type: application/x-www-form-urlencoded`** + **`new URLSearchParams(data)`**: los datos viajan como `clave1=valor1&clave2=valor2`, que es lo que el servlet lee con `req.getParameter()`. Si mandaras el `FormData` crudo iría como multipart y `getParameter` puede fallar.
- Alternativa para pocos parámetros (sin form): armar el body a mano con template literals:
  ```js
  body: `cod_barra=${encodeURIComponent(codBarra)}`
  ```
- El `throw new Error(text)` dentro del `if (!response.ok)` es lo que hace que el mensaje de error que el servidor puso en `error-modal.jsp` llegue al `catch` y se muestre.
- **GET sin body** para consultas: `await fetch("ultimas", { method: "GET" })`.

### 3.4 Encadenar peticiones (patrón puntuaNet)

Después de guardar con POST, refrescar una lista con un segundo fetch GET dentro del mismo try:
```js
// 1) POST guardar  →  2) GET ultimas  →  3) reemplazar el bloque de la lista
```

### 3.5 Insertar la respuesta en el DOM — las 4 variantes

| Situación | Código |
|---|---|
| Agregar fila/ítem al final | `tbody.insertAdjacentHTML("beforeend", html)` |
| Agregar antes de un elemento marcador | `document.getElementById("iNew").insertAdjacentHTML("beforebegin", html)` |
| Reemplazar un bloque completo | `viejoElemento.remove()` + `contenedor.insertAdjacentHTML("afterend", html)` — o `card.insertAdjacentHTML('beforebegin', html); card.remove();` |
| Volcar en un contenedor | `jUtils.show("iResult", html)` (setea `innerHTML` y quita `d-none`) |
| Reemplazar toda la página | `document.querySelector("body").innerHTML = html` (patrón "enviar" de aerolínea) |
| Borrar la fila del botón clickeado | `btn.closest("tr").remove()` |

**Rollback** (Verdu): si la petición falla y el usuario había cambiado un checkbox, en el `catch` restaurás el estado visual: `target.checked = !checked;`.

### 3.6 Registrar listeners sobre HTML recién insertado

Si el fragmento devuelto contiene un form nuevo, hay que atarle el listener después de insertarlo:
```js
jUtils.show("iResult", await response.text());
document.getElementById("iReservaForm").addEventListener("submit", jAerolineas.enviar);
```
(O usar delegación de eventos y evitar el problema por completo.)

---

## 4. utils.js — Qué hace cada función y cuándo usarla

Este archivo **se copia tal cual** al proyecto nuevo. Referencia de uso:

| Función | Para qué sirve | Cuándo/dónde la usás |
|---|---|---|
| `jUtils.show(id, html)` | Pone `html` como `innerHTML` del contenedor, le saca la clase `d-none` y ejecuta los `<script>` que el HTML traiga adentro | Para mostrar resultados de un fetch en un div (`iResult`) o para mostrar mensajes de error (`iError`). Si le pasás solo el id (versión de puntuaNet), solo lo hace visible. |
| `jUtils.hide(id)` | Agrega `d-none` (oculta sin borrar contenido) | Cuando querés esconder algo temporalmente. |
| `jUtils.clean(id)` | Oculta **y** vacía el `innerHTML` | Al inicio de cada handler para limpiar el error anterior, y en handlers de "limpiar" cuando el usuario vuelve a tipear. |
| `jUtils.getElement(id)` | `getElementById` con validación: tira error claro si no existe | Interno de utils; podés usarlo si querés fallar fuerte. |
| `jUtils.executeScripts(container)` | Re-ejecuta los `<script>` de HTML insertado (los scripts insertados vía innerHTML no corren solos) | Lo llama `show` automáticamente. Importa si el fragmento JSP devuelto trae scripts. |
| `jUtils.showLoading()` | Crea overlay oscuro fullscreen con spinner de Bootstrap (`id="iLoading"`) | Al principio de todo handler async, antes del fetch. |
| `jUtils.hideLoading()` | Elimina el overlay | **Siempre en el `finally`** para que el spinner no quede colgado si hubo error. |

---

## 5. Servlets — El controlador del servidor

### 5.1 Esqueleto fijo (lo que NUNCA cambia)

```java
package ar.edu.ubp.<proyecto>.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/accion")            // = URL del fetch en JS
public class AccionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // leer parámetros (mismo nombre que el name="" del input o clave del body)
        String param = req.getParameter("cod_barra");

        try {
            try (Connection conn = DBConnection.getConnection()) {

                /* ===== ZONA VARIABLE: acá va A, B o C según la operación (ver 5.2) ===== */

                req.setAttribute("clave", beanOListado);
                req.getRequestDispatcher("/fragmento.jsp").forward(req, resp);
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }
}
```

Reglas fijas: URL del `@WebServlet` = URL del fetch (a veces la disfrazás de `.jsp`); GET para consultas, POST para modificaciones; todo recurso JDBC con try-with-resources; error → `setStatus(400)` + forward a `error-modal.jsp` (así el `response.ok` del JS da false); el servlet nunca imprime HTML, siempre forward a un JSP.

### 5.2 La zona variable: qué cambia según la operación

Lo único que cambia de un servlet a otro es el bloque del medio. Hay tres estructuras:

**A) CONSULTA (SELECT) → `executeQuery()` + `ResultSet`**

Tiene dos sub-casos según si la SQL lleva parámetros o no:

**A1 — SQL fija, SIN parámetros → `Statement` + `createStatement()`** (patrón puntuaNet, listados/catálogos):
```java
try (Statement stmt = conn.createStatement();
     ResultSet rs = stmt.executeQuery(
             "select top 3" +
             "       sitio         = sitio," +
             "       apodo         = apodo," +
             "       puntuacion    = puntuacion," +
             "       observaciones = observaciones," +
             "       fecha         = fecha_reseña" +
             "  from dbo.reseñas_sitios (nolock)" +
             " order by fecha_reseña desc")) {

    List<ResenaBean> resenas = new LinkedList<>();
    while (rs.next()) {
        ResenaBean r = new ResenaBean();
        r.setSitio(rs.getString("sitio"));
        r.setApodo(rs.getString("apodo"));
        r.setPuntuacion(rs.getInt("puntuacion"));
        r.setObservaciones(rs.getString("observaciones"));
        r.setFecha(rs.getString("fecha"));
        resenas.add(r);
    }
    req.setAttribute("resenas", resenas);
    req.getRequestDispatcher("listaResenas.jsp").forward(req, resp);
}
```
Notar la estructura: como no hay parámetros que setear, `Statement` y `ResultSet` van juntos en el **mismo** try-with-resources (separados por `;`), y la SQL se pasa directo a `executeQuery(sql)`. El forward puede ir dentro del mismo try porque el ResultSet ya se consumió.

**A2 — SQL CON parámetros del usuario → `PreparedStatement`** (obligatorio si hay input, evita SQL injection):
```java
String sql = "SELECT p.nro_producto, p.nombre AS nomProducto, p.precio " +
             "FROM productos p WHERE p.cod_barra = ?";
try (PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setString(1, codBarra);                      // primero setear los ?
    try (ResultSet rs = stmt.executeQuery()) {        // recién ahí ejecutar → ResultSet en su propio try
        LinkedList<ProductoBean> listado = new LinkedList<>();
        while (rs.next()) {                           // if (rs.next()) si esperás uno solo
            ProductoBean p = new ProductoBean();
            p.setNomProducto(rs.getString("nomProducto"));  // por alias del SELECT
            p.setPrecio(rs.getFloat("precio"));
            listado.add(p);
        }
    }
}
```
La diferencia estructural entre A1 y A2: con `PreparedStatement` no podés encadenar el `ResultSet` en el mismo try porque entre crear el statement y ejecutarlo tenés que setear los `?` — por eso quedan dos try anidados. Con `Statement` no hay nada que setear y va todo junto.

Común a ambos: `rs.next()` antes de leer; columnas por alias (`resena.setSitio(rs.getString("sitio"))` — el truco `alias = columna` o `AS alias` en el SELECT hace que coincidan con el bean); el `(nolock)` en los FROM es tu convención para lecturas en SQL Server.
NO debe estar en A: `setAutoCommit(false)`, `commit()`, `rollback()` — un SELECT no es transacción.

**B) MODIFICACIÓN (INSERT/UPDATE/DELETE) → `PreparedStatement` + `executeUpdate()` + transacción**

```java
conn.setAutoCommit(false);                            // abre transacción
String sql = "INSERT INTO detalle (nro_carrito, nro_producto) VALUES (?, ?)";
try (PreparedStatement stmt = conn.prepareStatement(sql)) {
    stmt.setInt(1, nroCarrito);
    stmt.setInt(2, nroProducto);
    stmt.executeUpdate();                             // devuelve int (filas afectadas)
    conn.commit();                                    // confirma
}
catch (SQLException e) {
    conn.rollback();                                  // deshace
    throw e;                                          // relanza → catch externo → error 400
}
```
Debe estar: `setAutoCommit(false)` / `commit()` / `rollback()`, `executeUpdate()`.
NO debe estar: `ResultSet` (no hay filas que leer; si necesitás mostrar lo insertado, armás el bean con los mismos parámetros que insertaste, o hacés un SELECT aparte).

**C) STORED PROCEDURE → `CallableStatement` + `prepareCall` + (opcional) parámetros OUT**

```java
String sql = "{call dbo.ins_producto_carrito(?, ?, ?)}"; // un ? por parámetro (IN y OUT)
try (CallableStatement stmt = conn.prepareCall(sql)) {   // prepareCall, NO prepareStatement
    stmt.setInt(1, nroProducto);                         // parámetros IN: igual que siempre
    stmt.setInt(2, nroCarrito);
    stmt.registerOutParameter(3, Types.INTEGER);         // parámetros OUT: registrar ANTES
    stmt.execute();                                      // execute(), a secas
    int nuevoNroCarrito = stmt.getInt(3);                // leer el OUT DESPUÉS de execute
}
```
Cambios estructurales respecto de A y B: la SQL es `{call nombre(?, ?, ...)}`; se usa `prepareCall`; se ejecuta con `execute()`; los OUT se registran antes de ejecutar y se leen después. La transacción normalmente la maneja el SP por dentro, así que no solés poner commit/rollback (aunque podés envolverlo igual si el enunciado lo pide). Si el SP devuelve un SELECT, `stmt.executeQuery()` te da el `ResultSet` como en A.

**Resumen para decidir en el momento:**

| Quiero... | Statement | Ejecutar con | ResultSet | Transacción |
|---|---|---|---|---|
| Leer datos, SQL fija (A1) | `Statement` → `createStatement()` | `executeQuery(sql)` | Sí (mismo try) | No |
| Leer datos con parámetros (A2) | `PreparedStatement` → `prepareStatement(sql)` | `executeQuery()` | Sí (try anidado) | No |
| Insertar/modificar/borrar (B) | `PreparedStatement` | `executeUpdate()` | No | Sí (commit/rollback) |
| Llamar un SP (C) | `CallableStatement` → `prepareCall(sql)` | `execute()` (o `executeQuery()` si el SP hace SELECT) | Solo si el SP devuelve filas | La maneja el SP |

Detalles de seteo que aplican a los tres: `setString`/`setInt`/`setFloat` según tipo; `stmt.setNull(n, Types.VARCHAR)` para parámetros opcionales; los `?` se numeran desde 1.

### 5.3 Sesión (estado por usuario: carrito, nro_carrito)

```java
HttpSession session = req.getSession();
Integer nroCarrito = (Integer) session.getAttribute("nro_carrito");
// ...
session.setAttribute("nro_carrito", nuevoValor);
```
Patrón carrito: si `nro_carrito` es null → es 0 → el SP lo crea y devuelve el número por OUT → lo guardás en sesión.

### 5.4 Cookies (recordar al usuario entre visitas)

**Sesión vs cookie:** la sesión vive en el **servidor** y muere al cerrar el navegador o expirar (carrito, usuario logueado en curso). La cookie vive en el **navegador** del usuario y sobrevive días/meses (recordar el correo del login, preferencias, último apodo usado). Regla práctica: dato sensible o de la operación en curso → sesión; dato de conveniencia para "la próxima vez" → cookie. **Nunca** guardes contraseñas en cookies.

**Crear/actualizar una cookie (en el servlet, típicamente al guardar o loguear):**
```java
Cookie correoCookie = new Cookie("correo", correo);   // nombre y valor (solo Strings)
correoCookie.setMaxAge(60 * 60 * 24 * 30);            // vida en SEGUNDOS (acá: 30 días)
correoCookie.setPath("/");                             // visible en toda la app
resp.addCookie(correoCookie);                          // ¡sin esto no viaja al navegador!
```
- `setMaxAge(n)`: si no lo ponés, la cookie es "de sesión" (muere al cerrar el navegador). `setMaxAge(0)` = **borrarla** (creás una con el mismo nombre, edad 0, y `addCookie`).
- El valor no admite espacios ni caracteres especiales sin encodear: si guardás texto libre, `URLEncoder.encode(valor, "UTF-8")` al crear y `URLDecoder.decode(...)` al leer.
- Se agrega **antes** de hacer el forward.

**Leerla en el servlet** (no hay `getCookie(nombre)`, hay que recorrer el array):
```java
String correo = null;
Cookie[] cookies = req.getCookies();          // puede ser null si no hay ninguna
if (cookies != null) {
    for (Cookie c : cookies) {
        if (c.getName().equals("correo")) {
            correo = c.getValue();
            break;
        }
    }
}
```

**Leerla directo en el JSP con EL** (la forma corta, ideal para precargar un input):
```jsp
<input type="email" name="correo" class="form-control"
       value="${cookie['correo'].value}">
```
`${cookie['nombre'].value}` devuelve vacío si no existe, así que no rompe nada. Con esto armás el clásico "recordarme": el servlet de guardar/login setea la cookie, y el index precarga el campo en la próxima visita.

**Patrón login simple con cookie + sesión combinadas:**
```java
// En LoginServlet (POST): validar credenciales contra la BD y...
session.setAttribute("usuario", usuarioBean);          // sesión = está logueado AHORA
Cookie c = new Cookie("correo", correo);               // cookie = recordar el correo
c.setMaxAge(60 * 60 * 24 * 30);
resp.addCookie(c);

// En cualquier otro servlet: verificar login
if (req.getSession().getAttribute("usuario") == null) {
    resp.setStatus(401);   // o redirect al login: resp.sendRedirect("login.jsp")
    req.setAttribute("error", "Debe iniciar sesión");
    req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
    return;                // ¡cortar la ejecución!
}

// En LogoutServlet: matar la sesión (la cookie del correo puede quedar)
req.getSession().invalidate();
```

### 5.4 Patrón de listado (SELECT → lista de beans → fragmento)

```java
LinkedList<ProductoBean> listado = new LinkedList<>();
while (rs.next()) {
    ProductoBean p = new ProductoBean();
    p.setNomProducto(rs.getString("nomProducto"));   // alias del SELECT
    p.setPrecio(rs.getFloat("precio"));
    listado.add(p);
}
req.setAttribute("listado", listado);
req.getRequestDispatcher("listado-productos.jsp").forward(req, resp);
```
Truco SQL habitual: en el SELECT usás alias camelCase (`nroDetalle = d.nro_detalle`) para que coincidan con los getters del bean.

---

## 6. Beans — El modelo

Plantilla fija, sin lógica:

```java
package ar.edu.ubp.<proyecto>.beans;

import java.io.Serializable;

public class XxxBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private String campo1;
    private int campo2;
    // usar Integer/String (no int) para campos que pueden ser null

    public XxxBean() { }                 // constructor vacío OBLIGATORIO

    public String getCampo1() { return campo1; }
    public void setCampo1(String campo1) { this.campo1 = campo1; }
    // ... un get/set por campo
}
```

Reglas:
- Constructor vacío + getters/setters con nombre exacto (`getNomProducto` ↔ propiedad EL `nomProducto`). Esto es lo que permite que en el JSP escribas `${producto.nomProducto}`.
- `Serializable` + `serialVersionUID` si el bean va a sesión.
- Tipos wrapper (`Integer` en vez de `int`) para columnas nullables.
- Los beans también pueden tener métodos de negocio invocables desde EL (patrón Verdu: `${listado.marcarEntrega(param.id, param.checked)}` — EL 3.0+ convierte los String a int/boolean automáticamente). Se usa cuando el "controlador" es un JSP en vez de un servlet.

---

## 7. JSP de fragmentos (la respuesta del AJAX)

Son JSPs **sin** `<html>`, `<head>` ni `<body>`: devuelven solo el pedazo de HTML que JS insertará.

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<tr>
    <td>${producto.nomProducto}</td>
    <td>$${producto.precio}</td>
    <td><button onclick="jProyecto.eliminar(${producto.nroDetalle})" class="btn btn-sm btn-outline-danger">
        <i class="bi bi-trash"></i></button></td>
</tr>
```

Patrones JSTL/EL que repetís:
- **Iterar listado delegando al fragmento unitario:**
  ```jsp
  <c:forEach var="prod" items="${requestScope.listado}">
      <c:set var="producto" value="${prod}" scope="request"/>
      <jsp:include page="producto.jsp"/>
  </c:forEach>
  ```
  El `c:set scope="request"` es clave: `<jsp:param>` solo pasa Strings, pero por request scope el JSP incluido recibe el **objeto** completo con sus tipos.
- Condicionales: `<c:if test="${!empty listado}">`, `<c:choose>/<c:when>/<c:otherwise>`.
- Ternarios EL: `${param.expand == 'true' ? 1000 : 4}`.
- URI del taglib: `jakarta.tags.core` (nuevo) o `http://java.sun.com/jsp/jstl/core` (viejo) — según versión del proyecto; con las dependencias JSTL 3.x usá el jakarta.

### 7.1 El fragmento reutilizable: un solo JSP para la carga inicial Y para el AJAX (patrón Corchito/ART)

Este es el patrón más elegante que usás y conviene tenerlo automatizado. La idea: **la fila/tarjeta se escribe UNA sola vez** (`row.jsp`) y se incluye desde dos lugares distintos, para que el HTML inicial y el que llega por AJAX sean idénticos sin duplicar código.

**row.jsp** — el fragmento unitario, solo sabe pintar UNA fila a partir de `${param.*}`:
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tr class="${param.eliminado ? "eliminado" : ""}">
    <td class="${param.eliminado ? "text-danger text-decoration-line-through" : ""}">${param.nombre}</td>
    <td>${param.eliminado ? "Eliminado" : "Jugando"}</td>
</tr>
```

**Llamada 1 — desde index.jsp** (carga inicial: pintar lo que ya existe, iterando con `c:forEach` y pasando cada campo por `jsp:param`):
```jsp
<tbody id="iTableBody">
    <c:forEach var="jug" items="${listado.jugadores}">
        <jsp:include page="row.jsp">
            <jsp:param name="nombre" value="${jug.nombre}"/>
            <jsp:param name="eliminado" value="${jug.eliminado}"/>
        </jsp:include>
    </c:forEach>
    <tr id="iNew"> ... fila con el form de alta ... </tr>
</tbody>
```

**Llamada 2 — desde save.jsp** (el "controlador JSP" que responde al fetch: guarda y devuelve la fila nueva). Acá NO hace falta `jsp:param`, porque los parámetros del POST (`nombre`, etc.) **ya están en `${param}`** — son los mismos nombres que los `name=""` del form, y `row.jsp` lee de `${param.*}`:
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="jug" class="ar.edu.ubp.corchito.JugadorBean">
    <jsp:setProperty name="jug" property="*"/>   <%-- carga el bean con TODOS los param del POST --%>
</jsp:useBean>

${applicationScope.listado.addJugador(jug)}       <%-- lógica: agregar al listado compartido --%>

<jsp:include page="row.jsp"/>                     <%-- respuesta = la fila recién creada --%>
```
Y en el JS, el fetch va contra `save.jsp` y la respuesta se inserta antes del marcador: `document.getElementById('iNew').insertAdjacentHTML("beforebegin", await response.text())`.

Piezas de este patrón que hay que saber:
- **`<jsp:useBean>` + `<jsp:setProperty property="*"/>`**: crea el bean y le vuelca automáticamente todos los parámetros del request cuyos nombres coincidan con sus propiedades (por eso los `name` de los inputs deben ser iguales a los campos del bean).
- **`scope="application"` en el `jsp:useBean` del index**: el listado es único y compartido por todos los usuarios (juego/registro global). Si fuera por usuario, iría `scope="session"`.
- **La condición para que funcione**: `row.jsp` lee todo de `${param.*}`. Desde el index los param se los das explícitos con `jsp:param`; desde save.jsp vienen "gratis" del POST. Si el fragmento en cambio lee de un objeto (`${producto.x}`), la reutilización se hace con `c:set scope="request"` en ambos llamadores (variante de la sección anterior — servlet hace `req.setAttribute` y el forEach hace `c:set`).
- Mismo criterio con badges/clases condicionales: toda la lógica visual del estado (tachado, colores, texto "Eliminado") vive en `row.jsp`, así se aplica igual venga de donde venga.

### error-modal.jsp (siempre igual)

```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%= request.getAttribute("error") != null ? request.getAttribute("error") : "Ocurrió un error inesperado." %>
```
Devuelve solo el texto del error. Como el servlet puso status 400, ese texto termina siendo el `e.message` que muestra el JS.

---

## 8. DBConnection.java (copiar y pegar, cambiar solo el package)

```java
package ar.edu.ubp.<proyecto>.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:14330;databaseName=pdc;encrypt=false";
    private static final String USER = "sa";
    private static final String PASS = "#Pdc314*";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
```
Ajustar puerto (14330 vs 1433), base y credenciales según tu entorno. En proyectos viejos hacías `Class.forName + DriverManager` directo en cada servlet; centralizarlo en esta clase es la versión buena.

---

## 9. Creación del proyecto con IntelliJ IDEA

Los proyectos se crean con el asistente de IntelliJ: **New Project → Jakarta EE**, con esta configuración:
- **Template:** Web application (esto genera Servlet de ejemplo, `web.xml` e `index.jsp`)
- **Application server:** Tomcat (el que tengas instalado)
- **Language:** Java · **Build system:** Maven
- **Group:** `ar.edu.ubp` · **Artifact:** nombre del proyecto
- En la pantalla siguiente (Next): versión de Jakarta EE y las specs; con Servlet/JSP alcanza.

El wizard genera solo: la estructura de carpetas completa (`src/main/java`, `src/main/webapp/WEB-INF`), el `pom.xml` con `jakarta.servlet-api` (scope `provided`), el plugin `maven-war-plugin`, `packaging=war`, el **`web.xml` vacío** (no hay que tocarlo: todo se configura con anotaciones `@WebServlet`), un `index.jsp` y un `HelloServlet` de ejemplo (este último lo podés borrar o reciclar como `InicioServlet`).

**Lo ÚNICO que hay que hacer a mano en el pom.xml** es agregar estas dependencias dentro de `<dependencies>` y presionar el ícono de sync de Maven (o `Ctrl+Shift+O` / botón "Load Maven Changes"):

```xml
<dependency>
    <groupId>org.webjars</groupId>
    <artifactId>bootstrap</artifactId>
    <version>5.3.8</version>
</dependency>
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.1</version>
</dependency>
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>
<dependency>
    <groupId>com.microsoft.sqlserver</groupId>
    <artifactId>mssql-jdbc</artifactId>
    <version>13.5.0.jre11-preview</version>
    <scope>compile</scope>
</dependency>
```

Qué aporta cada una:
- **webjars/bootstrap**: Bootstrap empaquetado como jar, accesible vía `${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/...`. Opcional si preferís el CDN en el `<head>`, pero conviene tenerla por si el examen es sin internet.
- **jstl-api + glassfish jstl**: API e implementación de JSTL (`<c:forEach>`, `<c:if>`, etc.). Van siempre juntas.
- **mssql-jdbc**: driver de SQL Server. Solo hace falta si el proyecto usa base de datos.

---

## 10. Recetario JS + HTML/Bootstrap (para cuando piden algo "bonito")

### 10.1 Manipulación del DOM que usás todo el tiempo

```js
// Mostrar / ocultar / alternar (siempre con d-none de Bootstrap)
el.classList.add('d-none');  el.classList.remove('d-none');  el.classList.toggle('d-none');

// Marcar estados visuales (patrón Corchito: tachar eliminados)
tr.classList.add('text-danger', 'text-decoration-line-through');

// Cambiar texto / valor
td.textContent = 'Eliminado';        // texto plano (seguro)
input.value = '';  input.focus();

// Buscar elementos
document.querySelectorAll('tr:not(.eliminado)')   // con selectores CSS, ej: filas "vivas"
[...tbody.children].length                         // contar hijos (spread para usar métodos de array)
tbody.children[i]                                  // hijo por índice
btn.closest('tr')                                  // subir hasta el contenedor

// Recorrer
for (const tr of tbody.children) { ... }
document.querySelectorAll('input').forEach(inp => inp.addEventListener('input', limpiar));

// Datos "colgados" del HTML (alternativa a pasar argumentos por onclick)
// JSP:  <button data-nro="${producto.nroDetalle}" data-precio="${producto.precio}">
// JS:   const nro = boton.dataset.nro;   const precio = boton.dataset.precio;

// Construir HTML desde JS (cuando no viene del servidor)
contenedor.insertAdjacentHTML('beforeend', `
    <tr><td>${nombre}</td><td>$${precio.toFixed(2)}</td></tr>
`);

// Recargar la página entera (solo para "reiniciar todo", patrón iBotonNew de Corchito)
location.reload();
```

### 10.2 Eventos útiles además de submit/click

```js
// change: selects y checkboxes (dispara al confirmar el cambio)
select.addEventListener('change', (e) => jX.filtrar(e.target.value));

// input: cada tecla en un campo de texto (limpiar errores, buscar en vivo, contadores)
campo.addEventListener('input', (e) => {
    jUtils.clean('iError');
    document.getElementById('iContador').textContent = e.target.value.length + '/255';
});

// keydown: teclas especiales (patrón cajaRegistradora: interceptar F5)
window.addEventListener('keydown', (event) => {
    if (event.key === 'F5') { event.preventDefault(); jX.reconstruir(); }
    if (event.key === 'Enter' && event.target.id === 'iCodBarra') { ... }
});

// reset: botón "Cancelar" de un form (limpia inputs solo; si querés limpiar más, escuchalo)
form.addEventListener('reset', () => jUtils.clean('iError'));

// Código de inicialización al cargar: NO hace falta DOMContentLoaded,
// tus <script defer> ya corren con el DOM listo → código suelto a nivel de archivo alcanza
// (patrón corchito.js: al cargar, decide qué botones mostrar según cuántas filas hay)
```

### 10.3 Kit Bootstrap para armar pantallas rápido

**Layout base** (el `<body>` de casi todos tus proyectos):
```html
<body class="container bg-light">
  <h3 class="my-3">Título</h3>
  <div id="iError" class="alert alert-danger d-none"></div>
  <div class="card">
    <div class="card-body"> ... contenido ... </div>
  </div>
</body>
```
Grillas si hay columnas: `<div class="row"> <div class="col-12 col-md-6">...</div> ... </div>` (apila en móvil, divide en desktop). Alineación rápida: `d-flex justify-content-between align-items-center`, `text-center`, márgenes/padding con `m-3 p-2 my-3 ms-auto`.

**Tabla estándar** (tu combo de siempre):
```html
<table class="table table-bordered table-striped table-hover align-middle">
    <thead class="table-dark"> <tr><th scope="col">...</th></tr> </thead>
    <tbody id="iTableBody"> ... </tbody>
</table>
```

**Formularios lindos:**
```html
<div class="mb-3">
    <label for="iNombre" class="form-label">Nombre</label>
    <input type="text" class="form-control" id="iNombre" name="nombre" placeholder="Nombre" required maxlength="255">
</div>
<select class="form-select" name="resultado" required>
    <option value="">Seleccionar</option>
    <option value="A">Apto</option>
</select>
<div class="form-check">
    <input class="form-check-input" type="checkbox" name="entregado" id="iEnt">
    <label class="form-check-label" for="iEnt">Entregado</label>
</div>
<div class="input-group">   <!-- input con botón pegado (buscadores) -->
    <input type="text" class="form-control" name="cod_barra" placeholder="Código">
    <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
</div>
```
Validación gratis del navegador: `required`, `maxlength`, `min`/`max`, `type="email|number|date"`, `pattern` — con eso el submit ni se dispara si está mal, sin escribir JS.

**Botones e íconos:** `btn btn-primary|success|danger|secondary|outline-danger`, tamaño `btn-sm`. Íconos adentro: `<i class="bi bi-trash"></i>`, `bi-pencil`, `bi-search`, `bi-plus-lg`, `bi-check-lg`, `bi-x-lg`, `bi-cart`, `bi-star-fill`.

**Badges para estados** (patrón Verdu):
```html
<span class="badge bg-success">Entregado</span>
<span class="badge bg-warning text-dark">Pendiente</span>
<span class="badge bg-danger">Eliminado</span>
```
En un fragmento JSP el color sale de un ternario: `class="badge ${pedido.entregado ? 'bg-success' : 'bg-warning text-dark'}"`.

**Alerts vs Modal para mensajes:**
```html
<!-- Alert inline (lo que jUtils.show usa con iError) -->
<div id="iError" class="alert alert-danger d-none"></div>
<div id="iOk" class="alert alert-success d-none"></div>
```
```html
<!-- Modal (la versión "linda"): definirlo una vez en el index -->
<div class="modal fade" id="errorModal" tabindex="-1">
  <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header bg-danger text-white">
          <h5 class="modal-title">Error</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="errorModalBody"></div>
      <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
  </div></div>
</div>
```
```js
// y abrirlo desde JS en el catch:
document.getElementById('errorModalBody').textContent = e.message;
new bootstrap.Modal(document.getElementById('errorModal')).show();
```

**Tarjetas para ítems** (alternativa a la tabla, patrón Verdu con pedidos):
```html
<div class="card mb-3">
    <div class="card-header d-flex justify-content-between align-items-center">
        Pedido #12 <span class="badge bg-warning text-dark">Pendiente</span>
    </div>
    <div class="card-body"> ... </div>
    <div class="card-footer text-end">
        <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i> Quitar</button>
    </div>
</div>
```

Con `container + card + table/cards + form-control + btn + badge + alert/modal + d-none` cubrís cualquier interfaz que te pidan; lo demás es combinar.

---

## 11. Checklist para arrancar un proyecto nuevo

1. IntelliJ → New Project → Jakarta EE → template "Web application", Maven, Group `ar.edu.ubp` (ver sección 9). El wizard ya crea estructura, `pom.xml` base, `web.xml` e `index.jsp`.
2. Agregar al `pom.xml` las 4 dependencias de la sección 9 → sync de Maven. Pegar `utils.js` (en `webapp/js/`), `DBConnection.java` (cambiar package) y `error-modal.jsp`. Borrar el `HelloServlet` de ejemplo.
3. Maquetar `index.jsp` con el `<head>` estándar, forms con `action="javascript:void(0)"`, ids `iXxx`, `name` de inputs = parámetros del servlet, y `<div id="iError" class="d-none">`.
4. Crear los beans (campos = columnas/parámetros, getters/setters, constructor vacío).
5. Por cada acción de la interfaz: un servlet `@WebServlet("/accion")` con el esqueleto de la sección 5.1 + su JSP fragmento.
6. Escribir `<proyecto>.js`: un handler por acción con el esqueleto try/catch/finally, y los listeners al final (o delegación si el HTML se reemplaza por AJAX).
7. Probar el flujo de error: forzar una excepción y verificar que el modal/`iError` muestre el mensaje.
