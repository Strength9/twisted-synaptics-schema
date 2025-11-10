-- AlterTable
ALTER TABLE "site_users" ADD COLUMN     "is_suspended" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "last_login_at" TIMESTAMP(3),
ADD COLUMN     "login_count" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "signup_tenant_id" TEXT,
ADD COLUMN     "suspended_at" TIMESTAMP(3),
ADD COLUMN     "suspended_by" TEXT,
ADD COLUMN     "suspension_reason" TEXT;

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

-- CreateIndex
CREATE UNIQUE INDEX "user_password_reset_tokens_token_key" ON "user_password_reset_tokens"("token");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_token_idx" ON "user_password_reset_tokens"("token");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_user_id_idx" ON "user_password_reset_tokens"("user_id");

-- CreateIndex
CREATE INDEX "user_password_reset_tokens_expires_at_idx" ON "user_password_reset_tokens"("expires_at");

-- CreateIndex
CREATE INDEX "site_users_signup_tenant_id_idx" ON "site_users"("signup_tenant_id");

-- CreateIndex
CREATE INDEX "site_users_is_suspended_idx" ON "site_users"("is_suspended");

-- CreateIndex
CREATE INDEX "site_users_last_login_at_idx" ON "site_users"("last_login_at");

-- AddForeignKey
ALTER TABLE "site_users" ADD CONSTRAINT "site_users_signup_tenant_id_fkey" FOREIGN KEY ("signup_tenant_id") REFERENCES "tenants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_password_reset_tokens" ADD CONSTRAINT "user_password_reset_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "site_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
