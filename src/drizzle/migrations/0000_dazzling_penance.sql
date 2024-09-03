DO $$ BEGIN
 CREATE TYPE "public"."day" AS ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"durationInMinutes" integer NOT NULL,
	"clerkUserId" text NOT NULL,
	"isActive" boolean DEFAULT true NOT NULL,
	"createdAt" timestamp DEFAULT now() NOT NULL,
	"updatedAt" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "scheduleAvailabilities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"scheduleId" uuid NOT NULL,
	"startTime" text NOT NULL,
	"endTime" text NOT NULL,
	"dayOfWeek" "day" NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "schedules" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"timezone" text NOT NULL,
	"clerkUserId" text NOT NULL,
	"createdAt" timestamp DEFAULT now() NOT NULL,
	"updatedAt" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "schedules_clerkUserId_unique" UNIQUE("clerkUserId")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "scheduleAvailabilities" ADD CONSTRAINT "scheduleAvailabilities_scheduleId_schedules_id_fk" FOREIGN KEY ("scheduleId") REFERENCES "public"."schedules"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "clerkUserIdIndex" ON "events" USING btree ("clerkUserId");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "scheduleIdIndex" ON "scheduleAvailabilities" USING btree ("scheduleId");