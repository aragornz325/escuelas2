BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "r_asignatura_usuario" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "r_asignaturas_usuarios" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "asignaturaId" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_asignatura_index_idx" ON "r_asignaturas_usuarios" USING btree ("usuarioId", "asignaturaId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "r_asignaturas_usuarios"
    ADD CONSTRAINT "r_asignaturas_usuarios_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_asignaturas_usuarios"
    ADD CONSTRAINT "r_asignaturas_usuarios_fk_1"
    FOREIGN KEY("asignaturaId")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240110131334714', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240110131334714', "timestamp" = now();

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
