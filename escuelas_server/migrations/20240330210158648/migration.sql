BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "instancias_de_evaluacion" DROP CONSTRAINT "instancias_de_evaluacion_fk_0";
ALTER TABLE ONLY "instancias_de_evaluacion"
    ADD CONSTRAINT "instancias_de_evaluacion_fk_0"
    FOREIGN KEY("autor")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240330210158648', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240330210158648', "timestamp" = now();

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
