# Glosario Ampliado de Diseño de Software para la Interacción con IA Agéntica (Español)

Este documento recopila términos clave del desarrollo frontend, interfaces de usuario (UI), modelado de datos, lógicas jerárquicas y persistencia. Su propósito es ayudar a personas sin conocimientos de programación a comunicarse con precisión con agentes de inteligencia artificial (IA agéntica) para diseñar y refactorizar software.

---

## Índice
1. [Eventos y Acciones de Interfaz (UI Events & Callbacks)](#1-eventos-y-acciones-de-interfaz-ui-events--callbacks)
2. [Estados Visuales de UI (UI States)](#2-estados-visuales-de-ui-ui-states)
3. [Nombres Dinámicos y Formateo de Variables](#3-nombres-dinámicos-y-formateo-de-variables)
4. [Estructura de Datos, Jerarquías y Anidación](#4-estructura-de-datos-jerarquías-y-anidación)
5. [Modelos de Datos y Catálogos](#5-modelos-de-datos-y-catálogos)
6. [Persistencia y Flujos de Guardado](#6-persistencia-y-flujos-de-guardado)
7. [Entidades y Estructuras del Dominio Educativo / LMS](#7-entidades-y-estructuras-del-dominio-educativo--lms)
8. [Referencias Web para Conocer Más](#referencias-web-para-conocer-más)

---

## 1. Eventos y Acciones de Interfaz (UI Events & Callbacks)

Los eventos son las acciones del usuario o del sistema que el navegador detecta. Definir qué evento activa una acción es clave para programar interfaces interactivas.

### A. Eventos de Mouse (Puntero)
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`onClick`** | Ocurre cuando el usuario hace un clic simple sobre un elemento. | Botones de envío, enlaces, botones de guardar. | *"Haz que al dispararse el evento `onClick` del botón 'Enviar', se valide todo el formulario."* |
| **`onDoubleClick`** | Ocurre cuando el usuario hace doble clic rápido en un elemento. | Abrir carpetas, seleccionar palabras, acciones avanzadas. | *"Configura una acción para que en el evento `onDoubleClick` sobre la fila del alumno se abra su historial completo."* |
| **`onMouseEnter`** | Se activa en el instante en que el cursor del mouse ingresa al área física del elemento. | Mostrar menús desplegables, tooltips informativos o efectos visuales inmediatos. | *"Cuando ocurra `onMouseEnter` sobre el icono de ayuda, despliega un tooltip flotante con el texto explicativo."* |
| **`onMouseLeave`** | Se activa cuando el cursor del mouse sale del área del elemento. | Ocultar tooltips, cerrar menús desplegables abiertos por hover. | *"Al activarse el evento `onMouseLeave` en el menú de usuario, oculta el menú desplegable de forma suave."* |
| **`onMouseOver`** | Similar a `onMouseEnter`, pero se activa repetidamente cuando el cursor pasa por encima del elemento o de cualquiera de sus elementos hijos. | Control de animaciones complejas o menús anidados de múltiples niveles. | *"Usa `onMouseOver` en la lista para resaltar la sección específica en la que se encuentra el usuario."* |
| **`onMouseMove`** | Se dispara constantemente mientras el cursor del mouse se mueva dentro de los límites del elemento. | Lienzos interactivos (canvas), arrastre personalizado, seguimiento de coordenadas. | *"Captura el evento `onMouseMove` para mover un elemento visual flotante siguiendo la punta del cursor."* |
| **`onContextMenu`** | Ocurre cuando el usuario hace clic derecho sobre el elemento, antes de que aparezca el menú del navegador. | Abrir menús de opciones personalizados o deshabilitar el clic derecho en exámenes en línea. | *"Usa el evento `onContextMenu` para abrir un menú emergente con las opciones 'Editar', 'Duplicar' y 'Eliminar'."* |
| **`hover` (CSS)** | Estado visual que se aplica automáticamente en hojas de estilo mientras el puntero está sobre el elemento. | Cambiar colores de botones o resaltar filas al pasar el mouse por encima. | *"Aplica un efecto `hover` de CSS en los botones para que su fondo se vuelva un azul más oscuro al pasar el cursor."* |

### B. Eventos de Teclado
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`onKeyDown`** | Ocurre en el momento en que el usuario presiona cualquier tecla del teclado. | Atajos de teclado (como presionar Esc para cerrar), controles de juegos web. | *"Escucha el evento `onKeyDown` y, si la tecla presionada es 'Escape', cierra el modal activo."* |
| **`onKeyUp`** | Ocurre en el momento en que el usuario suelta la tecla que estaba presionando. | Validación de campos mientras se escribe, detección de finalización de texto. | *"Utiliza `onKeyUp` en el campo de texto para verificar si el texto ingresado tiene formato de correo válido."* |
| **`onInput`** | Se dispara en tiempo real cada vez que cambia el valor dentro de un cuadro de texto (input o textarea). | Contador de caracteres en vivo, búsquedas predictivas instantáneas. | *"Usa `onInput` en el buscador para que filtre los resultados con cada letra que el usuario escribe."* |
| **`onChange`** | Se activa cuando el elemento pierde el foco (blur) tras haber cambiado su valor, o inmediatamente al seleccionar otra opción en una lista desplegable (Select). | Guardar datos cuando el usuario termina de escribir, capturar la selección de un menú desplegable. | *"En el evento `onChange` del menú de selección de país, actualiza la lista de ciudades disponibles."* |

### C. Eventos Táctiles (Touch)
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`onTouchStart`** | Ocurre cuando el usuario coloca un dedo sobre la pantalla táctil. | Detectar el inicio de gestos en móviles, juegos móviles. | *"Al activarse `onTouchStart`, registra la posición inicial del dedo para calcular el deslizamiento."* |
| **`onTouchEnd`** | Ocurre cuando el usuario levanta el dedo de la pantalla táctil. | Confirmar acciones en interfaces móviles, disparar toques rápidos. | *"En dispositivos móviles, usa `onTouchEnd` en lugar de click para agilizar la respuesta del botón."* |
| **`onTouchMove`** | Se dispara constantemente mientras el usuario arrastra el dedo por la pantalla. | Mover carruseles de imágenes, arrastrar elementos en móviles. | *"Captura el movimiento con `onTouchMove` para permitir al usuario deslizar las diapositivas con el dedo."* |
| **`onTap`** | Abstracción táctil que representa un toque rápido y simple en la pantalla (equivalente a un clic). | Acciones comunes en interfaces mobile-friendly. | *"Haz que el botón responda al evento `onTap` en pantallas táctiles para evitar el retraso del clic tradicional."* |
| **`onLongPress`** | Abstracción que detecta cuando un dedo se mantiene presionado en el mismo lugar durante un tiempo determinado (ej. 1 segundo). | Mostrar menús contextuales o activar modos de edición en dispositivos móviles. | *"Si el usuario hace `onLongPress` sobre una pregunta en el móvil, activa la opción para arrastrarla y reordenarla."* |

### D. Interacciones Complejas (Arrastre y Deslizamiento)
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`drag`** | Evento que se dispara continuamente mientras un elemento es arrastrado por el usuario. | Visualizar la trayectoria de un objeto durante su movimiento. | *"Muestra una sombra difusa debajo del elemento mientras dure el evento `drag`."* |
| **`dragstart`** | Se dispara en el momento exacto en que el usuario empieza a arrastrar un elemento. | Cambiar el aspecto visual del objeto (hacerlo semitransparente) para indicar que está seleccionado para moverse. | *"En el evento `dragstart`, reduce la opacidad del elemento al 50% para dar feedback de arrastre."* |
| **`dragend`** | Se dispara cuando el usuario finaliza el arrastre (ya sea soltando el botón del mouse o levantando el dedo). | Restaurar el aspecto original del elemento o limpiar variables temporales. | *"En el evento `dragend`, devuelve la opacidad del objeto a su estado original."* |
| **`drop`** | Ocurre cuando el elemento arrastrado se suelta sobre una zona de destino válida. | Procesar la entrega de archivos, colocar un elemento en una nueva posición. | *"Captura el evento `drop` en la zona de carga para procesar el archivo PDF arrastrado por el usuario."* |
| **`drag & drop`** | El flujo completo compuesto por seleccionar un objeto, arrastrarlo y soltarlo en un contenedor de destino. | Ejercicios escolares de relacionar columnas, organizar tableros de tareas (Kanban). | *"Crea un ejercicio interactivo de `drag & drop` para emparejar términos anatómicos con su imagen correspondiente."* |
| **`swipe`** | Gesto táctil rápido de deslizar el dedo en una dirección determinada (izquierda, derecha, arriba, abajo). | Pasar páginas de libros digitales, descartar notificaciones flotantes. | *"Implementa un gesto de `swipe` a la izquierda para borrar un estudiante de la lista de asistencia."* |
| **`pinch`** | Gesto multitáctil que detecta cuando dos dedos se acercan o se separan en la pantalla. | Zoom interactivo sobre diagramas, imágenes médicas o mapas. | *"Permite el gesto de `pinch` en el visor de imágenes para ampliar y reducir el tamaño de la radiografía de muestra."* |

### E. Eventos de Foco y Navegación
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`onFocus`** | Se activa cuando un elemento interactivo (como un campo de texto o botón) recibe la atención del cursor o del teclado. | Resaltar visualmente el campo activo, mostrar guías de ayuda contextual. | *"Cuando ocurra `onFocus` en el campo 'Contraseña', muestra un recuadro indicando los requisitos de seguridad."* |
| **`onBlur`** | Se activa cuando un elemento interactivo pierde la atención del cursor (el usuario hace clic en otro lado o avanza con Tab). | Validar si el campo quedó vacío, formatear texto (ej. pasar a mayúsculas), o lanzar autoguardados. | *"Al disparar `onBlur` en el campo RUT/DNI, valida si el formato ingresado es correcto y muestra un error si no lo es."* |
| **`onSelect`** | Ocurre cuando el usuario selecciona texto dentro de un campo de entrada (input) o área de texto. | Permitir copiar texto rápido, abrir menús de formato (negrita, cursiva) en editores de texto. | *"Usa `onSelect` en el lector de PDF para permitir al usuario subrayar y destacar palabras clave."* |
| **`onSubmit`** | Se dispara cuando un formulario es enviado (al presionar un botón de tipo 'submit' o presionar Enter). | Enviar respuestas a un servidor, validar todo el grupo de campos antes de procesar los datos. | *"Evita el comportamiento por defecto en el evento `onSubmit` del formulario y envía los datos mediante una petición asíncrona."* |
| **`onReset`** | Ocurre cuando el usuario limpia un formulario presionando un botón de tipo 'reset'. | Devolver los campos de un buscador a sus valores por defecto. | *"En el evento `onReset`, limpia también los resultados de búsqueda mostrados en pantalla."* |

### F. Eventos de Carga y Estado del Navegador
| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`onLoad`** | Se activa cuando el navegador termina de cargar completamente el elemento o la página web (incluyendo imágenes y hojas de estilo). | Ocultar pantallas de carga (spinners), iniciar animaciones de entrada, inicializar datos de usuario. | *"Cuando ocurra el evento `onLoad` de la aplicación, solicita los datos del curso asignado al docente."* |
| **`onUnload`** | Ocurre cuando el usuario está cerrando la pestaña o navegando hacia otra página web. | Limpiar credenciales temporales, registrar logs rápidos de cierre de sesión. | *"Usa `onUnload` para enviar una métrica al servidor indicando que el usuario cerró la pestaña del examen."* |
| **`onBeforeUnload`** | Se activa justo antes de que la página se descargue o se cierre. Permite mostrar un cuadro de confirmación al usuario. | Evitar que el usuario pierda respuestas o cambios no guardados por cerrar accidentalmente. | *"Si hay cambios sin guardar en el editor de exámenes, usa `onBeforeUnload` para advertir al usuario antes de salir."* |
| **`onResize`** | Ocurre cuando la ventana del navegador cambia de tamaño o de orientación (vertical/horizontal en tablets). | Recalcular dimensiones de gráficos interactivos, ajustar componentes complejos que no admitan CSS fluido. | *"Escucha el evento `onResize` de la ventana para redibujar el canvas interactivo con sus nuevas proporciones."* |
| **`onScroll`** | Se dispara de forma continua mientras el usuario se desplaza vertical u horizontalmente por la página. | Crear barras de progreso de lectura, activar botones de 'volver arriba', o implementar 'scroll infinito'. | *"En el evento `onScroll`, calcula el porcentaje leído de la lección y actualiza la barra de progreso superior."* |

---

## 2. Estados Visuales de UI (UI States)

Los estados representan la condición de un componente en un momento dado. Ayudan a que el usuario comprenda qué puede y qué no puede hacer en la interfaz.

| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`active`** | Representa el estado en el instante exacto en que un elemento está siendo presionado (ej. pulsando un botón antes de soltar el clic). | Brindar respuesta física inmediata a las acciones del usuario. | *"Cambia el fondo del botón a un color verde claro en su estado `active`."* |
| **`disabled`** | Indica que un elemento está deshabilitado. No responde a interacciones ni eventos (se ve opaco o gris). | Bloquear botones de envío si faltan datos obligatorios, o congelar formularios una vez enviados. | *"Mantén el botón de finalizar examen en estado `disabled` hasta que el alumno responda al menos el 80% de las preguntas."* |
| **`selected`** | Indica que un elemento o fila ha sido explícitamente elegido entre un grupo de opciones. | Resaltar la fila de una tabla o una opción en una lista de respuestas. | *"Cuando el alumno haga clic en una respuesta alternativa, aplícale el estado `selected` con un borde azul de 2px."* |
| **`checked`** | Estado de selección específico para elementos de tipo casilla de verificación (Checkbox) o botón de opción (Radio Button). | Saber si una opción de verdadero/falso está marcada. | *"Verifica si el checkbox de 'Acepto términos y condiciones' tiene el estado `checked` antes de permitir el registro."* |
| **`focused`** | Indica que un elemento de entrada de datos está activo y listo para recibir texto desde el teclado. | Resaltar con un borde brillante la caja de texto en la que se está escribiendo para mejorar la accesibilidad. | *"Cuando un input adquiera el estado `focused`, aumenta el contraste del borde para cumplir con reglas de accesibilidad."* |
| **`loading`** | Estado temporal en el que un componente está esperando que se complete un proceso asíncrono (ej. consultar un servidor). | Mostrar un círculo giratorio (spinner) dentro de un botón mientras se valida la clave. | *"Mientras el backend procesa el inicio de sesión, pon el botón en estado `loading` y muestra un spinner animado."* |
| **`error`** | Estado visual que resalta que un elemento contiene datos incorrectos o que ha ocurrido un fallo de validación. | Marcar campos en rojo con textos de advertencia debajo de ellos. | *"Si el correo ingresado no es válido, pon el input en estado `error` y muestra el texto 'Email incorrecto' en rojo."* |

---

## 3. Nombres Dinámicos y Formateo de Variables

Muy útil para automatizar la creación de nombres de archivos, códigos de estudiantes, o textos automáticos combinando campos de datos.

| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`placeholder`** | Texto o valor temporal que sirve de marcador de posición hasta que el usuario o el sistema introduzcan el dato real (ej. `{user_name}`). | Diseñar plantillas de certificados o textos automatizados. | *"Usa `{course_name}` como un `placeholder` que se reemplace dinámicamente con el nombre de la materia seleccionada."* |
| **`template`** | Cadena de texto base configurada con marcadores de posición fijos que establece cómo se unirá la información. | Definir la estructura uniforme de salida de datos o nombres de archivos exportados. | *"Crea un `template` para generar los nombres de los reportes siguiendo la estructura: `{fecha}-{curso_codigo}-{tipo_reporte}`."* |
| **`concatenation`** | El proceso de unir dos o más cadenas de texto para formar una sola. | Unir el nombre y el apellido del alumno, o construir una URL dinámica. | *"Haz una `concatenation` del apellido, seguido de una coma, un espacio, y el nombre del estudiante para mostrar en el listado."* |
| **`separator`** | El carácter específico que se introduce entre elementos de texto concatenados para facilitar su lectura (ej. `-`, `_`, ` \| `). | Organizar nombres de archivos exportados de forma legible. | *"Usa un guion bajo `_` como `separator` para construir el nombre del archivo PDF generado."* |
| **`delimiter`** | Carácter utilizado para separar campos de datos en formatos planos, permitiendo que los sistemas interpreten dónde termina un dato y empieza otro. | Generar archivos de exportación en formato CSV estructurados con comas o puntos y comas. | *"Exporta el listado de calificaciones usando el punto y coma `;` como `delimiter` de columnas."* |
| **`pattern`** | Regla o plantilla de validación estricta que define la estructura obligatoria de un texto (ej. expresión regular). | Validar códigos de asignaturas (ej. 3 letras y 3 números: `KIN301`). | *"Establece un `pattern` para que el código de la sección obligatoriamente empiece con mayúscula y termine con un dígito."* |
| **`format`** | Modificación o regla de salida de texto para normalizar su visualización (ej. convertir todo a mayúsculas, quitar tildes). | Evitar errores de compatibilidad en nombres de carpetas y bases de datos. | *"Aplica un `format` para que todas las entradas de nombres de usuarios se guarden con la primera letra de cada palabra en mayúscula."* |
| **Atributos de Usuario** | Variables predefinidas que contienen datos del usuario activo (ej. `{user_name}`, `{first_name}`, `{last_name}`, `{role}`, `{country}`, `{institution}`, `{course}`, `{date}`, `{id}`). | Personalizar interfaces de usuario o generar reportes automáticos dirigidos. | *"Genera una bienvenida personalizada en pantalla que use los atributos `{first_name}` y `{role}` del usuario logueado."* |
| **`fallback`** | Un valor o acción de respaldo que se activa si la variable principal no tiene datos o no está disponible. | Evitar que una pantalla muestre un espacio vacío o un error si falta un dato secundario. | *"Si el docente no ha subido su foto de perfil, usa una imagen genérica de usuario como `fallback`."* |
| **`slugify`** | Proceso de convertir un texto en una cadena amigable para URL (ej. pasar a minúsculas, remover caracteres especiales, tildes y cambiar espacios por guiones medios). | Generar rutas web seguras o nombres de archivos web autogestionados. | *"Aplica `slugify` al título de la lección para generar su dirección web. Ejemplo: 'Introducción a la Biomecánica' debe quedar 'introduccion-a-la-biomecanica'."* |

---

## 4. Estructura de Datos, Jerarquías y Anidación

Comprender cómo se organizan los niveles de información es fundamental para que la IA diseñe bases de datos lógicas y árboles de navegación consistentes.

```text
Estructura Jerárquica Típica:
Carrera (Padre / Parent)
 └── Curso (Hijo / Child / Anidado)
      └── Sección (Hijo de Curso / Anidado)
           └── Docente (Asociado / Agregación)
```

| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`parent` (Padre)** | El nivel o entidad superior que contiene o controla a otras entidades dependientes. | Estructurar menús jerárquicos o llaves en bases de datos. | *"Define que la entidad 'Facultad' sea el `parent` de la entidad 'Carrera'."* |
| **`child` (Hijo)** | Entidad o elemento subordinado que depende directamente de un elemento superior o padre. | Eliminar automáticamente elementos dependientes si se borra el padre. | *"Si se elimina un Curso, asegúrate de borrar en cascada todas las Secciones que sean sus `child`."* |
| **`nested` (Anidado)** | Indica que un objeto está metido o definido dentro del cuerpo de otro objeto de datos o componente de interfaz. | Estructuras JSON jerárquicas o menús visuales de árbol. | *"Devuelve una estructura JSON donde el listado de calificaciones de los estudiantes esté `nested` dentro de cada Sección."* |
| **`hierarchy` (Jerarquía)** | La estructura completa organizada por niveles de importancia o contención de los datos. | Modelar la arquitectura del software. | *"Crea una `hierarchy` para el sistema escolar de tres niveles: Institución -> Asignatura -> Evaluaciones."* |
| **`relationship` (Relación)** | Asociación lógica establecida entre dos o más tablas o entidades de datos. | Conectar información (ej. saber qué alumnos pertenecen a qué sección). | *"Establece una `relationship` de muchos a muchos entre los estudiantes y los cursos electivos."* |
| **`composition` (Composición)** | Relación fuerte de pertenencia donde el elemento hijo no tiene sentido de existir si el padre desaparece (ej. una Pregunta es parte de un Examen específico). | Diseño estricto de bases de datos y borrados automáticos. | *"Usa una relación de `composition` para las secciones: si el curso se elimina, las secciones deben desaparecer por completo."* |
| **`aggregation` (Agregación)** | Relación débil de asociación donde el elemento dependiente puede seguir existiendo de forma independiente aunque su contenedor se elimine (ej. un Docente asignado a un Curso). | Asignación de recursos reutilizables. | *"El docente se asocia al curso por `aggregation`: si el curso se elimina, la cuenta del docente debe permanecer intacta en el sistema."* |

---

## 5. Modelos de Datos y Catálogos

Los catálogos y tipos de definición determinan quién tiene el control para modificar o agregar datos en las opciones del sistema.

| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`enumeration` (Enum)** | Una lista estática y predefinida de valores mutuamente excluyentes escrita directamente en el código del software. | Estados del sistema, roles del usuario, días de la semana. | *"Usa una `enumeration` para definir el tipo de pregunta: 'Alternativa', 'Desarrollo' y 'VerdaderoFalso'."* |
| **`system_defined`** | Valores fijos configurados por el sistema desde su construcción que el usuario final no puede editar ni borrar. | Parámetros del sistema base, códigos de país estándar. | *"El tipo de institución debe ser un catálogo `system_defined` para mantener consistencia en los reportes del gobierno."* |
| **`user_defined`** | Datos o campos creados completamente a voluntad y criterio por el usuario final de la aplicación. | Etiquetas de búsqueda de preguntas creadas por profesores, nombres de tareas. | *"Permite que las etiquetas de los temas del examen sean creadas libremente por el profesor en un formato `user_defined`."* |
| **`system_defined_editable`** | Catálogo que viene con valores de fábrica predefinidos por el sistema, pero que el usuario tiene el permiso de modificar, añadir nuevos o borrar. | Lista de escalas de notas preconfiguradas, taxonomías de evaluación por defecto. | *"Diseña la taxonomía de habilidades cognitivas como un catálogo `system_defined_editable` para que cada colegio adapte los nombres si lo desea."* |
| **`derived` (Derivado)** | Datos calculados dinámicamente en tiempo real a partir de otros datos existentes, sin almacenarse permanentemente en la base de datos. | Calcular la nota final promediando las evaluaciones, calcular la edad a partir de la fecha de nacimiento. | *"El campo 'Promedio de Asistencia' debe ser un atributo `derived` que se calcule dinámicamente sumando las firmas mensuales."* |

---

## 6. Persistencia y Flujos de Guardado

Determina cómo, cuándo y de qué manera se salvan los datos del usuario en la base de datos para evitar la pérdida de información.

| Término | Descripción Técnica | Uso Típico en UI / LMS | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **`autosave`** | Mecanismo que guarda cambios automáticamente en segundo plano ante ciertos eventos (como `onBlur` o cada ciertos segundos) sin interrumpir al usuario. | Editores de texto en línea, formularios largos de evaluación. | *"Implementa un temporizador de `autosave` que guarde las respuestas de la prueba cada 60 segundos automáticamente."* |
| **`manual_save`** | Mecanismo que requiere que el usuario haga clic explícito en un control de la interfaz (como un botón 'Guardar') para almacenar los datos. | Envío de transacciones, confirmación final de exámenes. | *"Usa un flujo de `manual_save` para la entrega del examen, asegurándote de solicitar una doble confirmación al alumno."* |
| **`draft_state`** | Estado temporal que indica que un documento o formulario está en modo borrador y sus cambios no han sido publicados o validados definitivamente. | Creación de preguntas, preparación de evaluaciones por parte del profesor. | *"Permite guardar las preguntas en un `draft_state` para que el profesor pueda editarlas más tarde antes de publicarlas en el banco."* |
| **`persistence`** | La propiedad de los datos de sobrevivir a lo largo del tiempo, permaneciendo almacenados de forma estable tras apagar la aplicación o el dispositivo. | Guardar perfiles de usuario, calificaciones históricas y configuraciones base. | *"Asegura la `persistence` de los datos guardando la configuración del tema visual en el almacenamiento local del navegador (LocalStorage)."* |
| **`import`** | Proceso de leer un archivo externo (como Excel, CSV o JSON) e incorporar su estructura y datos dentro de la base de datos de la aplicación. | Carga masiva de alumnos, carga de un banco de preguntas desde un archivo externo. | *"Diseña una interfaz para `import` que lea un archivo Excel y registre automáticamente la lista de estudiantes de la sección."* |
| **`export`** | Proceso de extraer datos del sistema y estructurarlos en un archivo descargable (como PDF, Excel o JSON) para su uso fuera de la aplicación. | Generar actas de notas descargables, respaldar bancos de preguntas. | *"Crea un botón para `export` el banco de preguntas completo en un archivo estructurado en formato JSON."* |

---

## 7. Entidades y Estructuras del Dominio Educativo / LMS

Conceptos de estructuración y lógicas del negocio orientadas a sistemas escolares y generadores de evaluaciones automáticas, como los gestionados en el proyecto `kinepipe-edc`.

| Término | Descripción Técnica | Uso Típico en kinepipe-edc | Ejemplo de Prompt para la IA |
| :--- | :--- | :--- | :--- |
| **Curso** | Entidad raíz que representa una materia o asignatura académica (ej. Biomecánica). | Almacenar datos descriptivos, competencias e indicadores curriculares. | *"Define la entidad 'Curso' de modo que contenga la malla de contenidos dividida en unidades temáticas."* |
| **Sección** | Subdivisión administrativa y práctica de un Curso para un grupo de alumnos específicos. | Asignar docentes y gestionar horarios específicos. | *"Establece que una sección pertenezca obligatoriamente a un curso padre, pero que pueda tener docentes independientes."* |
| **Docente** | Entidad de usuario con rol de profesor o instructor con permisos de edición y evaluación. | Asignar a secciones específicas de teoría o laboratorio. | *"Asigna docentes a secciones de laboratorios de manera dinámica mediante una tabla de relaciones intermedias."* |
| **Banco de Preguntas** | Módulo de base de datos indexado que recopila preguntas evaluativas ordenadas por metadatos (tipo de pregunta, contenidos, puntaje, taxonomía). | Filtrar y seleccionar reactivos para construir exámenes. | *"Diseña un motor de búsqueda dentro del Banco de Preguntas que filtre por nivel taxonómico y tiempo estimado de resolución."* |
| **Editor de Preguntas** | La interfaz de usuario especializada encargada de la creación de las preguntas individuales con sus respectivas pautas de corrección. | Diseñar flujos interactivos para formular preguntas de selección múltiple, desarrollo, verdadero/falso, etc. | *"Crea un editor de preguntas que permita al usuario añadir retroalimentación específica para cada alternativa incorrecta."* |
| **Diseño de Matrices** | Estructuras curriculares o plantillas técnicas que definen cuántas preguntas de cada tema y nivel de dificultad debe tener una prueba. | Automatizar la generación de exámenes balanceados y válidos. | *"Genera una matriz de evaluación que extraiga del banco 5 preguntas de nivel bajo, 10 de nivel medio y 5 de nivel alto."* |
| **Evaluaciones** | La estructura de un examen o prueba final, dividida en diseño institucional (portada, logos) e instruccional (diagramación y tipos de preguntas). | Generar el documento final para los estudiantes. | *"Crea un modelo para Evaluaciones que separe el diseño visual de la portada (logos e instrucciones) de la lista de preguntas."* |
| **Impresión** | Módulo encargado de convertir las evaluaciones en formato PDF imprimible, controlando la aleatorización y generación de formas alternativas (Fila A, Fila B). | Controlar la generación física de los exámenes. | *"Configura el módulo de impresión para que genere tres versiones del examen con el orden de las preguntas aleatorizado."* |

---

## Referencias Web para Conocer Más

Para profundizar en los estándares técnicos que rigen el diseño de software interactivo y la construcción de sistemas educativos, te recomendamos explorar los siguientes sitios:

1. **[MDN Web Docs (Mozilla Developer Network)](https://developer.mozilla.org)** - Excelente punto de partida para estudiar eventos, estados e interacciones web con explicaciones completas y código de muestra interactivo.
2. **[Refactoring.Guru](https://refactoring.guru/es)** - Un portal visualmente atractivo e ilustrado dedicado a la explicación simple de patrones de arquitectura de software y metodologías de refactorización limpia.
3. **[The Agent Skills Directory](https://www.skills.sh)** - Registro centralizado para conocer estándares de desarrollo de habilidades y directrices para agentes autónomos.
4. **[W3Schools UI Design Tutorial](https://www.w3schools.com)** - Tutoriales interactivos sumamente accesibles para dar los primeros pasos en el maquetado y eventos de interfaces web.
5. **[ECC Tools - Harness Automation](https://ecc.tools)** - Documentación sobre automatización abierta y pruebas de flujo seguro para integraciones con agentes e IA en entornos de código compartido.
