BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "userinfo_pendiente_unique_idx" ON "usuarios_pendientes" USING btree ("idUserInfo");
CREATE UNIQUE INDEX "dni_pendiente_unique_idx" ON "usuarios_pendientes" USING btree ("dni");
CREATE UNIQUE INDEX "userinfo_dni_pendiente_unique_idx" ON "usuarios_pendientes" USING btree ("idUserInfo", "dni");

--
-- MIGRATION VERSION FOR escuelas
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('escuelas', '20240323215158488', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240323215158488', "timestamp" = now();

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
