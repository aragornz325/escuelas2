BEGIN;


--
-- ACTION DROP TABLE
--
DROP TABLE "tabla_de_prueba" CASCADE;

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
    "idAsignatura" integer NOT NULL,
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
ALTER TABLE "calificaciones_mensuales" DROP COLUMN "numeroDeAnio";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "direcciones_de_email" (
    "id" serial PRIMARY KEY,
    "usuarioId" integer NOT NULL,
    "direccionDeEmail" text NOT NULL,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "direcciones_de_email_de_usuario_unique_idx" ON "direcciones_de_email" USING btree ("direccionDeEmail");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "plantillas_comunicacion" (
    "id" serial PRIMARY KEY,
    "titulo" text NOT NULL,
    "nota" text NOT NULL,
    "necesitaSupervision" boolean NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

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
    FOREIGN KEY("idAsignatura")
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
    VALUES ('escuelas', '20240220180633102', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240220180633102', "timestamp" = now();

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20240220181419398', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240220181419398', "timestamp" = now();


COMMIT;
