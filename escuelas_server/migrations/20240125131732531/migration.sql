BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "solicitudes_notas_mensuales" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes_notas_mensuales" (
    "id" serial PRIMARY KEY,
    "solicitudId" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_0"
    FOREIGN KEY("solicitudId")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_2"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240125131732531', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240125131732531', "timestamp" = now();

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
