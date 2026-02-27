#!/bin/sh
set -e

echo "🚀 Starting Auction App..."

# Ensure data directory exists
mkdir -p /app/data

# Fix permissions properly (force)
chmod -R 777 /app/data

# Set DATABASE_URL explicitly
export DATABASE_URL="file:/app/data/dev.db"

echo "📦 Syncing database schema..."

# Run as nextjs user
su-exec nextjs sh -c "
export DATABASE_URL=file:/app/data/dev.db
npx prisma db push --skip-generate
npx tsx prisma/seed.ts || true
"

echo "🎯 Starting Next.js server..."
exec su-exec nextjs "$@"
