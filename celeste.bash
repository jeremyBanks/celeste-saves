#!/bin/bash -euo pipefail

function celeste {
    cd ~/Library/"Application Support"/Celeste/Saves;
    
    git commit -m "" --allow-empty-message &> /dev/null &&
        echo "Committed old partially saved changes.";

    git commit . -m "" --allow-empty-message &> /dev/null &&
        echo "Committed old unsaved changes.";

    git fetch  &> /dev/null;

    git pull --ff-only || (
      echo "Sync conflict. Archiving remote data and replacing with local." && git pull -s ours);

    git push 2&> /dev/null;

    open -W ~/Library/"Application Support"/itch/apps/celeste/Celeste.app || open -W /Applications/Celeste.app;
    
    git commit . -m "" --allow-empty-message &> /dev/null &&
        echo "Committed new changes." || echo "No changes to commit.";

    git push;

    cd - 2&> /dev/null;
}

celeste;
