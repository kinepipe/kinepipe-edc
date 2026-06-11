# Glosario de Diseño de Software para la Interacción con IA Agéntica (Español)

Este documento recopila términos clave del diseño de software explicados en un lenguaje accesible para personas sin conocimientos técnicos. Su propósito es facilitar la comunicación y el diseño colaborativo con agentes de inteligencia artificial (IA agéntica).

---

## 1. Fundamentos y Arquitectura del Sistema

| Término | Descripción Técnica | Usos Típicos en Colaboración con IA | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **Frontend** | La interfaz visible de una aplicación (botones, textos, menús, colores) con la que el usuario interactúa directamente en el navegador o dispositivo móvil. | Diseñar la apariencia, usabilidad, animaciones y flujos visuales de las pantallas. | *"Diseña el frontend para un formulario de registro médico, asegurando que sea limpio, con tonos azules y adaptable a móviles."* |
| **Backend** | La lógica lógica detrás de escena ("el cerebro" del sistema) que procesa datos, gestiona la seguridad, se comunica con bases de datos y maneja las reglas de negocio. | Definir cómo se guardan los datos, cómo se validan los accesos y cómo funciona el motor del software. | *"Crea el backend para procesar el formulario de registro, validando que el correo electrónico no esté duplicado antes de guardarlo."* |
| **Base de Datos (Database)** | Un sistema organizado para almacenar, consultar y recuperar información de manera persistente y segura. | Definir dónde y cómo se almacenarán los registros del negocio (usuarios, ventas, sensores). | *"Genera una base de datos relacional para gestionar un consultorio médico, que guarde pacientes, citas e historial médico."* |
| **Servidor / Cliente (Server / Client)** | El **Cliente** es el dispositivo que solicita un servicio (ej. tu navegador web) y el **Servidor** es la computadora remota que atiende y responde a esa solicitud. | Diseñar arquitecturas web o de red y definir flujos de carga/petición de recursos. | *"Configura la conexión cliente-servidor para que cuando el cliente presione 'Buscar', el servidor responda en menos de un segundo."* |
| **Despliegue / Producción (Deployment / Production)** | El **Despliegue** es el proceso de publicar el software en internet. **Producción** es el entorno real donde los usuarios finales ya están utilizando la aplicación activa. | Pasar de la fase de desarrollo en borrador a una versión pública y disponible para todo el mundo. | *"Prepara el despliegue de la aplicación en un servidor web y asegúrate de que el entorno de producción tenga habilitada la seguridad SSL."* |

---

## 2. Modelado y Estructuración de Datos

| Término | Descripción Técnica | Usos Típicos en Colaboración con IA | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **Modelo de Datos / Entidad (Data Model / Entity)** | Representación de un concepto del mundo real (ej. "Paciente", "Producto") estructurado en forma de objeto o tabla en el sistema. | Definir las piezas clave de información del negocio y estructurar la información base de la aplicación. | *"Define la entidad 'Curso' con campos para el nombre, código interno, descripción y fecha de inicio."* |
| **Atributo / Campo (Attribute / Field)** | Las características o datos específicos que describen a una entidad (ej. el atributo "Edad" de la entidad "Paciente"). | Detallar la información que se capturará o mostrará para cada objeto dentro del sistema. | *"Añade los atributos 'precio', 'stock_disponible' y 'categoría' a la entidad 'Producto'."* |
| **Relación y Jerarquía (Relationship & Hierarchy)** | Cómo se conectan las entidades entre sí (ej. una relación 1 a N donde un "Curso" contiene múltiples "Secciones", o "Padre/Hijo" donde la sección depende del curso). | Crear estructuras ordenadas, bases de datos consistentes y árboles de contenido lógicos. | *"Establece una jerarquía donde 'Carrera' sea el padre de 'Curso', y 'Curso' sea el padre de 'Sección'."* |
| **Clave Primaria / Clave Foránea (Primary Key / Foreign Key)** | La **Clave Primaria** es el identificador único de un registro (ej. ID de usuario). La **Clave Foránea** es ese mismo ID guardado en otra tabla para crear una conexión entre ambas. | Vincular bases de datos relacionales asegurando que no haya confusión entre registros similares. | *"Configura el ID de paciente como clave primaria en la tabla 'Pacientes' y como clave foránea en la tabla 'Citas' para vincularlos."* |
| **Catálogo / Enumeración (Enum)** | Una lista cerrada de valores predefinidos que no cambian fácilmente (ej. los días de la semana, tipos de usuario como "Admin" o "Lector"). | Limitar las opciones de entrada del usuario para evitar errores de escritura y asegurar consistencia de datos. | *"Crea un Enum para el estado de la cita médica, con valores fijos: 'Pendiente', 'Confirmada', 'Cancelada' y 'Realizada'."* |
| **JSON / YAML** | Formatos de texto estructurado y legible tanto por humanos como por computadoras, muy usados para intercambiar datos o configurar parámetros. | Intercambiar datos entre frontend y backend, o definir configuraciones del sistema de forma limpia. | *"Devuelve los datos del paciente en formato JSON para que la interfaz pueda pintarlos fácilmente en una tabla."* |

