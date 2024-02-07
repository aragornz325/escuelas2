BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comisiones" ALTER COLUMN "ultimaModificacion" DROP NOT NULL;
--
-- ACTION DROP TABLE
--
DROP TABLE "llamados_compensacion" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "llamados_compensacion" (
    "id" serial PRIMARY KEY,
    "lugar" integer NOT NULL,
    "fechaLlamado" timestamp without time zone NOT NULL,
    "fechaRealizacion" timestamp without time zone,
    "idAsignatura" integer NOT NULL,
    "observaciones" text NOT NULL,
    "ultimaModificacion" timestamp without time zone NOT NULL,
    "fechaCreacion" timestamp without time zone NOT NULL,
    "fechaEliminacion" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "numeros_de_telefono" ALTER COLUMN "ultimaModificacion" DROP NOT NULL;
ALTER TABLE "numeros_de_telefono" ALTER COLUMN "fechaCreacion" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "r_usuario_index_idx" ON "r_comisiones_usuarios" USING btree ("usuarioId");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "llamados_compensacion"
    ADD CONSTRAINT "llamados_compensacion_fk_0"
    FOREIGN KEY("idAsignatura")
    REFERENCES "asignaturas"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240207162158289', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240207162158289', "timestamp" = now();

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
