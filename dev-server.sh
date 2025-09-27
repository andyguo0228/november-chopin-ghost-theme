#!/bin/bash

# Ghost Theme Development Script
# This script sets up a development environment with live reloading

echo "🚀 Starting Ghost Theme Development Environment"

# Function to cleanup background processes
cleanup() {
    echo "🛑 Stopping development processes..."
    kill $(jobs -p) 2>/dev/null
    exit 0
}

# Trap Ctrl+C and call cleanup
trap cleanup INT

# Start Ghost in the background
echo "📂 Starting Ghost server..."
cd /Users/Nightwing/coding_projects/local-ghost
NODE_ENV=development node current/index.js &
GHOST_PID=$!

# Wait a moment for Ghost to start
sleep 3

# Start theme build watcher
echo "👀 Starting theme build watcher..."
cd /Users/Nightwing/coding_projects/november-chopin-ghost-theme
npm run dev &
BUILD_PID=$!

# Start file sync watcher
echo "🔄 Starting file sync watcher..."
fswatch -o . | while read f; do
    echo "📁 Files changed, syncing to Ghost..."
    rsync -av --exclude='.git' --exclude='node_modules' --exclude='*.log' . ../local-ghost/content/themes/november_chopin/
done &
SYNC_PID=$!

echo ""
echo "✅ Development environment ready!"
echo "🌐 Ghost is running at: http://localhost:2368"
echo "📝 Edit your theme files and see changes live!"
echo ""
echo "Press Ctrl+C to stop all processes"

# Wait for all background processes
wait