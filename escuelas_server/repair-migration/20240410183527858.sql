BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "calificaciones" DROP CONSTRAINT "calificaciones_fk_4";
ALTER TABLE "calificaciones" ALTER COLUMN "idInstanciaDeEvaluacion" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "direcciones_de_email" DROP COLUMN "etiqueta";
CREATE UNIQUE INDEX "direcciones_de_email_de_usuario_unique_idx" ON "direcciones_de_email" USING btree ("direccionDeEmail");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" DROP COLUMN "privileges";
ALTER TABLE "usuarios" ADD COLUMN "privileges" text;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240410183237470', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240410183237470', "timestamp" = now();

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20240410183527858', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240410183527858', "timestamp" = now();


COMMIT;
