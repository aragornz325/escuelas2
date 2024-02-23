BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones_mensuales" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calificaciones_mensuales" (
    "id" serial PRIMARY KEY,
    "calificacionId" integer NOT NULL,
    "numeroDeMes" integer NOT NULL,
    "numeroDeAnio" integer NOT NULL,
    "_solicitudesCalificacionesMensualesCalificacionesSolicitu3ef6Id" integer
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_0"
    FOREIGN KEY("calificacionId")
    REFERENCES "calificaciones"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("_solicitudesCalificacionesMensualesCalificacionesSolicitu3ef6Id")
    REFERENCES "solicitudes_calificaciones_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240220133938038', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240220133938038', "timestamp" = now();

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
