BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "r_usuario_asignatura_index_idx";
CREATE UNIQUE INDEX "r_usuario_asignatura_index_idx" ON "r_asignaturas_usuarios" USING btree ("usuarioId", "asignaturaId", "comisionId");

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240202182235224', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240202182235224', "timestamp" = now();

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
