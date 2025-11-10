-- AlterTable
ALTER TABLE "scheduled_tasks" ADD COLUMN     "execution_order" INTEGER NOT NULL DEFAULT 100;
