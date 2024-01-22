BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "roles_de_usuario" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "r_usuario_rol" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ADD COLUMN "privileges" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios_pendientes" DROP CONSTRAINT "usuarios_pendientes_fk_1";
ALTER TABLE "usuarios_pendientes" DROP CONSTRAINT "usuarios_pendientes_fk_0";
ALTER TABLE ONLY "usuarios_pendientes"
    ADD CONSTRAINT "usuarios_pendientes_fk_0"
    FOREIGN KEY("comisionSolicitadaId")
    REFERENCES "comision_solicitada"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240118192224409', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240118192224409', "timestamp" = now();

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