---

## 3. Interfaz de Usuario y UX (User Interface / User Experience)

| Término | Descripción Técnica | Usos Típicos en Colaboración con IA | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **Evento de UI / Callback** | Una acción del usuario en la pantalla que el sistema detecta (ej. `onClick` al hacer clic, `onChange` al escribir en un cuadro de texto). | Programar qué pasa exactamente cuando el usuario interactúa con los controles visuales. | *"Cuando ocurra el evento `onChange` en el buscador, filtra la lista de estudiantes en tiempo real sin recargar la página."* |
| **Guardado Automático vs. Manual (Autosave vs. Manual)** | El **Guardado Automático** guarda los cambios en tiempo real ante pequeños eventos (como perder el foco de un campo), mientras que el **Manual** requiere hacer clic en un botón "Guardar". | Diseñar la experiencia de persistencia de datos y evitar que el usuario pierda su progreso. | *"Implementa un sistema de guardado automático (autosave) con el evento `onBlur` en los campos del historial clínico."* |
| **Estado de UI (UI State)** | La condición visual temporal en la que se encuentra un elemento (ej. `loading` cuando procesa datos, `disabled` cuando está bloqueado, `error` si falta un campo). | Proveer retroalimentación visual al usuario sobre lo que está ocurriendo internamente en el sistema. | *"Si el usuario no ha completado los campos requeridos, cambia el estado del botón a `disabled` e ilumina los campos vacíos en rojo."* |
| **Componentes de UI Comunes** | Elementos visuales estándar como **Modales** (ventanas emergentes), **Toasts** (notificaciones flotantes breves), **Inputs** (cajas de texto) y **Selects** (listas desplegables). | Construir pantallas consistentes utilizando un catálogo de elementos de diseño estándar. | *"Muestra una alerta tipo Toast en la esquina superior derecha cuando los cambios se hayan guardado exitosamente."* |
| **Diseño Responsivo (Responsive Design)** | Técnica de diseño que hace que la interfaz de usuario se adapte y se vea bien de forma automática en cualquier tamaño de pantalla (móviles, tablets, PC). | Asegurar que el software sea usable en computadoras de escritorio y teléfonos móviles simultáneamente. | *"Haz que el tablero de control sea responsivo, ocultando la barra lateral en pantallas de celulares y reemplazándola por un menú hamburguesa."* |

---

## 4. Interacción con Agentes de IA y Desarrollo

