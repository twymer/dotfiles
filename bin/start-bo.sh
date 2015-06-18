 #!/bin/sh
  osascript <<-eof
  tell application "iTerm"
    set myterm to (make new terminal)
    set bodir to "cd ~/code/dbc/tech/backoffice && clear"
    set ssodir to "cd ~/code/dbc/tech/sso && clear"

    tell myterm
      launch session "Default session"
      tell the last session
        set name to "editor"
        write text bodir
        write text "vim"
      end tell

      launch session "Default session"
      tell the last session
        set name to "tests"
        write text bodir
      end tell

      launch session "Default session"
      tell the last session
        set name to "backoffice"
        write text bodir
        write text "powder link"
        write text "powder applog"
      end tell

      launch session "Default session"
      tell the last session
        set name to "gulp"
        write text bodir
        write text "gulp"
      end tell

      launch session "Default session"
      tell the last session
        set name to "sso"
        write text ssodir
        write text "powder link"
      end tell

      launch session "Default session"
      tell the last session
        set name to "redis"
        write text bodir
        write text "redis-server"
      end tell

    end tell
  end tell
eof
