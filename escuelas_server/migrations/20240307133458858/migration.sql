BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comentarios_hilo_de_notificaciones" (
    "id" serial PRIMARY KEY,
    "contenido" text NOT NULL,
    "idHiloDeNotificaciones" integer NOT NULL,
    "autorId" integer NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaLectura" timestamp without time zone,
    "_hilosDeNotificacionesComentariosHilosDeNotificacionesId" integer
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hilos_de_notificaciones" (
    "id" serial PRIMARY KEY,
    "titulo" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone,
    "estudianteId" integer NOT NULL,
    "autorId" integer NOT NULL,
    "necesitaSupervision" boolean NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comentarios_hilo_de_notificaciones"
    ADD CONSTRAINT "comentarios_hilo_de_notificaciones_fk_0"
    FOREIGN KEY("idHiloDeNotificaciones")
    REFERENCES "hilos_de_notificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comentarios_hilo_de_notificaciones"
    ADD CONSTRAINT "comentarios_hilo_de_notificaciones_fk_1"
    FOREIGN KEY("autorId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comentarios_hilo_de_notificaciones"
    ADD CONSTRAINT "comentarios_hilo_de_notificaciones_fk_2"
    FOREIGN KEY("_hilosDeNotificacionesComentariosHilosDeNotificacionesId")
    REFERENCES "hilos_de_notificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "hilos_de_notificaciones"
    ADD CONSTRAINT "hilos_de_notificaciones_fk_0"
    FOREIGN KEY("estudianteId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "hilos_de_notificaciones"
    ADD CONSTRAINT "hilos_de_notificaciones_fk_1"
    FOREIGN KEY("autorId")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240307133458858', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240307133458858', "timestamp" = now();

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
