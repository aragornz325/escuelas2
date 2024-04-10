BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emails_enviados" (
    "id" serial PRIMARY KEY,
    "tipoDeCorreo" integer NOT NULL,
    "direccionesEmailDestinatarios" text NOT NULL,
    "fecha" timestamp without time zone NOT NULL,
    "mes" integer NOT NULL,
    "anio" integer NOT NULL,
    "idComision" integer,
    "idCurso" integer,
    "idEstudiante" integer,
    "idDocente" integer,
    "idAsignatura" integer,
    "idSolicitud" integer
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_0"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_1"
    FOREIGN KEY("idCurso")
    REFERENCES "cursos"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_2"
    FOREIGN KEY("idEstudiante")
    REFERENCES "usuarios"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_3"
    FOREIGN KEY("idDocente")
    REFERENCES "usuarios"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_4"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emails_enviados"
    ADD CONSTRAINT "emails_enviados_fk_5"
    FOREIGN KEY("idSolicitud")
    REFERENCES "solicitudes"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240410213846767', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240410213846767', "timestamp" = now();

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
