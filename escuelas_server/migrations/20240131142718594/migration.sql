BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ALTER COLUMN "ultimaModificacion" DROP NOT NULL;
ALTER TABLE "usuarios" ALTER COLUMN "fechaCreacion" DROP NOT NULL;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240131142718594', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240131142718594', "timestamp" = now();

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
