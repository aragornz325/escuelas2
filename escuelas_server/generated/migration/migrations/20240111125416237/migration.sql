BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comisiones" DROP CONSTRAINT "comisiones_fk_2";
ALTER TABLE "comisiones" DROP CONSTRAINT "comisiones_fk_0";
ALTER TABLE "comisiones" DROP CONSTRAINT "comisiones_fk_1";
ALTER TABLE "comisiones" DROP COLUMN "idCurso";
ALTER TABLE ONLY "comisiones"
    ADD CONSTRAINT "comisiones_fk_0"
    FOREIGN KEY("cursoId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comisiones"
    ADD CONSTRAINT "comisiones_fk_1"
    FOREIGN KEY("_cursosComisionesCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240111125416237', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240111125416237', "timestamp" = now();

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
