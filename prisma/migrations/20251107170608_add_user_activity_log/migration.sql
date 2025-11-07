-- CreateTable "user_activity_logs"
CREATE TABLE "user_activity_logs" (
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
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_activity_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "user_activity_logs_action_idx" ON "user_activity_logs"("action");

-- CreateIndex
CREATE INDEX "user_activity_logs_created_at_idx" ON "user_activity_logs"("created_at");

-- CreateIndex
CREATE INDEX "user_activity_logs_userId_idx" ON "user_activity_logs"("userId");

-- CreateIndex
CREATE INDEX "user_activity_logs_email_idx" ON "user_activity_logs"("email");

-- CreateIndex
CREATE INDEX "user_activity_logs_resource_id_idx" ON "user_activity_logs"("resource_id");
