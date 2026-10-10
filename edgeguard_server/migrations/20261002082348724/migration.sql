BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "scam_report" (
    "id" bigserial PRIMARY KEY,
    "phoneNumber" text NOT NULL,
    "category" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "city" text
);


--
-- MIGRATION VERSION FOR edgeguard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('edgeguard', '20261002082348724', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261002082348724', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
