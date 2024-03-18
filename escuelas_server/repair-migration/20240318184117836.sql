BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user_role_relation" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "roles" CASCADE;


--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "userinfo_unique_idx" ON "usuarios" USING btree ("idUserInfo");
CREATE UNIQUE INDEX "dni_unique_idx" ON "usuarios" USING btree ("dni");
CREATE UNIQUE INDEX "userinfo_dni_unique_idx" ON "usuarios" USING btree ("idUserInfo", "dni");

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20240318184117836', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240318184117836', "timestamp" = now();


COMMIT;
