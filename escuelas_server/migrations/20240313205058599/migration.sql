BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hilos_de_notificaciones" DROP CONSTRAINT "hilos_de_notificaciones_fk_1";
ALTER TABLE "hilos_de_notificaciones" DROP COLUMN "autorId";
--
-- ACTION CREATE TABLE
--
CREATE TABLE "r_comentario_hilo_de_notificacion_usuario" (
    "id" serial PRIMARY KEY,
    "idUsuario" integer NOT NULL,
    "comentarioId" integer NOT NULL,
    "fechaDeLectura" timestamp without time zone,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_comentario_index_idx" ON "r_comentario_hilo_de_notificacion_usuario" USING btree ("idUsuario", "comentarioId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "r_hilo_de_notificaciones_usuario" (
    "id" serial PRIMARY KEY,
    "idUsuario" integer NOT NULL,
    "hiloDeNotificacionesId" integer NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "r_usuario_hilo_index_idx" ON "r_hilo_de_notificaciones_usuario" USING btree ("idUsuario", "hiloDeNotificacionesId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "r_comentario_hilo_de_notificacion_usuario"
    ADD CONSTRAINT "r_comentario_hilo_de_notificacion_usuario_fk_0"
    FOREIGN KEY("idUsuario")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_comentario_hilo_de_notificacion_usuario"
    ADD CONSTRAINT "r_comentario_hilo_de_notificacion_usuario_fk_1"
    FOREIGN KEY("comentarioId")
    REFERENCES "comentarios_hilo_de_notificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "r_hilo_de_notificaciones_usuario"
    ADD CONSTRAINT "r_hilo_de_notificaciones_usuario_fk_0"
    FOREIGN KEY("idUsuario")
    REFERENCES "usuarios"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "r_hilo_de_notificaciones_usuario"
    ADD CONSTRAINT "r_hilo_de_notificaciones_usuario_fk_1"
    FOREIGN KEY("hiloDeNotificacionesId")
    REFERENCES "hilos_de_notificaciones"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240313205058599', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240313205058599', "timestamp" = now();

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
