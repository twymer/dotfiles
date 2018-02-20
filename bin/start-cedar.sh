 #!/bin/sh
  osascript <<-eof
  tell application "iTerm"
    set myterm to (make new terminal)
    set cedardir to "cd ~/code/work/cedar && clear"

    tell myterm
      launch session "Default session"
      tell the last session
        set name to "editor"
        write text cedardir
        write text "vim"
      end tell

      launch session "Default session"
      tell the last session
        set name to "docker"
        write text cedardir
        write text "docker-compose up"
      end tell

      launch session "Default session"
      tell the last session
        set name to "bash"
        write text cedardir
      end tell

      launch session "Default session"
      tell the last session
        set name to "shell"
        write text cedardir
      end tell

      launch session "Default session"
      tell the last session
        set name to "terminal"
        write text cedardir
      end tell

    end tell
  end tell
eof
