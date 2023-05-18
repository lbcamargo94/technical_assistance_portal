/*
  Warnings:

  - You are about to drop the `organization` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `permission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `privilege` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `routine` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "accesses" DROP CONSTRAINT "accesses_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "accesses" DROP CONSTRAINT "accesses_routinesId_fkey";

-- DropForeignKey
ALTER TABLE "organization" DROP CONSTRAINT "organization_profilesId_fkey";

-- DropForeignKey
ALTER TABLE "privilege" DROP CONSTRAINT "privilege_accessLevelId_fkey";

-- DropForeignKey
ALTER TABLE "privilege" DROP CONSTRAINT "privilege_profilesId_fkey";

-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "user_accessLevelId_fkey";

-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "user_organizationsId_fkey";

-- DropTable
DROP TABLE "organization";

-- DropTable
DROP TABLE "permission";

-- DropTable
DROP TABLE "privilege";

-- DropTable
DROP TABLE "profile";

-- DropTable
DROP TABLE "routine";

-- DropTable
DROP TABLE "user";

-- CreateTable
CREATE TABLE "organizations" (
    "id" UUID NOT NULL,
    "address" VARCHAR(100) NOT NULL,
    "blocked" BOOLEAN NOT NULL DEFAULT false,
    "cep" VARCHAR(8) NOT NULL,
    "cpf_cnpj" VARCHAR(14) NOT NULL,
    "contact" VARCHAR(15) NOT NULL,
    "name" VARCHAR(150) NOT NULL,
    "nickname" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "profilesId" UUID NOT NULL,

    CONSTRAINT "organizations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "blocked" BOOLEAN NOT NULL DEFAULT false,
    "login" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "firstName" VARCHAR(100) NOT NULL,
    "lastName" VARCHAR(100) NOT NULL,
    "password" VARCHAR(65) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "organizationsId" UUID NOT NULL,
    "accessLevelId" UUID NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "id" UUID NOT NULL,
    "zipCode" VARCHAR(8) NOT NULL,
    "state" VARCHAR(100) NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "neighborhood" VARCHAR(100) NOT NULL,
    "street" VARCHAR(100) NOT NULL,
    "houseNumber" VARCHAR(100) NOT NULL,
    "complement" VARCHAR(100) NOT NULL,
    "mainAddress" BOOLEAN NOT NULL DEFAULT false,
    "deliveryAddress" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" UUID NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "routines" (
    "id" UUID NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "routines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" UUID NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "privileges" (
    "id" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "profilesId" UUID NOT NULL,
    "accessLevelId" UUID NOT NULL,

    CONSTRAINT "privileges_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "organizations_id_key" ON "organizations"("id");

-- CreateIndex
CREATE UNIQUE INDEX "organizations_cpf_cnpj_key" ON "organizations"("cpf_cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "organizations_name_key" ON "organizations"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_id_key" ON "users"("id");

-- CreateIndex
CREATE UNIQUE INDEX "users_login_key" ON "users"("login");

-- CreateIndex
CREATE UNIQUE INDEX "address_id_key" ON "address"("id");

-- CreateIndex
CREATE UNIQUE INDEX "profiles_id_key" ON "profiles"("id");

-- CreateIndex
CREATE UNIQUE INDEX "profiles_name_key" ON "profiles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "routines_id_key" ON "routines"("id");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_id_key" ON "permissions"("id");

-- CreateIndex
CREATE UNIQUE INDEX "privileges_id_key" ON "privileges"("id");

-- AddForeignKey
ALTER TABLE "organizations" ADD CONSTRAINT "organizations_profilesId_fkey" FOREIGN KEY ("profilesId") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_organizationsId_fkey" FOREIGN KEY ("organizationsId") REFERENCES "organizations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_accessLevelId_fkey" FOREIGN KEY ("accessLevelId") REFERENCES "access_level"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accesses" ADD CONSTRAINT "accesses_routinesId_fkey" FOREIGN KEY ("routinesId") REFERENCES "routines"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "accesses" ADD CONSTRAINT "accesses_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "privileges" ADD CONSTRAINT "privileges_profilesId_fkey" FOREIGN KEY ("profilesId") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "privileges" ADD CONSTRAINT "privileges_accessLevelId_fkey" FOREIGN KEY ("accessLevelId") REFERENCES "access_level"("id") ON DELETE CASCADE ON UPDATE CASCADE;
