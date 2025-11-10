/*
  Warnings:

  - You are about to drop the column `ipAddress` on the `audit_logs` table. All the data in the column will be lost.
  - You are about to drop the column `userAgent` on the `audit_logs` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "audit_logs" DROP COLUMN "ipAddress",
DROP COLUMN "userAgent",
ADD COLUMN     "email" TEXT,
ADD COLUMN     "ip_address" TEXT,
ADD COLUMN     "user_agent" TEXT,
ADD COLUMN     "user_id" TEXT;

-- CreateTable
CREATE TABLE "player_activity_archive" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "email" TEXT,
    "action" TEXT NOT NULL,
    "resource" TEXT,
    "resource_type" TEXT,
    "resource_id" TEXT,
    "details" JSONB,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "original_log_id" TEXT,
    "archived_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_anonymized" BOOLEAN NOT NULL DEFAULT false,
    "anonymized_at" TIMESTAMP(3),

    CONSTRAINT "player_activity_archive_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_activity_archive" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "email" TEXT,
    "action" TEXT NOT NULL,
    "resource" TEXT,
    "resource_type" TEXT,
    "resource_id" TEXT,
    "details" JSONB,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "user_role" TEXT,
    "tenant_id" TEXT,
    "original_log_id" TEXT,
    "archived_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_anonymized" BOOLEAN NOT NULL DEFAULT false,
    "anonymized_at" TIMESTAMP(3),

    CONSTRAINT "admin_activity_archive_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "player_activity_archive_user_id_idx" ON "player_activity_archive"("user_id");

-- CreateIndex
CREATE INDEX "player_activity_archive_email_idx" ON "player_activity_archive"("email");

-- CreateIndex
CREATE INDEX "player_activity_archive_action_idx" ON "player_activity_archive"("action");

-- CreateIndex
CREATE INDEX "player_activity_archive_created_at_idx" ON "player_activity_archive"("created_at");

-- CreateIndex
CREATE INDEX "player_activity_archive_archived_at_idx" ON "player_activity_archive"("archived_at");

-- CreateIndex
CREATE INDEX "player_activity_archive_is_anonymized_idx" ON "player_activity_archive"("is_anonymized");

-- CreateIndex
CREATE INDEX "admin_activity_archive_user_id_idx" ON "admin_activity_archive"("user_id");

-- CreateIndex
CREATE INDEX "admin_activity_archive_email_idx" ON "admin_activity_archive"("email");

-- CreateIndex
CREATE INDEX "admin_activity_archive_action_idx" ON "admin_activity_archive"("action");

-- CreateIndex
CREATE INDEX "admin_activity_archive_created_at_idx" ON "admin_activity_archive"("created_at");

-- CreateIndex
CREATE INDEX "admin_activity_archive_archived_at_idx" ON "admin_activity_archive"("archived_at");

-- CreateIndex
CREATE INDEX "admin_activity_archive_is_anonymized_idx" ON "admin_activity_archive"("is_anonymized");

-- CreateIndex
CREATE INDEX "admin_activity_archive_user_role_idx" ON "admin_activity_archive"("user_role");

-- CreateIndex
CREATE INDEX "admin_activity_archive_tenant_id_idx" ON "admin_activity_archive"("tenant_id");

-- CreateIndex
CREATE INDEX "audit_logs_user_id_idx" ON "audit_logs"("user_id");

-- CreateIndex
CREATE INDEX "audit_logs_email_idx" ON "audit_logs"("email");

-- CreateIndex
CREATE INDEX "audit_logs_user_role_idx" ON "audit_logs"("user_role");
