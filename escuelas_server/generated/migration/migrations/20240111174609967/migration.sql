BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comision_solicitada" DROP CONSTRAINT "comision_solicitada_fk_1";
ALTER TABLE "comision_solicitada" DROP COLUMN "idUsuarioPendiente";
--
-- ACTION ALTER TABLE
--
DROP INDEX "comision_solicitada_unique_idx";
CREATE UNIQUE INDEX "usuario_comision_unique_idx" ON "usuarios_pendientes" USING btree ("comisionSolicitadaId");

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240111174609967', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240111174609967', "timestamp" = now();

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
