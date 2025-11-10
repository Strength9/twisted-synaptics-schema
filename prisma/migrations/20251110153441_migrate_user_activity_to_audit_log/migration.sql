-- Migrate data from user_activity_logs to audit_log
-- This migration transfers all user activity log entries to the unified audit_log table
-- as part of the unified logging architecture migration.

-- Insert all user_activity_logs into audit_log
-- Note: The audit_logs table uses camelCase column names (adminId, userRole, createdAt, etc)
-- while the migration added snake_case aliases (user_id, ip_address, user_agent)

INSERT INTO audit_logs (
  id,
  "adminId",
  "user_id",
  email,
  action,
  resource,
  "resource_type",
  "resource_id",
  details,
  "ip_address",
  "user_agent",
  "user_role",
  "createdAt",
  "tenant_id"
)
SELECT
  id,
  NULL,
  "userId",
  email,
  action,
  resource,
  resource_type,
  resource_id,
  details,
  ip_address,
  user_agent,
  NULL,
  created_at,
  NULL
FROM user_activity_logs
ON CONFLICT (id) DO NOTHING;
