BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "numeros_de_telefono" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "numeros_de_telefono" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "numeroDeTelefono" text NOT NULL,
    "tipoDeTelefono" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "numeros_de_telefono"
    ADD CONSTRAINT "numeros_de_telefono_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240209154634574', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240209154634574', "timestamp" = now();

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
