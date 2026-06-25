---
title: "Checklist para iniciar el desarrollo de una EDC basada en IA agentica"
document_type: "researcher_checklist"
language: "es-419"
status: "publication_draft"
version: "1.0"
date: "2026-06-25"
intended_use: "Guia extensiva para investigadores que planifican sistemas de captura electronica de datos clinicos asistidos por IA agentica."
audience:
  - "Investigadores clinicos"
  - "Equipos de informatica medica"
  - "Coordinadores de estudios"
  - "Equipos de desarrollo y validacion"
keywords:
  - "EDC"
  - "IA agentica"
  - "captura de datos clinicos"
  - "informatica medica"
  - "human-in-the-loop"
---

# Checklist para iniciar el desarrollo de una EDC basada en IA agentica

## Proposito

Este checklist esta disenado para apoyar a investigadores y equipos de informatica medica antes de iniciar el desarrollo de una aplicacion de captura electronica de datos clinicos (EDC) asistida por IA agentica. Su objetivo es convertir decisiones implicitas en criterios explicitos, revisables y trazables.

Debe entenderse como una guia metodologica para planificacion, no como una certificacion tecnica, regulatoria, etica o clinica. Cada punto debe adaptarse segun las necesidades del estudio, la normativa local, el tipo de datos, los recursos disponibles y el nivel de riesgo del proyecto.

## Como usar este checklist

- [ ] Completar primero los datos generales del proyecto.
- [ ] Revisar cada seccion antes de iniciar el desarrollo.
- [ ] Marcar como pendiente todo punto que requiera decision institucional, tecnica o clinica.
- [ ] Registrar responsables y evidencia de cumplimiento cuando sea necesario.
- [ ] Repetir la revision cuando cambien el protocolo, el flujo clinico, el modelo de datos, la plataforma tecnologica o las reglas del agente.

## Datos generales del proyecto

- [ ] Nombre del proyecto o estudio: **[COMPLETAR]**
- [ ] Institucion o equipo responsable: **[COMPLETAR]**
- [ ] Investigador/a principal o responsable metodologico: **[COMPLETAR]**
- [ ] Responsable tecnico: **[COMPLETAR]**
- [ ] Fecha de inicio de planificacion: **[COMPLETAR]**
- [ ] Version del checklist: **[COMPLETAR]**
- [ ] Alcance esperado de la EDC: **[COMPLETAR]**
- [ ] Poblacion, entorno clinico o contexto de uso: **[COMPLETAR]**

## A. Planificacion general

- [ ] Definir claramente el objetivo clinico, operativo o investigativo que resolvera la aplicacion.
- [ ] Describir los flujos de trabajo que la EDC debe apoyar, reemplazar o mejorar.
- [ ] Identificar a los usuarios finales: investigadores, clinicos, pacientes, evaluadores, monitores, administradores u otros.
- [ ] Describir las necesidades principales de cada tipo de usuario.
- [ ] Definir criterios minimos de funcionamiento antes de iniciar el desarrollo.
- [ ] Definir que elementos pertenecen al producto minimo viable y que elementos quedaran para fases posteriores.
- [ ] Identificar restricciones institucionales, regulatorias, logisticas o presupuestarias.
- [ ] Definir como se documentaran las decisiones relevantes durante el desarrollo.

**Personalizar segun necesidades:** tipo de estudio, numero de centros, complejidad del flujo clinico, nivel de automatizacion deseado, disponibilidad de usuarios para validacion y exigencias del comite etico o institucion.

## B. Reglas del agente y contexto de desarrollo

- [ ] Definir reglas permanentes para guiar a la IA durante el desarrollo.
- [ ] Documentar si se usaran skills, instrucciones operativas, prompts base, reglas del repositorio u otros mecanismos de guia.
- [ ] Seleccionar y documentar habilidades reutilizables existentes, si aplica.
- [ ] Identificar reglas nuevas que deban desarrollarse especificamente para el proyecto.
- [ ] Declarar el nivel de conocimientos tecnicos del equipo investigador para ajustar el tipo de instrucciones.
- [ ] Solicitar instrucciones paso a paso cuando existan procedimientos manuales, criticos o potencialmente riesgosos.
- [ ] Definir que tareas puede proponer la IA y cuales requieren autorizacion humana explicita.
- [ ] Definir como se revisaran los resultados generados por la IA antes de incorporarlos al proyecto.

**Personalizar segun necesidades:** experiencia tecnica del equipo, herramientas de IA disponibles, politicas institucionales sobre IA, idioma de trabajo, profundidad de supervision humana y nivel de autonomia permitido.

## C. Entorno tecnologico

