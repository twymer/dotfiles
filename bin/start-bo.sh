 #!/bin/sh
  osascript <<-eof
  tell application "iTerm"
    set myterm to (make new terminal)
    set bodir to "cd ~/code/dbc/tech/backoffice && clear"
    set identitydir to "cd ~/code/dbc/tech/identity && clear"

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
        set name to "fe"
        write text bodir
        write text "be rake fe:watch"
      end tell

      launch session "Default session"
      tell the last session
        set name to "identity"
        write text identitydir
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
