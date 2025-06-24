#!/bin/bash

echo "==============================="
echo "📦 Top 15 Largest Folders in ~"
echo "==============================="
du -sh ~/* 2>/dev/null | sort -hr | head -15

echo ""
echo "=============================================="
echo "🗂 Top 15 Largest Folders in /System/Volumes/Data"
echo "=============================================="
sudo du -sh /System/Volumes/Data/* 2>/dev/null | sort -hr | head -15

echo ""
echo "==============================="
echo "🧱 Top 15 Largest Files (>500MB)"
echo "==============================="
sudo find / -type f -size +500M -exec ls -lh {} \; 2>/dev/null | sort -k 5 -hr | head -15

echo ""
echo "==============================="
echo "🧹 User Cache Folder Sizes"
echo "==============================="
du -sh ~/Library/Caches/* 2>/dev/null | sort -hr | head -10

echo ""
echo "==============================="
echo "🗑 Trash Folder Size"
echo "==============================="
du -sh ~/.Trash 2>/dev/null

echo ""
echo "==============================="
echo "✅ Recommendations:"
echo "==============================="
echo "- Run: rm -rf ~/Library/Caches/*"
echo "- Run: sudo rm -rf /Library/Caches/*"
echo "- Run: rm -rf ~/.Trash/*"
echo "- Check ~/Downloads, ~/Movies, ~/Documents for large files"
echo "- Optional: brew install --cask grandperspective for visual analysis"

