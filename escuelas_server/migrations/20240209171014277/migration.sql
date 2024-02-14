BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "contactos_de_emergencia" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "contactos_de_emergencia" (
    "id" serial PRIMARY KEY,
    "idUsuario" integer NOT NULL,
    "nombre" text NOT NULL,
    "apellido" text NOT NULL,
    "telefono" text NOT NULL,
    "email" text NOT NULL,
    "relacion" text NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "contactos_de_emergencia"
    ADD CONSTRAINT "contactos_de_emergencia_fk_0"
    FOREIGN KEY("idUsuario")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240209171014277', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209171014277', "timestamp" = now();

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
