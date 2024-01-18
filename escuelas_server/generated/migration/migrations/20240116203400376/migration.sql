BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "roles_de_usuario" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "r_usuario_rol" CASCADE;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "usuarios" ADD COLUMN "privileges" text;
--
-- ACTION DROP TABLE
--
DROP TABLE "usuarios_pendientes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "usuarios_pendientes" (
    "id" serial PRIMARY KEY,
    "idUserInfo" integer NOT NULL,
    "nombre" text NOT NULL,
    "apellido" text NOT NULL,
    "urlFotoDePerfil" text NOT NULL,
    "dni" text,
    "idRolSolicitado" integer NOT NULL,
    "estadoDeSolicitud" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone,
    "comisionSolicitadaId" integer
);

-- Indexes
CREATE UNIQUE INDEX "usuario_comision_unique_idx" ON "usuarios_pendientes" USING btree ("comisionSolicitadaId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "usuarios_pendientes"
    ADD CONSTRAINT "usuarios_pendientes_fk_0"
    FOREIGN KEY("comisionSolicitadaId")
    REFERENCES "comision_solicitada"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240116203400376', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240116203400376', "timestamp" = now();

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