- [ ] Definir la plataforma objetivo: web, Android, iOS, Windows, aplicacion hibrida, aplicacion de escritorio u otra.
- [ ] Especificar el sistema operativo de desarrollo.
- [ ] Registrar versiones de Python, Node.js, Java, Android SDK, Gradle u otras dependencias relevantes.
- [ ] Identificar herramientas externas requeridas para desarrollo, pruebas, despliegue o documentacion.
- [ ] Definir idioma principal de la interfaz y de la documentacion.
- [ ] Definir codificacion de caracteres y reglas para nombres de archivos.
- [ ] Definir formatos regionales: separador decimal, fecha, hora, unidades y zona horaria.
- [ ] Evaluar si el sistema requerira internacionalizacion o soporte multilingue.
- [ ] Registrar limitaciones del entorno local, institucional o de conectividad.

**Personalizar segun necesidades:** infraestructura institucional, dispositivos disponibles, conectividad de campo, requisitos de interoperabilidad y herramientas aprobadas por la organizacion.

## D. Arquitectura del sistema

- [ ] Documentar la arquitectura general antes de comenzar el desarrollo.
- [ ] Mantener la documentacion tecnica accesible para el equipo y para la IA.
- [ ] Definir la estructura de directorios del proyecto.
- [ ] Documentar tecnologias, librerias y frameworks seleccionados.
- [ ] Identificar servicios externos, APIs, bases de datos o sistemas institucionales.
- [ ] Documentar los flujos principales de datos.
- [ ] Registrar dependencias criticas y su funcion dentro del sistema.
- [ ] Definir contratos de intercambio de datos, por ejemplo JSON, CSV, HL7 FHIR u otros.
- [ ] Separar claramente frontend, backend, persistencia, servicios externos y logica clinica.
- [ ] Definir que componentes deben poder reemplazarse sin comprometer todo el sistema.

**Personalizar segun necesidades:** complejidad del proyecto, uso offline, integracion con sistemas clinicos, regulaciones de datos y capacidad tecnica del equipo.

## E. Modelo de datos

- [ ] Disenar los esquemas de datos antes de desarrollar la interfaz.
- [ ] Definir tipos de datos permitidos para cada variable.
- [ ] Establecer reglas de validacion para campos obligatorios, rangos, formatos y valores esperados.
- [ ] Definir identificadores unicos para pacientes, registros, visitas, sesiones o mediciones.
- [ ] Usar nomenclatura uniforme para variables, tablas, formularios y exportaciones.
- [ ] Definir formato de fechas, horas, zonas horarias y marcas temporales.
- [ ] Definir arquitectura de exportacion para analisis: CSV, JSON, XLSX u otro formato.
- [ ] Establecer convenciones para decimales, unidades de medida, codificacion y valores perdidos.
- [ ] Definir como se manejaran cambios del modelo de datos durante el estudio.
- [ ] Documentar diccionarios de datos, etiquetas, definiciones operativas y reglas derivadas.

**Personalizar segun necesidades:** plan estadistico, instrumentos clinicos, variables primarias, estandares de interoperabilidad, auditoria y requisitos de exportacion.

## F. Persistencia y seguridad

- [ ] Definir donde se almacenaran los datos: servidor institucional, Supabase, base local, nube privada u otra opcion.
- [ ] Definir si existira redundancia de datos.
- [ ] Establecer si la aplicacion necesitara funcionamiento offline.
- [ ] Definir reglas de sincronizacion automatica o manual.
- [ ] Definir mecanismos de recuperacion ante fallos.
- [ ] Identificar datos sensibles, datos personales y datos clinicos protegidos.
- [ ] Definir autenticacion y autorizacion por roles.
- [ ] Establecer politicas de acceso, registro de eventos y auditoria.
- [ ] Evaluar requerimientos de consentimiento informado, privacidad y regulacion local.
- [ ] Definir procedimientos para incidentes de seguridad o perdida de datos.

**Personalizar segun necesidades:** legislacion aplicable, politicas institucionales, sensibilidad de los datos, ubicacion geografica del almacenamiento y nivel de riesgo clinico.

## G. Estrategia de desarrollo

- [ ] Dividir el desarrollo en tareas pequenas, verificables e independientes.
- [ ] Priorizar un producto minimo viable antes de agregar funciones avanzadas.
- [ ] Validar cada modificacion antes de continuar con nuevas funciones.
- [ ] Evitar solicitudes amplias o ambiguas a la IA cuando se requiera precision tecnica.
- [ ] Registrar decisiones de diseno, alternativas descartadas y justificaciones.
- [ ] Mantener una lista de tareas pendientes, bloqueos y riesgos.
- [ ] Separar cambios funcionales, visuales, documentales y de infraestructura.
- [ ] Revisar periodicamente que el desarrollo siga alineado con el objetivo clinico.

**Personalizar segun necesidades:** disponibilidad del equipo, calendario del estudio, criterios de entrega, modalidad de trabajo y herramientas de gestion.

## H. Supervision humana y human-in-the-loop

- [ ] Definir responsables de supervisar las acciones de la IA.
- [ ] Revisar el codigo generado antes de incorporarlo a versiones estables.
- [ ] Validar que la logica clinica sea correcta y comprensible.
- [ ] Revisar la experiencia de usuario con usuarios representativos.
- [ ] Evaluar visibilidad, tamano de controles, navegacion, accesibilidad y usabilidad clinica.
- [ ] Definir que decisiones no pueden ser delegadas a la IA.
- [ ] Registrar discrepancias entre la recomendacion de la IA y la decision humana final.
- [ ] Establecer un proceso de revision para cambios que afecten datos clinicos o seguridad.

