--
-- Class AsignaturaSolicitada as table asignatura_solicitada
--

CREATE TABLE "asignatura_solicitada" (
  "id" serial,
  "asignatura" json,
  "comision" json,
  "idUsuarioPendiente" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "asignatura_solicitada"
  ADD CONSTRAINT asignatura_solicitada_pkey PRIMARY KEY (id);


--
-- Class Asignatura as table asignaturas
--

CREATE TABLE "asignaturas" (
  "id" serial,
  "nombre" text NOT NULL,
  "idCurso" json,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone,
  "usuarios" json
);

ALTER TABLE ONLY "asignaturas"
  ADD CONSTRAINT asignaturas_pkey PRIMARY KEY (id);


--
-- Class AsistenciaDiaria as table asistencias_diarias
--

CREATE TABLE "asistencias_diarias" (
  "id" serial,
  "estudiante" json,
  "comision" json,
  "estadoDeAsistencia" integer NOT NULL,
  "fecha" timestamp without time zone NOT NULL,
  "idJustificacion" integer,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "asistencias_diarias"
  ADD CONSTRAINT asistencias_diarias_pkey PRIMARY KEY (id);


--
-- Class Calificacion as table calificaciones
--

CREATE TABLE "calificaciones" (
  "id" serial,
  "idAutor" integer NOT NULL,
  "estudiante" json,
  "idComision" integer NOT NULL,
  "idAsignatura" integer NOT NULL,
  "idInstanciaDeEvaluacion" integer NOT NULL,
  "tipoCalificacion" integer NOT NULL,
  "index" integer NOT NULL,
  "diferencial" text NOT NULL,
  "observacion" text,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "calificaciones"
  ADD CONSTRAINT calificaciones_pkey PRIMARY KEY (id);


--
-- Class CalificacionMensual as table calificaciones_mensuales
--

CREATE TABLE "calificaciones_mensuales" (
  "id" serial,
  "calificacion" json,
  "numeroDeMes" integer NOT NULL
);

ALTER TABLE ONLY "calificaciones_mensuales"
  ADD CONSTRAINT calificaciones_mensuales_pkey PRIMARY KEY (id);


--
-- Class ComisionDeCurso as table comisiones
--

CREATE TABLE "comisiones" (
  "id" serial,
  "nombre" text NOT NULL,
  "curso" json,
  "anioLectivo" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone,
  "estudiantes" json,
  "solicitudesCalificacionMensual" json
);

ALTER TABLE ONLY "comisiones"
  ADD CONSTRAINT comisiones_pkey PRIMARY KEY (id);


--
-- Class ConceptoCalificacion as table conceptos_calificacion
--

CREATE TABLE "conceptos_calificacion" (
  "id" serial,
  "concepto" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "conceptos_calificacion"
  ADD CONSTRAINT conceptos_calificacion_pkey PRIMARY KEY (id);


--
-- Class Curso as table cursos
--

CREATE TABLE "cursos" (
  "id" serial,
  "nombre" text NOT NULL,
  "asignaturas" json,
  "comisiones" json,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "cursos"
  ADD CONSTRAINT cursos_pkey PRIMARY KEY (id);


--
-- Class DireccionDeEmail as table direcciones_de_email
--

CREATE TABLE "direcciones_de_email" (
  "id" serial,
  "usuario" json,
  "direccionDeEmail" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "direcciones_de_email"
  ADD CONSTRAINT direcciones_de_email_pkey PRIMARY KEY (id);


--
-- Class DireccionDeEmailInstitucion as table direcciones_de_email_institucion
--

CREATE TABLE "direcciones_de_email_institucion" (
  "id" serial,
  "idInstitucion" integer NOT NULL,
  "direccionDeEmail" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "direcciones_de_email_institucion"
  ADD CONSTRAINT direcciones_de_email_institucion_pkey PRIMARY KEY (id);


--
-- Class DomicilioDeInstitucion as table domicilios_de_institucion
--

CREATE TABLE "domicilios_de_institucion" (
  "id" serial,
  "idInstitucion" integer NOT NULL,
  "calle" text NOT NULL,
  "numero" integer NOT NULL,
  "idCodigoPostal" integer NOT NULL,
  "idCiudad" integer NOT NULL,
  "idProvincia" integer NOT NULL
);

ALTER TABLE ONLY "domicilios_de_institucion"
  ADD CONSTRAINT domicilios_de_institucion_pkey PRIMARY KEY (id);


--
-- Class DomicilioDeUsuario as table domicilios_de_usuario
--

CREATE TABLE "domicilios_de_usuario" (
  "id" serial,
  "idUsuario" integer NOT NULL,
  "calle" text NOT NULL,
  "numero" integer NOT NULL,
  "idCodigoPostal" integer NOT NULL,
  "idCiudad" integer NOT NULL,
  "idProvincia" integer NOT NULL
);

ALTER TABLE ONLY "domicilios_de_usuario"
  ADD CONSTRAINT domicilios_de_usuario_pkey PRIMARY KEY (id);


--
-- Class EvaluacionDeAsignatura as table evaluaciones_de_asignatura
--

CREATE TABLE "evaluaciones_de_asignatura" (
  "id" serial,
  "idInstanciaDeEvaluacion" integer NOT NULL,
  "idComision" integer NOT NULL,
  "idAsignatura" integer NOT NULL
);

ALTER TABLE ONLY "evaluaciones_de_asignatura"
  ADD CONSTRAINT evaluaciones_de_asignatura_pkey PRIMARY KEY (id);


--
-- Class EvaluacionDeCompensacion as table evaluaciones_de_compensacion
--

CREATE TABLE "evaluaciones_de_compensacion" (
  "id" serial,
  "idInstanciaDeEvaluacion" integer NOT NULL,
  "idAsignatura" integer NOT NULL
);

ALTER TABLE ONLY "evaluaciones_de_compensacion"
  ADD CONSTRAINT evaluaciones_de_compensacion_pkey PRIMARY KEY (id);


--
-- Class InstanciaDeEvaluacion as table instancias_de_evaluacion
--

CREATE TABLE "instancias_de_evaluacion" (
  "id" serial,
  "nombre" text NOT NULL,
  "descripcion" text NOT NULL,
  "autor" integer NOT NULL,
  "idConcepto" integer NOT NULL,
  "fechaProgramada" timestamp without time zone NOT NULL,
  "fechaDeRealizacion" timestamp without time zone,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "instancias_de_evaluacion"
  ADD CONSTRAINT instancias_de_evaluacion_pkey PRIMARY KEY (id);


--
-- Class Institucion as table instituciones
--

CREATE TABLE "instituciones" (
  "id" serial,
  "nombre" text NOT NULL,
  "tipo" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "instituciones"
  ADD CONSTRAINT instituciones_pkey PRIMARY KEY (id);


--
-- Class JustificacionDeAsistencia as table justificaciones_de_asistencia
--

CREATE TABLE "justificaciones_de_asistencia" (
  "id" serial,
  "idAsistencia" integer NOT NULL,
  "observaciones" text NOT NULL,
  "adjunto" text,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "justificaciones_de_asistencia"
  ADD CONSTRAINT justificaciones_de_asistencia_pkey PRIMARY KEY (id);


--
-- Class LlamadoCompensacion as table llamados_compensacion
--

CREATE TABLE "llamados_compensacion" (
  "id" serial,
  "fechaLlamado" timestamp without time zone NOT NULL,
  "fechaRealizacion" timestamp without time zone,
  "idAsignatura" integer NOT NULL,
  "observaciones" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "llamados_compensacion"
  ADD CONSTRAINT llamados_compensacion_pkey PRIMARY KEY (id);


--
-- Class NumeroDeTelefono as table numeros_de_telefono
--

CREATE TABLE "numeros_de_telefono" (
  "id" serial,
  "numeroDeTelefono" text NOT NULL,
  "tipoDeTelefono" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "numeros_de_telefono"
  ADD CONSTRAINT numeros_de_telefono_pkey PRIMARY KEY (id);


--
-- Class NumeroDeTelefonoInstitucion as table numeros_de_telefono_institucion
--

CREATE TABLE "numeros_de_telefono_institucion" (
  "id" serial,
  "idinstitucion" integer NOT NULL,
  "numeroDeTelefono" text NOT NULL,
  "tipoDeTelefono" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "numeros_de_telefono_institucion"
  ADD CONSTRAINT numeros_de_telefono_institucion_pkey PRIMARY KEY (id);


--
-- Class Periodo as table periodos
--

CREATE TABLE "periodos" (
  "id" serial,
  "fechaInicio" timestamp without time zone NOT NULL,
  "fechaFin" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "periodos"
  ADD CONSTRAINT periodos_pkey PRIMARY KEY (id);


--
-- Class RelacionAsignaturaCurso as table r_asignatura_curso
--

CREATE TABLE "r_asignatura_curso" (
  "id" serial,
  "idAsignatura" integer NOT NULL,
  "idCurso" integer NOT NULL,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "r_asignatura_curso"
  ADD CONSTRAINT r_asignatura_curso_pkey PRIMARY KEY (id);


--
-- Class RelacionAsignaturaUsuario as table r_asignaturas_usuarios
--

CREATE TABLE "r_asignaturas_usuarios" (
  "id" serial,
  "usuario" json,
  "asignatura" json,
  "comision" json,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "r_asignaturas_usuarios"
  ADD CONSTRAINT r_asignaturas_usuarios_pkey PRIMARY KEY (id);



--
-- Class RelacionComisionUsuario as table r_comisiones_usuarios
--

CREATE TABLE "r_comisiones_usuarios" (
  "id" serial,
  "usuario" json,
  "comision" json
);

ALTER TABLE ONLY "r_comisiones_usuarios"
  ADD CONSTRAINT r_comisiones_usuarios_pkey PRIMARY KEY (id);



--
-- Class Solicitud as table solicitudes
--

CREATE TABLE "solicitudes" (
  "id" serial,
  "tipoSolicitud" integer NOT NULL,
  "idAutor" integer NOT NULL,
  "idDestinatario" integer NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaRealizacion" timestamp without time zone,
  "fechaVisto" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "solicitudes"
  ADD CONSTRAINT solicitudes_pkey PRIMARY KEY (id);


--
-- Class SolicitudCalificacionMensual as table solicitudes_calificaciones_mensuales
--

CREATE TABLE "solicitudes_calificaciones_mensuales" (
  "id" serial,
  "solicitud" json,
  "comision" json,
  "idAsignatura" integer NOT NULL,
  "mes" integer NOT NULL,
  "anio" integer NOT NULL,
  "calificaciones" json
);

ALTER TABLE ONLY "solicitudes_calificaciones_mensuales"
  ADD CONSTRAINT solicitudes_calificaciones_mensuales_pkey PRIMARY KEY (id);


--
-- Class Usuario as table usuarios
--

CREATE TABLE "usuarios" (
  "id" serial,
  "idUserInfo" integer NOT NULL,
  "nombre" text NOT NULL,
  "apellido" text NOT NULL,
  "urlFotoDePerfil" text NOT NULL,
  "dni" text,
  "domicilio" json,
  "direccionesDeEmail" json,
  "numerosDeTelefono" json,
  "roles" json,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone,
  "comisiones" json,
  "asignaturas" json,
  "privileges" text
);

ALTER TABLE ONLY "usuarios"
  ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);



--
-- Class UsuarioPendiente as table usuarios_pendientes
--

CREATE TABLE "usuarios_pendientes" (
  "id" serial,
  "idUserInfo" integer NOT NULL,
  "nombre" text NOT NULL,
  "apellido" text NOT NULL,
  "urlFotoDePerfil" text NOT NULL,
  "dni" text,
  "idRolSolicitado" integer NOT NULL,
  "estadoDeSolicitud" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone,
  "asignaturasSolicitadas" json,
  "comisionSolicitada" json
);

ALTER TABLE ONLY "usuarios_pendientes"
  ADD CONSTRAINT usuarios_pendientes_pkey PRIMARY KEY (id);


