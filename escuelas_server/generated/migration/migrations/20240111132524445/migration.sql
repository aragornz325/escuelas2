BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "comision_solicitada" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comision_solicitada" (
    "id" serial PRIMARY KEY,
    "comisionId" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_0"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_1"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240111132524445', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240111132524445', "timestamp" = now();

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
