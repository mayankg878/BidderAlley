CREATE TABLE "Item" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "utility" INTEGER NOT NULL,
    "basePrice" INTEGER NOT NULL,
    "soldPrice" INTEGER,
    "soldTo" TEXT,
    "status" TEXT NOT NULL DEFAULT 'available',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Bidder" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "initialBudget" INTEGER NOT NULL,
    "remainingBudget" INTEGER NOT NULL DEFAULT 0,
    "totalUtility" INTEGER NOT NULL DEFAULT 0,
    "isQualified" BOOLEAN NOT NULL DEFAULT false,
    "hostelsCount" INTEGER NOT NULL DEFAULT 0,
    "clubsCount" INTEGER NOT NULL DEFAULT 0,
    "datingCount" INTEGER NOT NULL DEFAULT 0,
    "friendsCount" INTEGER NOT NULL DEFAULT 0,
    "totalItems" INTEGER NOT NULL DEFAULT 0,
    "hostelsUtility" INTEGER NOT NULL DEFAULT 0,
    "clubsUtility" INTEGER NOT NULL DEFAULT 0,
    "datingUtility" INTEGER NOT NULL DEFAULT 0,
    "friendsUtility" INTEGER NOT NULL DEFAULT 0,
    "hostelsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "clubsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "datingMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "friendsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "wildcardsCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Bidder_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Wildcard" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "bidderId" TEXT NOT NULL,
    "hostelsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "clubsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "datingMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "friendsMultiplier" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "countsAsTheme" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Wildcard_pkey" PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "Bidder_name_key" ON "Bidder"("name");
CREATE INDEX "Item_category_idx" ON "Item"("category");
CREATE INDEX "Item_status_idx" ON "Item"("status");
CREATE INDEX "Bidder_name_idx" ON "Bidder"("name");
CREATE INDEX "Bidder_isQualified_idx" ON "Bidder"("isQualified");
CREATE INDEX "Bidder_totalUtility_idx" ON "Bidder"("totalUtility");
CREATE INDEX "Wildcard_bidderId_idx" ON "Wildcard"("bidderId");

-- Foreign Keys
ALTER TABLE "Item" ADD CONSTRAINT "Item_soldTo_fkey" 
    FOREIGN KEY ("soldTo") REFERENCES "Bidder"("id") 
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Wildcard" ADD CONSTRAINT "Wildcard_bidderId_fkey" 
    FOREIGN KEY ("bidderId") REFERENCES "Bidder"("id") 
    ON DELETE RESTRICT ON UPDATE CASCADE;