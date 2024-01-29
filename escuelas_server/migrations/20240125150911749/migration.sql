BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "solicitudes_notas_mensuales" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "calificaciones_mensuales" DROP CONSTRAINT "calificaciones_mensuales_fk_1";
ALTER TABLE "calificaciones_mensuales" DROP COLUMN "_solicitudesNotasMensualesCalificacionesSolicitudesNotasMabd6Id";
ALTER TABLE "calificaciones_mensuales" ADD COLUMN "_solicitudesCalificacionesMensualesCalificacionesSolicitu3ef6Id" integer;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("_solicitudesCalificacionesMensualesCalificacionesSolicitu3ef6Id")
    REFERENCES "solicitudes_calificaciones_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes_calificaciones_mensuales" (
    "id" serial PRIMARY KEY,
    "solicitudId" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solicitudes_calificaciones_mensuales"
    ADD CONSTRAINT "solicitudes_calificaciones_mensuales_fk_0"
    FOREIGN KEY("solicitudId")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_calificaciones_mensuales"
    ADD CONSTRAINT "solicitudes_calificaciones_mensuales_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_calificaciones_mensuales"
    ADD CONSTRAINT "solicitudes_calificaciones_mensuales_fk_2"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240125150911749', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240125150911749', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240115074239642', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074239642', "timestamp" = now();


COMMIT;
