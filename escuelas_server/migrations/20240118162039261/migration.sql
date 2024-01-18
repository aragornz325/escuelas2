BEGIN;

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
    FOREIGN KEY("idRolSolicitado")
    REFERENCES "roles_de_usuario"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "usuarios_pendientes"
    ADD CONSTRAINT "usuarios_pendientes_fk_1"
    FOREIGN KEY("comisionSolicitadaId")
    REFERENCES "comision_solicitada"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240118162039261', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240118162039261', "timestamp" = now();

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
