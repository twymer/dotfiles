 #!/bin/sh
  osascript <<-eof
  tell application "iTerm"
    set myterm to (make new terminal)
    set cdhqdir to "cd ~/code/dimagi/commcare-hq"
    tell myterm
      launch session "Default session"
      tell the last session
        write text "elasticsearch"
        write text "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
        write text "exit"
      end tell

      launch session "Default session"
      tell the last session
        set name to "editor"
        write text cdhqdir
        write text "vim"
      end tell

      launch session "Default session"
      tell the last session
        set name to "server"
        write text cdhqdir
        write text "sourcehq"
        write text "./manage.py runserver"
      end tell

      launch session "Default session"
      tell the last session
        set name to "couch"
        write text "couchdb"
      end tell

      launch session "Default session"
      tell the last session
        set name to "ptop"
        write text cdhqdir
        write text "sourcehq"
        write text "./manage.py run_ptop --all"
      end tell

      launch session "Default session"
      tell the last session
        set name to "celery"
        write text cdhqdir
        write text "sourcehq"
        write text "./manage.py celeryd -P gevent --verbosity=2 --beat --statedb=celery.db --events"
      end tell

      launch session "Default session"
      tell the last session
        set name to "redis"
        write text "redis-server"
      end tell
    end tell
  end tell
eof
