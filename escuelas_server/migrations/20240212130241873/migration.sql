BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ADD COLUMN "contactoDeEmergenciaId" integer;
CREATE UNIQUE INDEX "usuario_contacto_de_emergencia_unique_idx" ON "usuarios" USING btree ("contactoDeEmergenciaId");
ALTER TABLE ONLY "usuarios"
    ADD CONSTRAINT "usuarios_fk_1"
    FOREIGN KEY("contactoDeEmergenciaId")
    REFERENCES "contactos_de_emergencia"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240212130241873', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240212130241873', "timestamp" = now();

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
