BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calificaciones" (
    "id" serial PRIMARY KEY,
    "idAutor" integer NOT NULL,
    "estudianteId" integer NOT NULL,
    "idComision" integer NOT NULL,
    "asignaturaId" integer NOT NULL,
    "idInstanciaDeEvaluacion" integer NOT NULL,
    "tipoCalificacion" integer NOT NULL,
    "index" integer NOT NULL,
    "diferencial" text NOT NULL,
    "observacion" text,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comisiones" ALTER COLUMN "ultimaModificacion" SET NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_0"
    FOREIGN KEY("idAutor")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_1"
    FOREIGN KEY("estudianteId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_2"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_3"
    FOREIGN KEY("asignaturaId")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_4"
    FOREIGN KEY("idInstanciaDeEvaluacion")
    REFERENCES "instancias_de_evaluacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240219175353377', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240219175353377', "timestamp" = now();

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
