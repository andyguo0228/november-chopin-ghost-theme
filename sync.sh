#!/bin/bash

# Quick sync script for theme development
echo "🔄 Syncing theme files to Ghost..."
rsync -av --exclude='.git' --exclude='node_modules' --exclude='*.log' /Users/Nightwing/coding_projects/november-chopin-ghost-theme/ /Users/Nightwing/coding_projects/local-ghost/content/themes/november_chopin/

echo "✅ Theme files synced!"
echo "🔄 Restart Ghost to see changes or just refresh your browser"