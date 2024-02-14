BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "contactos_de_emergencia" DROP CONSTRAINT "contactos_de_emergencia_fk_0";
ALTER TABLE "contactos_de_emergencia" DROP COLUMN "idUsuario";
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "usuario_contacto_de_emergencia_unique_idx" ON "usuarios" USING btree ("contactoDeEmergenciaId");

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240209174736915', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209174736915', "timestamp" = now();

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
