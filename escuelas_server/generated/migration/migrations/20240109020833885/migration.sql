BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comisiones_de_curso" ADD COLUMN "_cursosComisionesCursosId" integer;
ALTER TABLE ONLY "comisiones_de_curso"
    ADD CONSTRAINT "comisiones_de_curso_fk_1"
    FOREIGN KEY("_cursosComisionesCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240109020833885', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240109020833885', "timestamp" = now();

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
