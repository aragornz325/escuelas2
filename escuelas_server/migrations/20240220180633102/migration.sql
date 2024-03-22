BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comisiones" ALTER COLUMN "ultimaModificacion" SET NOT NULL;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "plantillas_comunicacion" (
    "id" serial PRIMARY KEY,
    "titulo" text NOT NULL,
    "nota" text NOT NULL,
    "necesitaSupervision" boolean NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240220180633102', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240220180633102', "timestamp" = now();

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
