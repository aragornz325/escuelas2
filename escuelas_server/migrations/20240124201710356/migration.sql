BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "calificacion_calificacion_mensual_unique_idx";
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_0"
    FOREIGN KEY("calificacionId")
    REFERENCES "calificaciones"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("_solicitudesNotasMensualesCalificacionesSolicitudesNotasMabd6Id")
    REFERENCES "solicitudes_notas_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "instancias_de_evaluacion" ALTER COLUMN "fechaDeRealizacion" DROP NOT NULL;

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240124201710356', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240124201710356', "timestamp" = now();

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
