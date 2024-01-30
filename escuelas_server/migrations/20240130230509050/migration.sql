BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "direcciones_de_email" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "direcciones_de_email" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "direccionDeEmail" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "periodos" DROP COLUMN "ultimaModificacion";
ALTER TABLE "periodos" DROP COLUMN "fechaCreacion";
ALTER TABLE "periodos" DROP COLUMN "fechaEliminacion";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "direcciones_de_email"
    ADD CONSTRAINT "direcciones_de_email_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240130230509050', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240130230509050', "timestamp" = now();

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
