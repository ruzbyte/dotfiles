import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

IconImage {
    id: root
    
    property string appId: ""
    property string resolvedSource: ""
    
    // Use resolved source if available, otherwise fallback to theme lookup
    source: resolvedSource !== "" ? resolvedSource : (appId ? "image://theme/" + appId.toLowerCase() : "")

    onAppIdChanged: {
        // console.log("ActiveWindowIcon: appId changed to", appId);
        resolvedSource = ""; // Reset resolved source
        if (appId !== "") {
            iconFinder.running = false;
            restartTimer.restart();
        }
    }

    Timer {
        id: restartTimer
        interval: 10
        onTriggered: {
            iconFinder.running = true;
        }
    }

    Process {
        id: iconFinder
        
        command: ["bash", "-c", 
            "APP_ID=\"" + root.appId + "\"; " +
            "ICON=\"\"; " +
            "# 1. Try to find desktop file and extract Icon\n" +
            "DIRS=\"$HOME/.local/share/applications /usr/share/applications /usr/local/share/applications /var/lib/flatpak/exports/share/applications\"; " +
            "for dir in $DIRS; do " +
            "  if [ -f \"$dir/$APP_ID.desktop\" ]; then " +
            "    ICON=$(grep \"^Icon=\" \"$dir/$APP_ID.desktop\" | head -n 1 | cut -d= -f2); " +
            "  elif [ -f \"$dir/$(echo \"$APP_ID\" | tr '[:upper:]' '[:lower:]').desktop\" ]; then " +
            "    ICON=$(grep \"^Icon=\" \"$dir/$(echo \"$APP_ID\" | tr '[:upper:]' '[:lower:]').desktop\" | head -n 1 | cut -d= -f2); " +
            "  fi; " +
            "  if [ -n \"$ICON\" ]; then break; fi; " +
            "done; " +
            "# 2. If no icon from desktop file, use App ID as icon name\n" +
            "if [ -z \"$ICON\" ]; then ICON=\"$APP_ID\"; fi; " +
            "# 3. Resolve Icon path\n" +
            "if [ -n \"$ICON\" ]; then " +
            "  if [[ \"$ICON\" == /* ]]; then echo \"$ICON\"; exit 0; fi; " +
            "  # Check common paths for the icon file\n" +
            "  SEARCH_PATHS=\"/usr/share/icons/hicolor /usr/share/pixmaps $HOME/.local/share/icons\"; " +
            "  # Try exact match first in scalable/apps and 48x48/apps (common)\n" +
            "  for path in $SEARCH_PATHS; do " +
            "    if [ -f \"$path/scalable/apps/$ICON.svg\" ]; then echo \"$path/scalable/apps/$ICON.svg\"; exit 0; fi; " +
            "    if [ -f \"$path/48x48/apps/$ICON.png\" ]; then echo \"$path/48x48/apps/$ICON.png\"; exit 0; fi; " +
            "    if [ -f \"$path/$ICON.png\" ]; then echo \"$path/$ICON.png\"; exit 0; fi; " +
            "    if [ -f \"$path/$ICON.svg\" ]; then echo \"$path/$ICON.svg\"; exit 0; fi; " +
            "  done; " +
            "  # Fallback to find (slower but comprehensive)\n" +
            "  FOUND=$(find $SEARCH_PATHS -name \"$ICON.png\" -o -name \"$ICON.svg\" -o -name \"$ICON.xpm\" 2>/dev/null | head -n 1); " +
            "  if [ -n \"$FOUND\" ]; then echo \"$FOUND\"; exit 0; fi; " +
            "  # If still not found, echo the name so we at least try theme lookup (even if it fails)\n" +
            "  echo \"$ICON\"; " +
            "fi"
        ]
        
        running: false
        
        stdout: StdioCollector {
            onStreamFinished: {
                var icon = this.text.trim();
                // console.log("ActiveWindowIcon: Process stdout: '" + icon + "'");
                if (icon !== "") {
                    if (icon.startsWith("/")) {
                        root.resolvedSource = "file://" + icon;
                    } else {
                        root.resolvedSource = "image://theme/" + icon;
                    }
                }
            }
        }
    }
}
