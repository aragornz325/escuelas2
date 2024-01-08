BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "asistencias_diarias" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "asistencias_diarias" (
    "id" serial PRIMARY KEY,
    "estudianteId" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "estadoDeAsistencia" integer NOT NULL,
    "fecha" timestamp without time zone NOT NULL,
    "idJustificacion" integer,
    "ultimaModificacion" timestamp without time zone,
    "fechaCreacion" timestamp without time zone,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_0"
    FOREIGN KEY("estudianteId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones_de_curso"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "asistencias_diarias"
    ADD CONSTRAINT "asistencias_diarias_fk_2"
    FOREIGN KEY("idJustificacion")
    REFERENCES "justificaciones_de_asistencia"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240108191323453', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240108191323453', "timestamp" = now();

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
