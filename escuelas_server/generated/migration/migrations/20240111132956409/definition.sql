BEGIN;

--
-- Class AsignaturaSolicitada as table asignatura_solicitada
--
CREATE TABLE "asignatura_solicitada" (
    "id" serial PRIMARY KEY,
    "asignaturaId" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId" integer
);

--
-- Class Asignatura as table asignaturas
--
CREATE TABLE "asignaturas" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "cursoId" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone,
    "_cursosAsignaturasCursosId" integer
);

--
-- Class AsistenciaDiaria as table asistencias_diarias
--
CREATE TABLE "asistencias_diarias" (
    "id" serial PRIMARY KEY,
    "estudianteId" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "estadoDeAsistencia" integer NOT NULL,
    "fecha" timestamp without time zone NOT NULL,
    "idJustificacion" integer,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class Calificacion as table calificaciones
--
CREATE TABLE "calificaciones" (
    "id" serial PRIMARY KEY,
    "idAutor" integer NOT NULL,
    "idEstudiante" integer NOT NULL,
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

--
-- Class CalificacionMensual as table calificaciones_mensuales
--
CREATE TABLE "calificaciones_mensuales" (
    "id" serial PRIMARY KEY,
    "calificacionId" integer NOT NULL,
    "idCalificacion" integer NOT NULL,
    "numeroDeMes" integer NOT NULL,
    "_solicitudesNotasMensualesCalificacionesSolicitudesNotasMensualesId" integer
);

-- Indexes
CREATE UNIQUE INDEX "calificacion_calificacion_mensual_unique_idx" ON "calificaciones_mensuales" USING btree ("calificacionId");

--
-- Class ComisionSolicitada as table comision_solicitada
--
CREATE TABLE "comision_solicitada" (
    "id" serial PRIMARY KEY,
    "comisionId" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class ComisionDeCurso as table comisiones
--
CREATE TABLE "comisiones" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "cursoId" integer NOT NULL,
    "anioLectivo" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_cursosComisionesCursosId" integer
);

--
-- Class ConceptoCalificacion as table conceptos_calificacion
--
CREATE TABLE "conceptos_calificacion" (
    "id" serial PRIMARY KEY,
    "concepto" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class Curso as table cursos
--
CREATE TABLE "cursos" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class DireccionDeEmail as table direcciones_de_email
--
CREATE TABLE "direcciones_de_email" (
    "id" serial PRIMARY KEY,
    "direccionDeEmail" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_usuariosDireccionesdeemailUsuariosId" integer
);

--
-- Class DireccionDeEmailInstitucion as table direcciones_de_email_institucion
--
CREATE TABLE "direcciones_de_email_institucion" (
    "id" serial PRIMARY KEY,
    "idInstitucion" integer NOT NULL,
    "direccionDeEmail" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class DomicilioDeInstitucion as table domicilios_de_institucion
--
CREATE TABLE "domicilios_de_institucion" (
    "id" serial PRIMARY KEY,
    "idInstitucion" integer NOT NULL,
    "calle" text NOT NULL,
    "numero" integer NOT NULL,
    "idCodigoPostal" integer NOT NULL,
    "idCiudad" integer NOT NULL,
    "idProvincia" integer NOT NULL
);

--
-- Class DomicilioDeUsuario as table domicilios_de_usuario
--
CREATE TABLE "domicilios_de_usuario" (
    "id" serial PRIMARY KEY,
    "idUsuario" integer NOT NULL,
    "calle" text NOT NULL,
    "numero" integer NOT NULL,
    "idCodigoPostal" integer NOT NULL,
    "idCiudad" integer NOT NULL,
    "idProvincia" integer NOT NULL
);

--
-- Class EvaluacionDeAsignatura as table evaluaciones_de_asignatura
--
CREATE TABLE "evaluaciones_de_asignatura" (
    "id" serial PRIMARY KEY,
    "idInstanciaDeEvaluacion" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL
);

--
-- Class EvaluacionDeCompensacion as table evaluaciones_de_compensacion
--
CREATE TABLE "evaluaciones_de_compensacion" (
    "id" serial PRIMARY KEY,
    "idInstanciaDeEvaluacion" integer NOT NULL,
    "idAsignatura" integer NOT NULL
);

--
-- Class InstanciaDeEvaluacion as table instancias_de_evaluacion
--
CREATE TABLE "instancias_de_evaluacion" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "descripcion" text NOT NULL,
    "autor" integer NOT NULL,
    "idConcepto" integer NOT NULL,
    "fechaProgramada" timestamp without time zone NOT NULL,
    "fechaDeRealizacion" timestamp without time zone NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class Institucion as table instituciones
--
CREATE TABLE "instituciones" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "tipo" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class JustificacionDeAsistencia as table justificaciones_de_asistencia
--
CREATE TABLE "justificaciones_de_asistencia" (
    "id" serial PRIMARY KEY,
    "idAsistencia" integer NOT NULL,
    "observaciones" text NOT NULL,
    "adjunto" text,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class LlamadoCompensacion as table llamados_compensacion
--
CREATE TABLE "llamados_compensacion" (
    "id" serial PRIMARY KEY,
    "fechaLlamado" timestamp without time zone NOT NULL,
    "fechaRealizacion" timestamp without time zone,
    "idAsignatura" integer NOT NULL,
    "observaciones" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class NumeroDeTelefono as table numeros_de_telefono
--
CREATE TABLE "numeros_de_telefono" (
    "id" serial PRIMARY KEY,
    "numeroDeTelefono" text NOT NULL,
    "tipoDeTelefono" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_usuariosNumerosdetelefonoUsuariosId" integer
);

--
-- Class NumeroDeTelefonoInstitucion as table numeros_de_telefono_institucion
--
CREATE TABLE "numeros_de_telefono_institucion" (
    "id" serial PRIMARY KEY,
    "idinstitucion" integer NOT NULL,
    "numeroDeTelefono" text NOT NULL,
    "tipoDeTelefono" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class Periodo as table periodos
--
CREATE TABLE "periodos" (
    "id" serial PRIMARY KEY,
    "fechaInicio" timestamp without time zone NOT NULL,
    "fechaFin" timestamp without time zone NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class RelacionAsignaturaUsuario as table r_asignaturas_usuarios
--
CREATE TABLE "r_asignaturas_usuarios" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "asignaturaId" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_asignatura_index_idx" ON "r_asignaturas_usuarios" USING btree ("usuarioId", "asignaturaId");

--
-- Class RelacionComisionUsuario as table r_comisiones_usuarios
--
CREATE TABLE "r_comisiones_usuarios" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "comisionId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_comision_index_idx" ON "r_comisiones_usuarios" USING btree ("usuarioId", "comisionId");

--
-- Class RelacionUsuarioRol as table r_usuario_rol
--
CREATE TABLE "r_usuario_rol" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "rolId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_rol_index_idx" ON "r_usuario_rol" USING btree ("usuarioId", "rolId");

--
-- Class RolDeUsuario as table roles_de_usuario
--
CREATE TABLE "roles_de_usuario" (
    "id" serial PRIMARY KEY,
    "nombre" text NOT NULL,
    "descripcion" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class Solicitud as table solicitudes
--
CREATE TABLE "solicitudes" (
    "id" serial PRIMARY KEY,
    "tipoSolicitud" integer NOT NULL,
    "idAutor" integer NOT NULL,
    "idDestinatario" integer NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaRealizacion" timestamp without time zone,
    "fechaVisto" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- Class SolicitudNotaMensual as table solicitudes_notas_mensuales
--
CREATE TABLE "solicitudes_notas_mensuales" (
    "id" serial PRIMARY KEY,
    "idSolicitud" integer NOT NULL,
    "solicitudId" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "solicitud_solicitud_mensual_unique_idx" ON "solicitudes_notas_mensuales" USING btree ("solicitudId");

--
-- Class Usuario as table usuarios
--
CREATE TABLE "usuarios" (
    "id" serial PRIMARY KEY,
    "idUserInfo" integer NOT NULL,
    "nombre" text NOT NULL,
    "apellido" text NOT NULL,
    "urlFotoDePerfil" text NOT NULL,
    "dni" text,
    "domicilioId" integer,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "usuarios_domicilios_de_usuario_unique_idx" ON "usuarios" USING btree ("domicilioId");

--
-- Class UsuarioPendiente as table usuarios_pendientes
--
CREATE TABLE "usuarios_pendientes" (
    "id" serial PRIMARY KEY,
    "idUserInfo" integer NOT NULL,
    "nombre" text NOT NULL,
    "apellido" text NOT NULL,
    "urlFotoDePerfil" text NOT NULL,
    "dni" text,
    "rolSolicitado" integer NOT NULL,
    "estadoDeSolicitud" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone,
    "comisionSolicitadaId" integer
);

-- Indexes
CREATE UNIQUE INDEX "comision_solicitada_unique_idx" ON "usuarios_pendientes" USING btree ("comisionSolicitadaId");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" serial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" serial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" serial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" integer NOT NULL,
    "closing" integer NOT NULL,
    "idle" integer NOT NULL,
    "granularity" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" serial PRIMARY KEY,
    "sessionLogId" integer NOT NULL,
    "messageId" integer,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" integer NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" integer NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" serial PRIMARY KEY,
    "sessionLogId" integer NOT NULL,
    "serverId" text NOT NULL,
    "messageId" integer NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" integer NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" serial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" serial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" serial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" integer NOT NULL,
    "messageId" integer,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" integer,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" integer NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" serial PRIMARY KEY,
    "number" integer NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" serial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" serial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" integer,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" integer,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" serial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" serial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "version" integer NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" serial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text NOT NULL,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "asignatura_solicitada" table
--
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_0"
    FOREIGN KEY("asignaturaId")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_1"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_2"
    FOREIGN KEY("_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "asignaturas" table
--
ALTER TABLE ONLY "asignaturas"
    ADD CONSTRAINT "asignaturas_fk_0"
    FOREIGN KEY("cursoId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignaturas"
    ADD CONSTRAINT "asignaturas_fk_1"
    FOREIGN KEY("_cursosAsignaturasCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "asistencias_diarias" table
--
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_0"
    FOREIGN KEY("estudianteId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_2"
    FOREIGN KEY("idJustificacion")
    REFERENCES "justificaciones_de_asistencia"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "calificaciones" table
--
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_0"
    FOREIGN KEY("idAutor")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_1"
    FOREIGN KEY("idEstudiante")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_2"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_3"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_4"
    FOREIGN KEY("idInstanciaDeEvaluacion")
    REFERENCES "instancias_de_evaluacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "calificaciones_mensuales" table
--
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_0"
    FOREIGN KEY("calificacionId")
    REFERENCES "calificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("idCalificacion")
    REFERENCES "calificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_2"
    FOREIGN KEY("_solicitudesNotasMensualesCalificacionesSolicitudesNotasMensualesId")
    REFERENCES "solicitudes_notas_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "comision_solicitada" table
--
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_0"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_1"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "comisiones" table
--
ALTER TABLE ONLY "comisiones"
    ADD CONSTRAINT "comisiones_fk_0"
    FOREIGN KEY("cursoId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comisiones"
    ADD CONSTRAINT "comisiones_fk_1"
    FOREIGN KEY("_cursosComisionesCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "direcciones_de_email" table
--
ALTER TABLE ONLY "direcciones_de_email"
    ADD CONSTRAINT "direcciones_de_email_fk_0"
    FOREIGN KEY("_usuariosDireccionesdeemailUsuariosId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "direcciones_de_email_institucion" table
--
ALTER TABLE ONLY "direcciones_de_email_institucion"
    ADD CONSTRAINT "direcciones_de_email_institucion_fk_0"
    FOREIGN KEY("idInstitucion")
    REFERENCES "instituciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "domicilios_de_institucion" table
--
ALTER TABLE ONLY "domicilios_de_institucion"
    ADD CONSTRAINT "domicilios_de_institucion_fk_0"
    FOREIGN KEY("idInstitucion")
    REFERENCES "instituciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "domicilios_de_usuario" table
--
ALTER TABLE ONLY "domicilios_de_usuario"
    ADD CONSTRAINT "domicilios_de_usuario_fk_0"
    FOREIGN KEY("idUsuario")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "evaluaciones_de_asignatura" table
--
ALTER TABLE ONLY "evaluaciones_de_asignatura"
    ADD CONSTRAINT "evaluaciones_de_asignatura_fk_0"
    FOREIGN KEY("idInstanciaDeEvaluacion")
    REFERENCES "instancias_de_evaluacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evaluaciones_de_asignatura"
    ADD CONSTRAINT "evaluaciones_de_asignatura_fk_1"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evaluaciones_de_asignatura"
    ADD CONSTRAINT "evaluaciones_de_asignatura_fk_2"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "evaluaciones_de_compensacion" table
--
ALTER TABLE ONLY "evaluaciones_de_compensacion"
    ADD CONSTRAINT "evaluaciones_de_compensacion_fk_0"
    FOREIGN KEY("idInstanciaDeEvaluacion")
    REFERENCES "instancias_de_evaluacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evaluaciones_de_compensacion"
    ADD CONSTRAINT "evaluaciones_de_compensacion_fk_1"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "instancias_de_evaluacion" table
--
ALTER TABLE ONLY "instancias_de_evaluacion"
    ADD CONSTRAINT "instancias_de_evaluacion_fk_0"
    FOREIGN KEY("autor")
    REFERENCES "conceptos_calificacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "instancias_de_evaluacion"
    ADD CONSTRAINT "instancias_de_evaluacion_fk_1"
    FOREIGN KEY("idConcepto")
    REFERENCES "conceptos_calificacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "justificaciones_de_asistencia" table
--
ALTER TABLE ONLY "justificaciones_de_asistencia"
    ADD CONSTRAINT "justificaciones_de_asistencia_fk_0"
    FOREIGN KEY("idAsistencia")
    REFERENCES "asistencias_diarias"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "llamados_compensacion" table
--
ALTER TABLE ONLY "llamados_compensacion"
    ADD CONSTRAINT "llamados_compensacion_fk_0"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "numeros_de_telefono" table
--
ALTER TABLE ONLY "numeros_de_telefono"
    ADD CONSTRAINT "numeros_de_telefono_fk_0"
    FOREIGN KEY("_usuariosNumerosdetelefonoUsuariosId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "numeros_de_telefono_institucion" table
--
ALTER TABLE ONLY "numeros_de_telefono_institucion"
    ADD CONSTRAINT "numeros_de_telefono_institucion_fk_0"
    FOREIGN KEY("idinstitucion")
    REFERENCES "instituciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "r_asignaturas_usuarios" table
--
ALTER TABLE ONLY "r_asignaturas_usuarios"
    ADD CONSTRAINT "r_asignaturas_usuarios_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_asignaturas_usuarios"
    ADD CONSTRAINT "r_asignaturas_usuarios_fk_1"
    FOREIGN KEY("asignaturaId")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "r_comisiones_usuarios" table
--
ALTER TABLE ONLY "r_comisiones_usuarios"
    ADD CONSTRAINT "r_comisiones_usuarios_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_comisiones_usuarios"
    ADD CONSTRAINT "r_comisiones_usuarios_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "r_usuario_rol" table
--
ALTER TABLE ONLY "r_usuario_rol"
    ADD CONSTRAINT "r_usuario_rol_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_usuario_rol"
    ADD CONSTRAINT "r_usuario_rol_fk_1"
    FOREIGN KEY("rolId")
    REFERENCES "roles_de_usuario"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "solicitudes" table
--
ALTER TABLE ONLY "solicitudes"
    ADD CONSTRAINT "solicitudes_fk_0"
    FOREIGN KEY("idAutor")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes"
    ADD CONSTRAINT "solicitudes_fk_1"
    FOREIGN KEY("idDestinatario")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "solicitudes_notas_mensuales" table
--
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_0"
    FOREIGN KEY("idSolicitud")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_1"
    FOREIGN KEY("solicitudId")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_2"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_3"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "usuarios" table
--
ALTER TABLE ONLY "usuarios"
    ADD CONSTRAINT "usuarios_fk_0"
    FOREIGN KEY("domicilioId")
    REFERENCES "domicilios_de_usuario"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "usuarios_pendientes" table
--
ALTER TABLE ONLY "usuarios_pendientes"
    ADD CONSTRAINT "usuarios_pendientes_fk_0"
    FOREIGN KEY("rolSolicitado")
    REFERENCES "roles_de_usuario"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "usuarios_pendientes"
    ADD CONSTRAINT "usuarios_pendientes_fk_1"
    FOREIGN KEY("comisionSolicitadaId")
    REFERENCES "comision_solicitada"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240111132956409', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240111132956409', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20231205080920260', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20231205080920260', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20231205080924753', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20231205080924753', "timestamp" = now();


COMMIT;
