BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "asignatura_solicitada" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "asignatura_solicitada" (
    "id" serial PRIMARY KEY,
    "idAsignatura" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "nombreAsignatura" text NOT NULL,
    "nombreCurso" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId" integer
);

--
-- ACTION DROP TABLE
--
DROP TABLE "comision_solicitada" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comision_solicitada" (
    "id" serial PRIMARY KEY,
    "idComision" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "nombreComision" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_0"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_1"
    FOREIGN KEY("_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comision_solicitada"
    ADD CONSTRAINT "comision_solicitada_fk_0"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240107195728563', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240107195728563', "timestamp" = now();

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
