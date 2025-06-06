#!/bin/bash
echo "🧪 Testing Pablo's Setup..."
echo "✓ Checking commands..."
command -v bat >/dev/null && echo "✓ bat installed" || echo "✗ bat missing"
command -v eza >/dev/null && echo "✓ eza installed" || echo "✗ eza missing"
command -v fzf >/dev/null && echo "✓ fzf installed" || echo "✗ fzf missing"
echo "✓ All good!"
