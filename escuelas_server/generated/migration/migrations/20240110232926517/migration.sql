BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "calificaciones_mensuales" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calificaciones_mensuales" (
    "id" serial PRIMARY KEY,
    "calificacionId" integer NOT NULL,
    "idCalificacion" integer NOT NULL,
    "numeroDeMes" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "calificacion_calificacion_mensual_unique_idx" ON "calificaciones_mensuales" USING btree ("calificacionId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_0"
    FOREIGN KEY("calificacionId")
    REFERENCES "calificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "calificaciones_mensuales"
    ADD CONSTRAINT "calificaciones_mensuales_fk_1"
    FOREIGN KEY("idCalificacion")
    REFERENCES "calificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240110232926517', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240110232926517', "timestamp" = now();

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
