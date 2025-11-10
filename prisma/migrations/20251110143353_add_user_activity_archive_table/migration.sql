-- CreateTable
CREATE TABLE "user_activity_archive" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "resource" TEXT,
    "resource_type" TEXT,
    "resource_id" TEXT,
    "details" JSONB,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "email" TEXT,
    "original_log_id" TEXT,
    "archived_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_anonymized" BOOLEAN NOT NULL DEFAULT false,
    "anonymized_at" TIMESTAMP(3),

    CONSTRAINT "user_activity_archive_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "user_activity_archive_userId_idx" ON "user_activity_archive"("userId");

-- CreateIndex
CREATE INDEX "user_activity_archive_email_idx" ON "user_activity_archive"("email");

-- CreateIndex
CREATE INDEX "user_activity_archive_action_idx" ON "user_activity_archive"("action");

-- CreateIndex
CREATE INDEX "user_activity_archive_created_at_idx" ON "user_activity_archive"("created_at");

-- CreateIndex
CREATE INDEX "user_activity_archive_archived_at_idx" ON "user_activity_archive"("archived_at");

-- CreateIndex
CREATE INDEX "user_activity_archive_is_anonymized_idx" ON "user_activity_archive"("is_anonymized");

-- CreateIndex
CREATE INDEX "user_activity_archive_original_log_id_idx" ON "user_activity_archive"("original_log_id");
