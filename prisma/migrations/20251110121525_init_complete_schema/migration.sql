-- CreateEnum
CREATE TYPE "StreamStatus" AS ENUM ('SCHEDULED', 'LIVE', 'COMPLETED', 'CANCELLED', 'POSTPONED');

-- CreateEnum
CREATE TYPE "ScheduleType" AS ENUM ('interval', 'cron', 'once');

-- CreateEnum
CREATE TYPE "TaskRunStatus" AS ENUM ('success', 'error', 'running', 'pending', 'skipped');

-- CreateEnum
CREATE TYPE "TaskLogStatus" AS ENUM ('success', 'error');

-- CreateTable
CREATE TABLE "site_users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT,
    "image" TEXT,
    "role" TEXT NOT NULL DEFAULT 'user',
    "restricted" BOOLEAN NOT NULL DEFAULT false,
    "can_access_admin" BOOLEAN NOT NULL DEFAULT false,
    "can_access_tenant" BOOLEAN NOT NULL DEFAULT false,
    "avatar" TEXT,
    "color_light" VARCHAR(7),
    "color_dark" VARCHAR(7),
    "display_order" INTEGER,
    "timezone" TEXT DEFAULT 'UTC',
    "tenant_id" TEXT,
    "signup_tenant_id" TEXT,
    "is_suspended" BOOLEAN NOT NULL DEFAULT false,
    "suspended_at" TIMESTAMP(3),
    "suspended_by" TEXT,
    "suspension_reason" TEXT,
    "last_login_at" TIMESTAMP(3),
    "login_count" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "site_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_invites" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'admin',
    "invitedBy" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "usedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "tenant_id" TEXT,

    CONSTRAINT "admin_invites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "password_resets" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "usedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "password_resets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_verifications" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "usedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "email_verifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "token" TEXT NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_password_reset_tokens" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "used_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_password_reset_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "password" TEXT,
    "accessToken" TEXT,
    "refreshToken" TEXT,
    "idToken" TEXT,
    "expiresAt" TIMESTAMP(3),
    "accessTokenExpiresAt" TIMESTAMP(3),
    "scope" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verifications" (
    "id" TEXT NOT NULL,
    "identifier" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "verifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL,
    "adminId" TEXT,
    "action" TEXT NOT NULL,
    "resource" TEXT,
    "details" JSONB,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenant_id" TEXT,
    "resource_type" TEXT,
    "resource_id" TEXT,
    "user_role" TEXT,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "upload_log" (
    "id" TEXT NOT NULL,
    "filename" TEXT NOT NULL,
    "folderPath" TEXT NOT NULL,
    "fileType" TEXT NOT NULL,
    "fileSize" BIGINT NOT NULL,
    "blobUrl" TEXT NOT NULL,
    "adminUserId" TEXT NOT NULL,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "category" TEXT,
    "tags" TEXT[],

    CONSTRAINT "upload_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "widget_role_permissions" (
    "id" TEXT NOT NULL,
    "widgetId" TEXT NOT NULL,
    "roles" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "widget_role_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_dashboard_preferences" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "preferences" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_dashboard_preferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "tenantCode" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "longName" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "primaryColor" TEXT,
    "secondaryColor" TEXT,
    "backgroundColor" TEXT,
    "fontColor" TEXT,
    "fontFamily" TEXT,
    "favicon" TEXT,
    "logoMain" TEXT,
    "logoSmall" TEXT,
    "logoDark" TEXT,
    "logoLight" TEXT,
    "prizeIcons" JSONB,
    "socialMedia" JSONB,
    "streamingPlatforms" JSONB,
    "streamers" JSONB,
    "jsonFileUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customCancelledMessage" TEXT,
    "customLiveMessage" TEXT,
    "customNextMessage" TEXT,
    "customOfflineMessage" TEXT,
    "customStartingSoonMessage" TEXT,
    "gracePeriodAfterMinutes" INTEGER,
    "gracePeriodBeforeMinutes" INTEGER,
    "showOtherTenantsCalendars" BOOLEAN NOT NULL DEFAULT false,
    "streamDurationWarningHours" INTEGER,
    "timezone" TEXT NOT NULL DEFAULT 'UTC',
    "colorDark" TEXT,
    "colorLight" TEXT,

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_tenants" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "tenant_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "user_tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permissions" (
    "id" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "permission" TEXT NOT NULL,
    "is_allowed" BOOLEAN NOT NULL DEFAULT false,
    "description" TEXT,
    "category" TEXT,
    "modified_by" TEXT,
    "modified_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "global_settings" (
    "id" TEXT NOT NULL,
    "defaultLiveMessage" TEXT NOT NULL DEFAULT '🔴 LIVE NOW with {streamer}!',
    "defaultNextMessage" TEXT NOT NULL DEFAULT 'Next stream: {time} with {streamer}',
    "defaultOfflineMessage" TEXT NOT NULL DEFAULT 'No streams scheduled at this time',
    "defaultCancelledMessage" TEXT NOT NULL DEFAULT 'Stream cancelled: {reason}',
    "defaultStartingSoonMessage" TEXT NOT NULL DEFAULT '🎬 Starting soon: {streamer} goes live at {time}',
    "gracePeriodBeforeMinutes" INTEGER NOT NULL DEFAULT 15,
    "gracePeriodAfterMinutes" INTEGER NOT NULL DEFAULT 30,
    "streamDurationWarningHours" INTEGER NOT NULL DEFAULT 6,
    "archiveRetentionDays" INTEGER NOT NULL DEFAULT 90,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "default_timezone" TEXT NOT NULL DEFAULT 'UTC',

    CONSTRAINT "global_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stream_schedules" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "streamerName" TEXT NOT NULL,
    "startDateTime" TIMESTAMP(3) NOT NULL,
    "endDateTime" TIMESTAMP(3) NOT NULL,
    "isRecurring" BOOLEAN NOT NULL DEFAULT false,
    "rruleString" TEXT,
    "customLiveMessage" TEXT,
    "customNextMessage" TEXT,
    "customCancelledMessage" TEXT,
    "customStartingSoonMessage" TEXT,
    "status" "StreamStatus" NOT NULL DEFAULT 'SCHEDULED',
    "cancellationReason" TEXT,
    "archivedAt" TIMESTAMP(3),
    "archiveExportId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stream_schedules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "manual_overrides" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "streamerName" TEXT NOT NULL,
    "customMessage" TEXT,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "endedEarly" BOOLEAN NOT NULL DEFAULT false,
    "endedAt" TIMESTAMP(3),
    "createdById" TEXT,

    CONSTRAINT "manual_overrides_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "archive_exports" (
    "id" TEXT NOT NULL,
    "blobUrl" TEXT NOT NULL,
    "recordCount" INTEGER NOT NULL,
    "dateRangeStart" TIMESTAMP(3) NOT NULL,
    "dateRangeEnd" TIMESTAMP(3) NOT NULL,
    "fileSize" BIGINT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "archive_exports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pages" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "topic" TEXT,
    "parentPageId" TEXT,
    "blocksJson" JSONB NOT NULL DEFAULT '[]',
    "searchableText" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "versionNumber" INTEGER NOT NULL DEFAULT 1,
    "metaTitle" TEXT,
    "metaDescription" TEXT,
    "keywords" TEXT,
    "ogTitle" TEXT,
    "ogDescription" TEXT,
    "ogImageUrl" TEXT,
    "twitterCardType" TEXT DEFAULT 'summary',
    "twitterTitle" TEXT,
    "twitterDescription" TEXT,
    "twitterImageUrl" TEXT,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "tenantAssignment" JSONB NOT NULL DEFAULT '"all"',
    "publishFromDate" TIMESTAMP(3),
    "lastPublishedAt" TIMESTAMP(3),
    "lastAutoSaveAt" TIMESTAMP(3),
    "lastManualSaveAt" TIMESTAMP(3),
    "hasUnsavedChanges" BOOLEAN NOT NULL DEFAULT false,
    "createdBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "page_versions" (
    "id" TEXT NOT NULL,
    "pageId" TEXT NOT NULL,
    "versionNumber" INTEGER NOT NULL,
    "pageData" TEXT NOT NULL,
    "metadataSnapshot" TEXT NOT NULL,
    "originalSize" INTEGER NOT NULL,
    "createdBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "page_versions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "published_pages" (
    "id" TEXT NOT NULL,
    "pageId" TEXT NOT NULL,
    "tenantId" TEXT,
    "slug" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "topic" TEXT,
    "contentUrl" TEXT NOT NULL,
    "hierarchyData" JSONB NOT NULL,
    "publishFromDate" TIMESTAMP(3),
    "publishedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "published_pages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scheduled_tasks" (
    "id" TEXT NOT NULL,
    "taskKey" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "description" TEXT,
    "scheduleType" "ScheduleType" NOT NULL,
    "scheduleConfig" JSONB NOT NULL,
    "taskPayload" JSONB NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "paused" BOOLEAN NOT NULL DEFAULT false,
    "last_run_at" TIMESTAMP(3),
    "last_run_status" "TaskRunStatus" NOT NULL DEFAULT 'pending',
    "last_run_message" TEXT,
    "last_run_duration" INTEGER,
    "next_run_at" TIMESTAMP(3),
    "error_count" INTEGER NOT NULL DEFAULT 0,
    "last_error_at" TIMESTAMP(3),
    "last_error_message" TEXT,
    "createdBy" TEXT NOT NULL,
    "created_by_id" TEXT NOT NULL,
    "updated_by" TEXT,
    "updated_by_id" TEXT,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" TEXT,
    "deleted_by_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "scheduled_tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scheduled_task_logs" (
    "id" TEXT NOT NULL,
    "task_id" TEXT NOT NULL,
    "run_started_at" TIMESTAMP(3) NOT NULL,
    "run_finished_at" TIMESTAMP(3),
    "status" "TaskLogStatus" NOT NULL,
    "message" TEXT NOT NULL,
    "error_stack" TEXT,
    "duration_ms" INTEGER,
    "run_by_system" BOOLEAN NOT NULL DEFAULT false,
    "run_triggered_by" TEXT,
    "run_triggered_by_id" TEXT,
    "run_triggered_by_role" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "scheduled_task_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "site_users_email_key" ON "site_users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "site_users_color_light_unique" ON "site_users"("color_light");

-- CreateIndex
CREATE UNIQUE INDEX "site_users_color_dark_unique" ON "site_users"("color_dark");

-- CreateIndex
CREATE INDEX "site_users_tenant_id_idx" ON "site_users"("tenant_id");

-- CreateIndex
CREATE INDEX "site_users_signup_tenant_id_idx" ON "site_users"("signup_tenant_id");

-- CreateIndex
CREATE INDEX "site_users_role_idx" ON "site_users"("role");

-- CreateIndex
CREATE INDEX "site_users_color_light_idx" ON "site_users"("color_light");

-- CreateIndex
CREATE INDEX "site_users_color_dark_idx" ON "site_users"("color_dark");

-- CreateIndex
CREATE INDEX "site_users_can_access_admin_idx" ON "site_users"("can_access_admin");

-- CreateIndex
CREATE INDEX "site_users_can_access_tenant_idx" ON "site_users"("can_access_tenant");

-- CreateIndex
CREATE INDEX "site_users_is_suspended_idx" ON "site_users"("is_suspended");

-- CreateIndex
CREATE INDEX "site_users_last_login_at_idx" ON "site_users"("last_login_at");

-- CreateIndex
CREATE UNIQUE INDEX "admin_invites_token_key" ON "admin_invites"("token");

-- CreateIndex
CREATE INDEX "admin_invites_email_idx" ON "admin_invites"("email");

-- CreateIndex
CREATE INDEX "admin_invites_token_idx" ON "admin_invites"("token");

-- CreateIndex
CREATE INDEX "admin_invites_tenant_id_idx" ON "admin_invites"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "password_resets_token_key" ON "password_resets"("token");

-- CreateIndex
CREATE INDEX "password_resets_email_idx" ON "password_resets"("email");

-- CreateIndex
CREATE INDEX "password_resets_token_idx" ON "password_resets"("token");

-- CreateIndex
CREATE UNIQUE INDEX "email_verifications_token_key" ON "email_verifications"("token");

-- CreateIndex
CREATE INDEX "email_verifications_email_idx" ON "email_verifications"("email");

-- CreateIndex
CREATE INDEX "email_verifications_token_idx" ON "email_verifications"("token");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_token_key" ON "sessions"("token");

-- CreateIndex
CREATE UNIQUE INDEX "user_password_reset_tokens_token_key" ON "user_password_reset_tokens"("token");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_token_idx" ON "user_password_reset_tokens"("token");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_user_id_idx" ON "user_password_reset_tokens"("user_id");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_expires_at_idx" ON "user_password_reset_tokens"("expires_at");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_providerId_accountId_key" ON "accounts"("providerId", "accountId");

-- CreateIndex
CREATE UNIQUE INDEX "verifications_identifier_value_key" ON "verifications"("identifier", "value");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "audit_logs"("action");

-- CreateIndex
CREATE INDEX "audit_logs_createdAt_idx" ON "audit_logs"("createdAt");

-- CreateIndex
CREATE INDEX "audit_logs_resource_id_idx" ON "audit_logs"("resource_id");

-- CreateIndex
CREATE INDEX "audit_logs_tenant_id_idx" ON "audit_logs"("tenant_id");

-- CreateIndex
CREATE INDEX "upload_log_adminUserId_idx" ON "upload_log"("adminUserId");

-- CreateIndex
CREATE INDEX "upload_log_folderPath_idx" ON "upload_log"("folderPath");

-- CreateIndex
CREATE INDEX "upload_log_uploadedAt_idx" ON "upload_log"("uploadedAt");

-- CreateIndex
CREATE INDEX "upload_log_category_idx" ON "upload_log"("category");

-- CreateIndex
CREATE UNIQUE INDEX "widget_role_permissions_widgetId_key" ON "widget_role_permissions"("widgetId");

-- CreateIndex
CREATE INDEX "widget_role_permissions_widgetId_idx" ON "widget_role_permissions"("widgetId");

-- CreateIndex
CREATE UNIQUE INDEX "user_dashboard_preferences_userId_key" ON "user_dashboard_preferences"("userId");

-- CreateIndex
CREATE INDEX "user_dashboard_preferences_userId_idx" ON "user_dashboard_preferences"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_tenantCode_key" ON "tenants"("tenantCode");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_url_key" ON "tenants"("url");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_colorDark_key" ON "tenants"("colorDark");

-- CreateIndex
CREATE UNIQUE INDEX "tenants_colorLight_key" ON "tenants"("colorLight");

-- CreateIndex
CREATE INDEX "tenants_name_idx" ON "tenants"("name");

-- CreateIndex
CREATE INDEX "tenants_tenantCode_idx" ON "tenants"("tenantCode");

-- CreateIndex
CREATE INDEX "tenants_url_idx" ON "tenants"("url");

-- CreateIndex
CREATE INDEX "user_tenants_user_id_idx" ON "user_tenants"("user_id");

-- CreateIndex
CREATE INDEX "user_tenants_tenant_id_idx" ON "user_tenants"("tenant_id");

-- CreateIndex
CREATE INDEX "user_tenants_is_active_idx" ON "user_tenants"("is_active");

-- CreateIndex
CREATE UNIQUE INDEX "user_tenants_user_id_tenant_id_key" ON "user_tenants"("user_id", "tenant_id");

-- CreateIndex
CREATE INDEX "role_permissions_role_idx" ON "role_permissions"("role");

-- CreateIndex
CREATE INDEX "role_permissions_permission_idx" ON "role_permissions"("permission");

-- CreateIndex
CREATE UNIQUE INDEX "role_permissions_role_permission_key" ON "role_permissions"("role", "permission");

-- CreateIndex
CREATE INDEX "stream_schedules_tenantId_idx" ON "stream_schedules"("tenantId");

-- CreateIndex
CREATE INDEX "stream_schedules_startDateTime_idx" ON "stream_schedules"("startDateTime");

-- CreateIndex
CREATE INDEX "stream_schedules_status_idx" ON "stream_schedules"("status");

-- CreateIndex
CREATE INDEX "stream_schedules_archivedAt_idx" ON "stream_schedules"("archivedAt");

-- CreateIndex
CREATE INDEX "manual_overrides_tenantId_idx" ON "manual_overrides"("tenantId");

-- CreateIndex
CREATE INDEX "manual_overrides_startedAt_idx" ON "manual_overrides"("startedAt");

-- CreateIndex
CREATE INDEX "manual_overrides_endsAt_idx" ON "manual_overrides"("endsAt");

-- CreateIndex
CREATE INDEX "archive_exports_createdAt_idx" ON "archive_exports"("createdAt");

-- CreateIndex
CREATE INDEX "pages_slug_idx" ON "pages"("slug");

-- CreateIndex
CREATE INDEX "pages_topic_idx" ON "pages"("topic");

-- CreateIndex
CREATE INDEX "pages_status_idx" ON "pages"("status");

-- CreateIndex
CREATE INDEX "pages_parentPageId_idx" ON "pages"("parentPageId");

-- CreateIndex
CREATE INDEX "pages_order_idx" ON "pages"("order");

-- CreateIndex
CREATE INDEX "page_versions_pageId_idx" ON "page_versions"("pageId");

-- CreateIndex
CREATE UNIQUE INDEX "page_versions_pageId_versionNumber_key" ON "page_versions"("pageId", "versionNumber");

-- CreateIndex
CREATE INDEX "published_pages_tenantId_idx" ON "published_pages"("tenantId");

-- CreateIndex
CREATE INDEX "published_pages_slug_idx" ON "published_pages"("slug");

-- CreateIndex
CREATE INDEX "published_pages_order_idx" ON "published_pages"("order");

-- CreateIndex
CREATE UNIQUE INDEX "published_pages_pageId_tenantId_key" ON "published_pages"("pageId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "scheduled_tasks_taskKey_key" ON "scheduled_tasks"("taskKey");

-- CreateIndex
CREATE INDEX "scheduled_tasks_active_idx" ON "scheduled_tasks"("active");

-- CreateIndex
CREATE INDEX "scheduled_tasks_paused_idx" ON "scheduled_tasks"("paused");

-- CreateIndex
CREATE INDEX "scheduled_tasks_next_run_at_idx" ON "scheduled_tasks"("next_run_at");

-- CreateIndex
CREATE INDEX "scheduled_tasks_created_at_idx" ON "scheduled_tasks"("created_at");

-- CreateIndex
CREATE INDEX "scheduled_tasks_taskKey_idx" ON "scheduled_tasks"("taskKey");

-- CreateIndex
CREATE INDEX "scheduled_tasks_last_run_status_idx" ON "scheduled_tasks"("last_run_status");

-- CreateIndex
CREATE INDEX "scheduled_task_logs_task_id_idx" ON "scheduled_task_logs"("task_id");

-- CreateIndex
CREATE INDEX "scheduled_task_logs_status_idx" ON "scheduled_task_logs"("status");

-- CreateIndex
CREATE INDEX "scheduled_task_logs_created_at_idx" ON "scheduled_task_logs"("created_at");

-- AddForeignKey
ALTER TABLE "site_users" ADD CONSTRAINT "site_users_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "site_users" ADD CONSTRAINT "site_users_signup_tenant_id_fkey" FOREIGN KEY ("signup_tenant_id") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin_invites" ADD CONSTRAINT "admin_invites_invitedBy_fkey" FOREIGN KEY ("invitedBy") REFERENCES "site_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_password_reset_tokens" ADD CONSTRAINT "user_password_reset_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "site_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_dashboard_preferences" ADD CONSTRAINT "user_dashboard_preferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_tenants" ADD CONSTRAINT "user_tenants_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_tenants" ADD CONSTRAINT "user_tenants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stream_schedules" ADD CONSTRAINT "stream_schedules_archiveExportId_fkey" FOREIGN KEY ("archiveExportId") REFERENCES "archive_exports"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stream_schedules" ADD CONSTRAINT "stream_schedules_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "manual_overrides" ADD CONSTRAINT "manual_overrides_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "tenants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pages" ADD CONSTRAINT "pages_parentPageId_fkey" FOREIGN KEY ("parentPageId") REFERENCES "pages"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "page_versions" ADD CONSTRAINT "page_versions_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "pages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_tasks" ADD CONSTRAINT "scheduled_tasks_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "site_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_tasks" ADD CONSTRAINT "scheduled_tasks_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "site_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_tasks" ADD CONSTRAINT "scheduled_tasks_deleted_by_id_fkey" FOREIGN KEY ("deleted_by_id") REFERENCES "site_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_task_logs" ADD CONSTRAINT "scheduled_task_logs_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "scheduled_tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scheduled_task_logs" ADD CONSTRAINT "scheduled_task_logs_run_triggered_by_id_fkey" FOREIGN KEY ("run_triggered_by_id") REFERENCES "site_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
