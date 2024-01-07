BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "asignaturas" DROP COLUMN "idCurso";
ALTER TABLE "asignaturas" ADD COLUMN "_cursosAsignaturasCursosId" integer;
ALTER TABLE ONLY "asignaturas"
    ADD CONSTRAINT "asignaturas_fk_0"
    FOREIGN KEY("_cursosAsignaturasCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ALTER COLUMN "dni" DROP NOT NULL;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240107205545719', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240107205545719', "timestamp" = now();

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
