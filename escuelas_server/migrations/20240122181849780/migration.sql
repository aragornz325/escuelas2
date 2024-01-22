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
    "asignaturaId" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "idUsuarioPendiente" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId" integer
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "asignaturas" DROP CONSTRAINT "asignaturas_fk_1";
ALTER TABLE "asignaturas" DROP CONSTRAINT "asignaturas_fk_0";
ALTER TABLE "asignaturas" DROP COLUMN "cursoId";
ALTER TABLE ONLY "asignaturas"
    ADD CONSTRAINT "asignaturas_fk_0"
    FOREIGN KEY("_cursosAsignaturasCursosId")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "r_asignatura_curso" (
    "id" serial PRIMARY KEY,
    "idAsignatura" integer NOT NULL,
    "idCurso" integer NOT NULL,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_0"
    FOREIGN KEY("asignaturaId")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_2"
    FOREIGN KEY("idUsuarioPendiente")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asignatura_solicitada"
    ADD CONSTRAINT "asignatura_solicitada_fk_3"
    FOREIGN KEY("_usuariosPendientesAsignaturassolicitadasUsuariosPendientesId")
    REFERENCES "usuarios_pendientes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "r_asignatura_curso"
    ADD CONSTRAINT "r_asignatura_curso_fk_0"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_asignatura_curso"
    ADD CONSTRAINT "r_asignatura_curso_fk_1"
    FOREIGN KEY("idCurso")
    REFERENCES "cursos"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240122181849780', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240122181849780', "timestamp" = now();

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