**Personalizar segun necesidades:** nivel de riesgo, experiencia del equipo, participacion de pacientes, supervision clinica y requisitos de auditoria.

## I. Estrategia de pruebas

- [ ] Definir un plan de pruebas antes de iniciar el desarrollo.
- [ ] Incluir escenarios normales de uso.
- [ ] Incluir escenarios adversos y condiciones de campo.
- [ ] Probar perdida de conexion a Internet.
- [ ] Probar perdida de conexion Bluetooth, si aplica.
- [ ] Probar suspension y reanudacion de la aplicacion.
- [ ] Probar orientacion de pantalla, bloqueo de pantalla y cambio de dispositivo.
- [ ] Probar bateria baja, brillo reducido e interrupciones del sistema operativo.
- [ ] Definir criterios objetivos de aceptacion.
- [ ] Registrar resultados de pruebas, errores encontrados y correcciones realizadas.
- [ ] Repetir pruebas despues de cambios que afecten datos, interfaz o sincronizacion.

**Personalizar segun necesidades:** dispositivos reales disponibles, entorno de uso, criticidad de los datos, conectividad esperada y condiciones del trabajo de campo.

## J. Trazabilidad y control de versiones

- [ ] Seleccionar una estrategia de control de versiones.
- [ ] Registrar la arquitectura inicial del sistema.
- [ ] Documentar cambios relevantes en codigo, datos, interfaz y reglas del agente.
- [ ] Registrar versiones desplegadas y fechas de entrega.
- [ ] Mantener historial de incidencias, correcciones y decisiones.
- [ ] Sincronizar la documentacion con el estado real del codigo.
- [ ] Definir convenciones para nombres de ramas, commits, releases y etiquetas.
- [ ] Asociar cambios relevantes con solicitudes, problemas o decisiones documentadas.

**Personalizar segun necesidades:** repositorio usado, politicas de publicacion, repositorios privados o publicos, integracion con DOI, Zenodo u otros sistemas de preservacion.

## K. Respaldo y recuperacion

- [ ] Definir frecuencia de respaldos.
- [ ] Respaldar codigo fuente.
- [ ] Respaldar base de datos o archivos de datos.
- [ ] Respaldar documentacion, configuraciones y archivos de despliegue.
- [ ] Mantener versiones funcionales estables identificables.
- [ ] Verificar periodicamente que la restauracion funciona.
- [ ] Definir responsables de respaldo y recuperacion.
- [ ] Documentar ubicacion, acceso y restricciones de cada respaldo.
- [ ] Definir procedimientos ante perdida de dispositivo, corrupcion de datos o error humano.

**Personalizar segun necesidades:** criticidad del estudio, volumen de datos, frecuencia de captura, politicas institucionales y capacidad de restauracion.

## L. Limitaciones operativas de la IA

- [ ] Identificar la plataforma de IA utilizada durante el desarrollo.
- [ ] Documentar limites de contexto, uso, costo, API, disponibilidad y modelo.
- [ ] Registrar versiones de modelos o herramientas cuando sea relevante.
- [ ] Definir alternativas si el servicio de IA no esta disponible.
- [ ] Evaluar impacto de planes gratuitos, freemium o cambios comerciales.
- [ ] Establecer que decisiones requieren revision humana aunque hayan sido generadas por IA.
- [ ] Registrar incertidumbres, supuestos y errores detectados en respuestas de IA.
- [ ] Definir como se actualizara el proyecto si cambian las capacidades del agente.

**Personalizar segun necesidades:** proveedor de IA, restricciones de privacidad, presupuesto, acceso institucional, dependencia tecnologica y tolerancia al riesgo.

## Cierre de preparacion

Antes de iniciar el desarrollo, el equipo deberia poder responder afirmativamente:

- [ ] El objetivo del sistema esta claramente definido.
- [ ] El modelo de datos inicial esta documentado.
- [ ] La arquitectura inicial esta documentada.
- [ ] Las reglas de uso de IA estan documentadas.
- [ ] Existen responsables humanos para supervision clinica, tecnica y metodologica.
- [ ] Existen criterios minimos de aceptacion.
- [ ] Existe una estrategia de pruebas.
- [ ] Existe una estrategia de respaldo.
- [ ] Existe trazabilidad suficiente para reconstruir decisiones relevantes.

## Nota para adaptacion

Este checklist puede ampliarse, reducirse o reorganizarse segun el tipo de investigacion, la madurez tecnologica del equipo, la sensibilidad de los datos y las exigencias regulatorias. Para mejores resultados, se recomienda reemplazar cada marcador **[COMPLETAR]** por informacion especifica del proyecto y agregar anexos tecnicos cuando existan decisiones que requieran mayor detalle.
