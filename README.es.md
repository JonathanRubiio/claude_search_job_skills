# OfferPilot

[English](README.md) · **Español**

Copiloto de búsqueda de empleo para desarrolladores de software, hecho como un conjunto de skills de [Claude Code](https://claude.com/claude-code). Arma tu perfil maestro, audita tu LinkedIn, encuentra y puntúa vacantes, adapta tu CV, llena formularios en **tu** Chrome con sesión iniciada, redacta mensajes y te prepara para entrevistas, todo registrado en un solo archivo de seguimiento.

Está afinado para **roles remotos de desarrollo en LATAM** (Get on Board, elempleo, Computrabajo, LinkedIn, Torre...), pero las skills y preferencias se pueden editar para cualquier mercado.

> **Borradores por defecto.** OfferPilot nunca envía, postula, conecta ni publica a menos que se lo ordenes en el chat para ese lote. Nunca escribe tus contraseñas, crea cuentas ni resuelve CAPTCHAs. Nunca inventa experiencia: toda afirmación debe salir de tu perfil.

---

## Qué necesitas

- [Claude Code](https://claude.com/claude-code) (CLI, app de escritorio o extensión de IDE).
- Google Chrome con la extensión **Claude in Chrome** (para leer portales y llenar formularios; las skills de perfil, CV y entrevistas funcionan sin ella).
- `git`, `bash` y `python3` (los hooks los usan). macOS o Linux; en Windows, con WSL.
- Tu CV (PDF o Word) y, idealmente, tus URLs de LinkedIn y GitHub.

## Inicio rápido

```bash
# 1. Descarga el proyecto
git clone https://github.com/JonathanRubiio/claude_search_job_skills.git
cd claude_search_job_skills

# 2. Crea tu espacio privado (./private, ignorado por git) desde las plantillas
./scripts/init.sh

# 3. Pon tu CV en inputs/
cp ~/Downloads/mi-cv.pdf inputs/

# 4. Abre Claude Code en esta carpeta
claude
```

Luego escribe **`empecemos`** o **`job hunt`** (la skill enrutadora lee tu estado y te dice qué sigue). Todo lo que está en `private/` (visible como `data/`, `inputs/` y `outputs/`) está en `.gitignore`: tus datos personales no salen de tu máquina.

## Paso a paso: de cero a entrevistas

### Primera vez: ¿sin CV y sin datos? Empieza aquí
Escribe `empecemos`. Con el espacio vacío, `job-hunt` ejecuta `profile-intake` en modo **arranque en frío**: unos 20-30 minutos de preguntas guiadas por bloques (quién y dónde, qué buscas, idiomas, cada trabajo con métricas, proyectos, educación, habilidades, brechas, datos de formularios). Las respuestas pueden ser aproximadas; lo que no sepas queda como `TODO` y nada se inventa. Las respuestas en bruto se guardan en `inputs/intake-answers.md`; luego escribe tu perfil, preferencias, datos de formularios y términos prohibidos, y arma un **CV base** (`outputs/base-cv.md`, PDF/Word opcional). Solo después pasa a LinkedIn, búsqueda y postulaciones.


| # | Paso | Tú dices | Qué pasa | Obtienes |
|---|------|----------|----------|----------|
| 1 | **Armar tu perfil** | "empecemos" / "carga mi CV" | `profile-intake` lee tu CV, LinkedIn y GitHub, pregunta las métricas que faltan (máx. 5 preguntas por ronda), lista brechas y conflictos con honestidad, y llena contigo `data/preferences.md` (roles, stack, piso salarial, deal-breakers, idioma). | `data/profile.md`, `data/preferences.md` |
| 2 | **Datos de formularios** | "llena form-data" | Ingresas una sola vez nombre, contacto, pretensión salarial y respuestas estándar. Los formularios los reutilizan. Agrega a `data/banned-terms.txt` lo que nunca debe aparecer en un documento (nombres de clientes, cargos); un hook lo bloquea. | `data/form-data.md`, `data/banned-terms.txt` |
| 3 | **Arreglar LinkedIn** | "audita mi LinkedIn" | `linkedin-audit` puntúa tu perfil sobre 100 y reescribe titular/Acerca de/Experiencia/Aptitudes usando solo tus hechos reales y palabras clave de vacantes reales. **Tú pegas los cambios**; la herramienta nunca edita tu perfil. | `outputs/linkedin-audit-<fecha>.md` |
| 4 | **Buscar vacantes** | "busca ofertas" | `job-discovery` busca en la web y en tu LinkedIn (solo lectura, bajo volumen), verifica cada oferta, quita duplicados y registra las que sobreviven en el tracker. | filas en `data/tracker.md` |
| 5 | **Medir el encaje** | pega URL/texto de una oferta | `job-fit` devuelve un puntaje 0-100 con evidencia, brechas y veredicto: postular / stretch / saltar / descartar. | recomendación + `vacancy.md` |
| 6 | **Adaptar el CV** | "arma el CV para esta" | `cv-tailor` redacta un CV compatible con ATS y una carta corta para esa vacante, más una tabla de palabras clave que muestra las brechas reales. | `outputs/<fecha>-<empresa>-<rol>/` |
| 7 | **Postular** | inicia sesión tú en el sitio y di "postula a estas vacantes" | `job-apply` revisa la compuerta (autorización, vacante abierta, encaje honesto, filtros duros, flujo completo leído antes, sin duplicados), llena el formulario con tus datos, envía, confirma la pantalla de éxito y lo registra. | postulaciones + filas en tracker |
| 8 | **Contactar** | "redacta mensaje al recruiter" | `outreach` redacta 2 variantes (directa / más cálida) de notas de conexión, DMs, pedidos de referido, seguimientos y agradecimientos. **Tú los envías.** | `outreach.md` |
| 9 | **Preparar entrevistas** | "tengo entrevista con X" | `interview-prep` arma el brief de la empresa, un plan por etapa, un banco de historias STAR, hace simulacro de entrevista pregunta por pregunta y un debrief. | `interview-prep.md`, `data/stories.md` |
| 10 | **Revisión semanal** | "qué sigue" / "estado" | `tracker` muestra seguimientos vencidos, postulaciones estancadas, conversión del embudo y el cuello de botella, con 1-3 acciones para la semana. | próximas acciones |

Cadencia sugerida: lunes descubrimiento + encaje, martes a jueves CV + mensajes + postulaciones, viernes revisión del tracker y entrevistas, y cada mes re-puntuar LinkedIn.

## Trazabilidad: no repetir, no perder el hilo
- `data/tracker.md`: estado actual de cada vacante.
- `data/applications-log.md`: línea con fecha, solo se agrega, por cada postulación enviada (empresa, rol, sitio, URL, pretensión, evidencia de la pantalla de éxito).
- `data/search-log.md`: línea con fecha, solo se agrega, por cada búsqueda (sitio, consulta, resultados, nuevas vs ya conocidas).

Antes de buscar, `job-discovery` lee los tres, excluye todo lo ya encontrado/postulado/descartado (incluida la misma oferta republicada con otra URL) y varía las consultas respecto a las ya hechas, de modo que cada sesión traiga solo vacantes **nuevas**. Tras cada postulación o búsqueda se escribe la bitácora correspondiente en el mismo turno.

## Las skills en detalle

Todas viven en `.claude/skills/<nombre>/SKILL.md` y Claude Code las invoca cuando tu pedido coincide (o por nombre).

### `job-hunt`: enrutador
Punto de entrada. Revisa el estado en orden (¿perfil vacío? ¿preferencias en blanco? ¿LinkedIn auditado? ¿tracker desactualizado? ¿preseleccionadas sin CV? ¿entrevistas pendientes? ¿acciones vencidas?) y deriva a la skill correcta. Responde corto: estado actual, siguiente paso recomendado y el único dato que necesita. Nunca hace el trabajo de un paso por sí mismo.

### `profile-intake`: perfil maestro
Lee CV (PDF/Word), LinkedIn y GitHub (solo lectura) y extrae identidad, habilidades (nivel 1-5, con evidencia para 4-5), experiencia, proyectos, educación e idiomas. Reconcilia conflictos entre fuentes en vez de elegir en silencio, pide la métrica detrás de cada viñeta vaga, registra brechas honestas y llena tus preferencias. Es la **única fuente de verdad**: todas las demás skills derivan de `data/profile.md`.

### `linkedin-audit`: reescritura de LinkedIn
Puntúa 8 áreas (titular, Acerca de, Experiencia, Aptitudes, palabras clave, Destacados, completitud/ajustes, tono) con `rubric.md`. Construye la base de palabras clave desde 10+ vacantes reales, ofrece 2-3 variantes de titular, reescribe las secciones débiles con viñetas `Verbo + qué + cómo + resultado` y entrega una lista de acciones priorizada y un checklist de ajustes (URL personalizada, Open to Work solo para reclutadores...). Se repite cada mes para comparar.

### `job-discovery`: encontrar vacantes
Arma 6-10 variantes de búsqueda (rol x stack x remoto x LATAM/worldwide/contractor), busca en portales y páginas ATS de empresas, y navega LinkedIn en **solo lectura** (máx. ~15 detalles por sesión, nunca pulsa Apply/Connect/Follow). Verifica cada oferta (sigue abierta, empresa real, el alcance remoto realmente incluye tu país, contrato, salario), marca señales de oferta fantasma y estafa, quita duplicados contra el tracker y limita el lote a ~20 ofertas verificadas.

### `job-fit`: puntaje de encaje
Aplica primero los filtros duros (deal-breakers, alcance remoto, piso salarial, stack a evitar) y luego puntúa cobertura de requisitos obligatorios (35), seniority (15), stack (15), logística (15), compensación (10) y calidad de la empresa (10). El análisis de brechas marca cada una como salvable o bloqueante. Veredictos: `apply` ≥ 75, `stretch` 60-74, `skip` < 60, `discard` por filtro duro.

### `cv-tailor`: CV y carta por vacante
Selecciona y reordena hechos reales del perfil para responder a las palabras clave de la vacante; formato ATS de una columna (1 página con menos de 8 años de experiencia); carta de menos de 200 palabras; tabla de palabras clave que muestra dónde aparece cada requisito y cuáles son brechas honestas (nunca se agregan). Exporta a .docx/.pdf. El idioma sigue a la vacante.

### `job-apply`: enviar postulaciones
Corre solo con tu orden explícita en el chat para ese lote. Compuerta de seis puntos (autorización, vacante verificada hoy, encaje honesto, filtros duros, flujo completo leído antes, sin duplicados). Usa el playbook del sitio, llena desde `data/form-data.md`, confirma la pantalla de éxito y registra `applied` con seguimiento a +7 días en el tracker. Nunca escribe credenciales/documentos, crea cuentas, resuelve CAPTCHAs ni ingresa datos de pago.

### `job-sites`: conocimiento por sitio
Un registro (estado de cada sitio: done / partial / untested / blocked, URLs de búsqueda) y un playbook por sitio: Get on Board, elempleo, Computrabajo, LinkedIn, Torre, Indeed, Hireline, Remotive, Magneto365, formularios ATS externos y lecciones de automatización de navegador comunes a todos. Después de usar un sitio, el playbook se actualiza para que la próxima vez sea más rápido. Copia `playbooks/_template.md` para agregar un sitio.

### `outreach`: mensajes (solo borradores)
Notas de conexión (≤ 200 caracteres), DMs a reclutadores/hiring managers (≤ 90 palabras), pedidos de referido, seguimientos (tras 5-7 días hábiles, máx. 2) y agradecimientos (en 24 h). Cada mensaje referencia algo específico; nada de envíos masivos. Tú copias y envías.

### `interview-prep`: prepararte
Brief de la empresa con fuentes, plan por etapa (screen con recruiter, técnica, comportamental, hiring manager), 15-25 temas técnicos probables ligados a tu experiencia real, banco de historias STAR, simulacro pregunta por pregunta con crítica, preguntas para hacerles y debrief posterior. Respuestas honestas del tipo "no he hecho X, tengo experiencia adyacente" en vez de inventadas.

### `tracker`: embudo
Mantiene `data/tracker.md` (`found` > `shortlisted` > `prepared` > `applied` > `screen` > `interview` > `offer` | `rejected` | `ghosted` | `discarded`). Muestra acciones vencidas, sugiere seguimiento a los 10 días, marca ghosted a los 21 (preguntando antes), calcula conversión del embudo y diagnostica el cuello de botella (¿descubrimiento? ¿CV? ¿pitch? ¿entrevistas?).

## Hooks automáticos (`.claude/hooks/`)

| Hook | Cuándo | Qué hace |
|------|--------|----------|
| `session-digest.sh` | al iniciar sesión | Imprime conteos del tracker, seguimientos vencidos y archivos de configuración faltantes |
| `guard-banned-terms.sh` | antes de Write/Edit | Bloquea entregables en `outputs/` que contengan algún término de `data/banned-terms.txt` |
| `tracker-lint.sh` | después de Write/Edit | Valida las filas del tracker (columnas, estado, fechas, IDs duplicados) |

## Estructura del proyecto

```
CLAUDE.md                 reglas duras para Claude en este proyecto
.claude/skills/           el sistema (10 skills + playbooks por sitio)
.claude/hooks/            resumen de sesión, guardia de términos, lint del tracker
templates/                archivos de datos en blanco para copiar a data/
private/     (git-ignored) todo lo personal; data/ inputs/ outputs/ son enlaces simbólicos a esta carpeta
data/        tu perfil, preferencias, tracker, historias, datos de formularios
inputs/      tu CV y material en bruto
outputs/     CVs, cartas, mensajes y preparación por vacante
```

## Reglas duras (ver `CLAUDE.md`)

1. Nada inventado ni inflado; toda afirmación sale de `data/profile.md`.
2. Sin enviar, postular ni conectar sin tu orden explícita en el chat; sin credenciales, cuentas ni CAPTCHAs.
3. LinkedIn en solo lectura y bajo volumen.
4. Sin git commit/push sin tu autorización explícita en ese momento.
5. Tus datos personales se quedan en este proyecto.
6. Playbooks y tracker se actualizan después de tocar cualquier sitio.
7. Los términos prohibidos nunca aparecen en los entregables.

## Uso responsable

Automatizar portales de empleo puede chocar con sus términos de servicio. Mantén el volumen bajo, usa tu propia sesión y revisa cada postulación antes de que salga. Tú eres responsable de lo que se envía a tu nombre. Los playbooks reflejan las interfaces al momento de escribirse y se desactualizan: corrígelos cuando un flujo cambie.

## Contribuir

Lo más útil son playbooks de sitios y mercados nuevos. Copia `.claude/skills/job-sites/playbooks/_template.md`, mantenlo libre de datos personales (referencia `data/form-data.md` en vez de valores) y agrega una fila a `registry.md`.

## Licencia

[MIT](LICENSE)
