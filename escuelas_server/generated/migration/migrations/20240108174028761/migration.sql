BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "valor_calificaciones" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "tipo_calificaciones" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones_conceptos" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificacion_compensaciones" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificacion_asignaturas" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calificaciones" (
    "id" serial PRIMARY KEY,
    "idEstudiante" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "idConcepto" integer NOT NULL,
    "tipoCalificacion" integer NOT NULL,
    "index" integer NOT NULL,
    "diferencial" text NOT NULL,
    "detalle" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_0"
    FOREIGN KEY("idEstudiante")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_1"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones_de_curso"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_2"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones"
    ADD CONSTRAINT "calificaciones_fk_3"
    FOREIGN KEY("idConcepto")
    REFERENCES "conceptos_calificacion"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240108174028761', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240108174028761', "timestamp" = now();

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
