BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notificaciones" (
    "id" serial PRIMARY KEY,
    "titulo" text NOT NULL,
    "cuerpo" text NOT NULL,
    "fueEditada" boolean NOT NULL,
    "idEstudiante" integer NOT NULL,
    "idCreadorNotificacion" integer NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "ultimaModificacion" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
DROP INDEX "r_asignatura_idx";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "solicitudes_envio_notificacion" (
    "id" serial PRIMARY KEY,
    "solicitudId" integer NOT NULL,
    "mes" integer NOT NULL,
    "anio" integer NOT NULL,
    "comisionId" integer NOT NULL,
    "docenteId" integer NOT NULL,
    "alumnoId" integer NOT NULL,
    "notificacionId" integer NOT NULL,
    "estado" integer NOT NULL
);

--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "userinfo_unique_idx" ON "usuarios" USING btree ("idUserInfo");
CREATE UNIQUE INDEX "dni_unique_idx" ON "usuarios" USING btree ("dni");
CREATE UNIQUE INDEX "userinfo_dni_unique_idx" ON "usuarios" USING btree ("idUserInfo", "dni");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notificaciones"
    ADD CONSTRAINT "notificaciones_fk_0"
    FOREIGN KEY("idEstudiante")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "notificaciones"
    ADD CONSTRAINT "notificaciones_fk_1"
    FOREIGN KEY("idCreadorNotificacion")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "solicitudes_envio_notificacion"
    ADD CONSTRAINT "solicitudes_envio_notificacion_fk_0"
    FOREIGN KEY("solicitudId")
    REFERENCES "solicitudes"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_envio_notificacion"
    ADD CONSTRAINT "solicitudes_envio_notificacion_fk_1"
    FOREIGN KEY("comisionId")
    REFERENCES "comisiones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_envio_notificacion"
    ADD CONSTRAINT "solicitudes_envio_notificacion_fk_2"
    FOREIGN KEY("docenteId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_envio_notificacion"
    ADD CONSTRAINT "solicitudes_envio_notificacion_fk_3"
    FOREIGN KEY("alumnoId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "solicitudes_envio_notificacion"
    ADD CONSTRAINT "solicitudes_envio_notificacion_fk_4"
    FOREIGN KEY("notificacionId")
    REFERENCES "notificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240318183953876', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240318183953876', "timestamp" = now();

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
