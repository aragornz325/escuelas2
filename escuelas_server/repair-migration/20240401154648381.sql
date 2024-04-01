BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "asignaturas" ALTER COLUMN "ultimaModificacion" DROP DEFAULT;
ALTER TABLE "asignaturas" ALTER COLUMN "fechaCreacion" DROP DEFAULT;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "instancias_de_evaluacion" DROP CONSTRAINT "public_instancias_de_evaluacion_autor_fkey";
ALTER TABLE ONLY "instancias_de_evaluacion"
    ADD CONSTRAINT "instancias_de_evaluacion_fk_0"
    FOREIGN KEY("autor")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "r_asignatura_curso" ALTER COLUMN "fechaCreacion" DROP DEFAULT;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ADD COLUMN "necesitaCambiarPassword" boolean;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240401154125303', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240401154125303', "timestamp" = now();

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
    VALUES ('_repair', '20240401154648381', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240401154648381', "timestamp" = now();


COMMIT;
