BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "numeros_de_telefono" DROP CONSTRAINT "numeros_de_telefono_fk_0";
ALTER TABLE "numeros_de_telefono" DROP COLUMN "usuarioId";
ALTER TABLE "numeros_de_telefono" ADD COLUMN "_usuariosNumerosdetelefonoUsuariosId" integer;
ALTER TABLE ONLY "numeros_de_telefono"
    ADD CONSTRAINT "numeros_de_telefono_fk_0"
    FOREIGN KEY("_usuariosNumerosdetelefonoUsuariosId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" DROP COLUMN "contactoDeEmergenciaId";

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240209182919404', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209182919404', "timestamp" = now();

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
