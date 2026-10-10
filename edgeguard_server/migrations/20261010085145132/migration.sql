BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "false_positive_report" (
    "id" bigserial PRIMARY KEY,
    "messageContent" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR edgeguard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('edgeguard', '20261010085145132', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010085145132', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
