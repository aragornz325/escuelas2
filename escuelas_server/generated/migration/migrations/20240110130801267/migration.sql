BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "asignatura_solicitada" DROP CONSTRAINT "asignatura_solicitada_fk_0";
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_0"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones" CASCADE;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "calificaciones_mensuales" (
    "id" serial PRIMARY KEY,
    "idCalificacion" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comision_solicitada" DROP CONSTRAINT "comision_solicitada_fk_0";
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_0"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "evaluaciones_de_asignatura" (
    "id" serial PRIMARY KEY,
    "idInstanciaDeEvaluacion" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evaluaciones_de_compensacion" (
    "id" serial PRIMARY KEY,
    "idInstanciaDeEvaluacion" integer NOT NULL,
    "idAsignatura" integer NOT NULL
);

--
-- ACTION CREATE TABLE
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
-- ACTION DROP TABLE
--
DROP TABLE "periodos" CASCADE;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes" (
    "id" serial PRIMARY KEY,
    "tipoSolicitud" integer NOT NULL,
    "idAutor" integer NOT NULL,
    "idDestinatario" integer NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaRealizacion" timestamp without time zone NOT NULL,
    "fechaVisto" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes_notas_mensuales" (
    "id" serial PRIMARY KEY,
    "idSolicitud" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "numeroDemes" integer NOT NULL,
    "idCalificacionMensual" integer NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_0"
    FOREIGN KEY("idCalificacion")
    REFERENCES "calificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_0"
    FOREIGN KEY("idSolicitud")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_1"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_2"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_3"
    FOREIGN KEY("idCalificacionMensual")
    REFERENCES "calificaciones_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240110130801267', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240110130801267', "timestamp" = now();

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
