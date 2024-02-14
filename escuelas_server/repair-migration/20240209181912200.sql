BEGIN;


--
-- ACTION ALTER TABLE
--
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("_solicitudesCalificacionesMensualesCalificacionesSolicitu3ef6Id")
    REFERENCES "solicitudes_calificaciones_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
DROP INDEX "direcciones_de_email_direccionDeEmail_key";
--
-- ACTION ALTER TABLE
--
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
    VALUES ('escuelas', '20240209175447836', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209175447836', "timestamp" = now();

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
    VALUES ('_repair', '20240209181912200', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209181912200', "timestamp" = now();


COMMIT;
