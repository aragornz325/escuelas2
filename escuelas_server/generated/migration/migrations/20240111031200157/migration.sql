BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "calificaciones_mensuales" ADD COLUMN "_solicitudesNotasMensualesCalificacionesSolicitudesNotasMensualesId" integer;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_2"
    FOREIGN KEY("_solicitudesNotasMensualesCalificacionesSolicitudesNotasMensualesId")
    REFERENCES "solicitudes_notas_mensuales"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION DROP TABLE
--
DROP TABLE "solicitudes_notas_mensuales" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes_notas_mensuales" (
    "id" serial PRIMARY KEY,
    "idSolicitud" integer NOT NULL,
    "solicitudId" integer NOT NULL,
    "idComision" integer NOT NULL,
    "idAsignatura" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "solicitud_solicitud_mensual_unique_idx" ON "solicitudes_notas_mensuales" USING btree ("solicitudId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_0"
    FOREIGN KEY("idSolicitud")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_1"
    FOREIGN KEY("solicitudId")
    REFERENCES "solicitudes"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_2"
    FOREIGN KEY("idComision")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_notas_mensuales"
    ADD CONSTRAINT "solicitudes_notas_mensuales_fk_3"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240111031200157', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240111031200157', "timestamp" = now();

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
