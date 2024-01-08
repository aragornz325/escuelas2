--
-- Class AsignaturaSolicitada as table asignatura_solicitada
--

CREATE TABLE "asignatura_solicitada" (
  "id" serial,
  "idAsignatura" integer NOT NULL,
  "idUsuarioPendiente" integer NOT NULL,
  "nombreAsignatura" text NOT NULL,
  "nombreCurso" text NOT NULL,
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
  "idCurso" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
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
  "idEstudiante" integer NOT NULL,
  "idAsignatura" integer NOT NULL,
  "idComision" integer NOT NULL,
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
  "idEstudiante" integer NOT NULL,
  "idComision" integer NOT NULL,
  "idAsignatura" integer NOT NULL,
  "idConcepto" integer NOT NULL,
  "tipoCalificacion" integer NOT NULL,
  "index" integer NOT NULL,
  "diferencial" text NOT NULL,
  "detalle" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "calificaciones"
  ADD CONSTRAINT calificaciones_pkey PRIMARY KEY (id);


--
-- Class ComisionSolicitada as table comision_solicitada
--

CREATE TABLE "comision_solicitada" (
  "id" serial,
  "idComision" integer NOT NULL,
  "idUsuarioPendiente" integer NOT NULL,
  "nombreComision" text NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "comision_solicitada"
  ADD CONSTRAINT comision_solicitada_pkey PRIMARY KEY (id);


--
-- Class ComisionDeCurso as table comisiones_de_curso
--

CREATE TABLE "comisiones_de_curso" (
  "id" serial,
  "nombre" text NOT NULL,
  "idCurso" integer NOT NULL,
  "anioLectivo" integer NOT NULL,
  "estudiantes" json NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone,
  "usuarios" json
);

ALTER TABLE ONLY "comisiones_de_curso"
  ADD CONSTRAINT comisiones_de_curso_pkey PRIMARY KEY (id);


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
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "cursos"
  ADD CONSTRAINT cursos_pkey PRIMARY KEY (id);


--
-- Class DireccionDeEmail as table direcciones_de_email
--

CREATE TABLE "direcciones_de_email" (
  "id" serial,
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
  "nombre" text NOT NULL,
  "diaInicio" integer NOT NULL,
  "mesInicio" integer NOT NULL,
  "diaFin" integer NOT NULL,
  "mesFin" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "periodos"
  ADD CONSTRAINT periodos_pkey PRIMARY KEY (id);


--
-- Class RelacionAsignaturaUsuario as table r_asignaturas_usuarios
--

CREATE TABLE "r_asignaturas_usuarios" (
  "id" serial,
  "usuario" json,
  "asignatura" json,
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
  "comisionDeCurso" json,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "r_comisiones_usuarios"
  ADD CONSTRAINT r_comisiones_usuarios_pkey PRIMARY KEY (id);



--
-- Class RelacionUsuarioRol as table r_usuario_rol
--

CREATE TABLE "r_usuario_rol" (
  "id" serial,
  "usuario" json,
  "rol" json
);

ALTER TABLE ONLY "r_usuario_rol"
  ADD CONSTRAINT r_usuario_rol_pkey PRIMARY KEY (id);



--
-- Class RolDeUsuario as table roles_de_usuario
--

CREATE TABLE "roles_de_usuario" (
  "id" serial,
  "nombre" text NOT NULL,
  "descripcion" text NOT NULL,
  "relacionesUsuarioRol" json,
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone
);

ALTER TABLE ONLY "roles_de_usuario"
  ADD CONSTRAINT roles_de_usuario_pkey PRIMARY KEY (id);


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
  "ultimaModificacion" timestamp without time zone NOT NULL,
  "fechaCreacion" timestamp without time zone NOT NULL,
  "fechaEliminacion" timestamp without time zone,
  "comisiones" json,
  "asignaturas" json
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
  "dni" text NOT NULL,
  "rolSolicitado" integer NOT NULL,
  "estadoDeSolicitud" integer NOT NULL,
  "ultimaModificacion" timestamp without time zone,
  "fechaCreacion" timestamp without time zone,
  "fechaEliminacion" timestamp without time zone,
  "asignaturasSolicitadas" json,
  "comisionSolicitada" json
);

ALTER TABLE ONLY "usuarios_pendientes"
  ADD CONSTRAINT usuarios_pendientes_pkey PRIMARY KEY (id);