| Término | Descripción Técnica | Usos Típicos en Colaboración con IA | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **IA Agéntica / Agente Autónomo** | Sistemas de IA diseñados para operar de forma autónoma, tomar decisiones secuenciales, usar herramientas de desarrollo y resolver problemas complejos sin requerir validación paso a paso. | Delegar flujos complejos de desarrollo (ej. crear código, auditar seguridad o escribir pruebas de software). | *"Actúa como un agente de desarrollo de software autónomo y refactoriza esta estructura de carpetas para hacerla más mantenible."* |
| **Bucle de Ejecución (Execution Loop)** | El proceso iterativo por el cual un agente de IA analiza un problema, ejecuta una acción (como escribir código), evalúa el resultado o error, y corrige su plan hasta completarlo. | Entender cómo la IA depura y progresa por sí sola ante fallos de compilación o lints. | *"Usa tu bucle de ejecución interna para compilar el proyecto repetidas veces y corregir cualquier error de tipado que encuentres."* |
| **Uso de Herramientas (Tool Calling)** | La capacidad de un agente de IA para invocar herramientas externas (ej. leer un archivo, ejecutar comandos en terminal, buscar en la web) para completar tareas. | Permitir que la IA modifique directamente la base de código o consulte la documentación actualizada. | *"Usa tu herramienta de búsqueda de archivos para localizar dónde se definen las rutas del servidor y añade una nueva ruta."* |
| **Subagente (Subagent)** | Un agente secundario creado por el agente principal con instrucciones y alcances específicos para resolver una subtarea especializada de forma aislada. | Dividir problemas gigantescos en tareas hiperespecíficas y ejecutarlas en paralelo (ej. un subagente para redactar texto y otro para código). | *"Genera un subagente especializado en accesibilidad web (WCAG) para auditar la interfaz y proponer mejoras en los componentes."* |
| **Prompt / Ingeniería de Prompts** | El texto o instrucción estructurada que se le da a una IA para obtener el resultado más preciso, contextualizado y óptimo posible. | Guiar el comportamiento del modelo especificando el rol, el contexto, las restricciones y el formato de salida esperado. | *"Usa técnicas de ingeniería de prompts agregando ejemplos de entrada/salida (few-shot) para estructurar el resultado."* |
| **Datos Simulados / De Prueba (Mock Data)** | Datos ficticios pero con estructura realista (nombres, fechas, correos falsos) creados para probar el sistema antes de conectarlo a datos reales. | Probar y validar interfaces de usuario o flujos lógicos sin arriesgar información privada o real. | *"Genera un archivo con datos simulados (mock data) de 10 estudiantes de kinesiología con sus respectivas notas de biomecánica."* |

---

## 5. Flujos de Trabajo y Git

| Término | Descripción Técnica | Usos Típicos en Colaboración con IA | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **Repositorio (Repository)** | El directorio o carpeta digital controlada por Git donde se guarda todo el código fuente y el historial de cambios de un proyecto. | Organizar el código del proyecto y realizar un seguimiento histórico de todo lo construido. | *"Crea un nuevo repositorio local e inicializa un archivo .gitignore adecuado para un proyecto de Node.js."* |
| **Git Commit / Historial** | Un **Commit** es como una 'foto' o guardado del estado del código en un punto del tiempo, acompañado de un mensaje que explica qué cambios se hicieron. | Guardar de forma incremental el progreso del proyecto de software y permitir volver a versiones anteriores si algo se rompe. | *"Realiza un commit con los cambios del glosario usando un mensaje descriptivo siguiendo la convención de 'conventional commits'."* |
| **Refactorización (Refactoring)** | Reescribir el código interno de un programa para hacerlo más limpio, eficiente o legible, sin cambiar en absoluto la forma en que funciona para el usuario. | Optimizar el rendimiento del sistema o hacer que el código sea más fácil de mantener y escalar a futuro. | *"Refactoriza esta función para eliminar el código duplicado y hacer que sea más fácil de probar con pruebas unitarias."* |
| **Metadatos / Frontmatter (YAML/Markdown)** | Bloques de datos organizados estructuradamente en la parte superior de un archivo Markdown (usualmente entre líneas `---`), usados para catalogar y filtrar información. | Definir metadatos (como título, autor, versión, fecha) de documentos que serán leídos automáticamente por herramientas o gestores de contenido. | *"Añade un bloque de metadatos Frontmatter al inicio de este archivo Markdown especificando el autor, idioma y fecha de creación."* |

---

## Referencias Web para Conocer Más

Para profundizar en el diseño y arquitectura de software, te recomendamos visitar:

1. **[MDN Web Docs (Mozilla Developer Network)](https://developer.mozilla.org)** - La referencia definitiva y accesible para aprender sobre HTML, CSS, JavaScript y conceptos fundamentales de la web.
2. **[Refactoring.Guru](https://refactoring.guru/es)** - Un sitio excelente y muy visual para entender patrones de diseño de software y refactorización con analogías sencillas del mundo real.
3. **[The Agent Skills Directory](https://www.skills.sh)** - Repositorio de recursos y especificaciones sobre el diseño de habilidades y reglas para agentes autónomos.
4. **[W3Schools](https://www.w3schools.com)** - Tutoriales interactivos sencillos ideales para principiantes que desean familiarizarse con terminología técnica del desarrollo de software.
