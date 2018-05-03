 #!/bin/sh
  osascript <<-eof
  tell application "iTerm"
    set cedardir to "cd ~/code/work/cedar && clear"

    tell current window
      create window with default profile
      tell current session
        set name to "editor"
        write text cedardir
      end tell
    end tell

    tell current window
      create tab with default profile
      tell current session
        set name to "docker"
        write text cedardir
        write text "cedar_exports"
        write text "docker-compose up"
      end tell
    end tell

    tell current window
      create tab with default profile
      tell current session
        set name to "bash"
        write text cedardir
      end tell
    end tell

    tell current window
      create tab with default profile
      tell current session
        set name to "shell"
        write text cedardir
      end tell
    end tell

    tell current window
      create tab with default profile
      tell current session
        set name to "terminal"
        write text cedardir
      end tell
    end tell
  end tell
eof
