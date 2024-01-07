BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comision_solicitada" (
    "id" serial PRIMARY KEY,
    "idComision" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

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
-- ACTION CREATE TABLE
--
CREATE TABLE "r_comisiones_usuarios" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "comisionDeCursoId" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_comision_index_idx" ON "r_comisiones_usuarios" USING btree ("usuarioId", "comisionDeCursoId");

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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "r_comisiones_usuarios"
    ADD CONSTRAINT "r_comisiones_usuarios_fk_0"
    FOREIGN KEY("usuarioId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_comisiones_usuarios"
    ADD CONSTRAINT "r_comisiones_usuarios_fk_1"
    FOREIGN KEY("comisionDeCursoId")
    REFERENCES "comisiones_de_curso"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240107024554604', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240107024554604', "timestamp" = now();

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
