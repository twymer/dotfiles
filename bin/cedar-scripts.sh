function manage_api {
  # Pass anything called after `manage_api` along to manage.py.
  # Example:
  # $ manage_api nukedb
  docker-compose run cedar-api ./manage.py "$@"
}

function fast_reset_db {
  docker-compose kill cedar-db
  docker-compose rm -f cedar-db
  docker-compose up -d cedar-db
}

function fast_reset_seed {
  fast_reset_db
  _migrate
  _fixtures
  _success "Cedar DB is reset and seeded"
}

function seed_tests {
  _seed
  _success "Cedar DB is fully seeded"
}

function reset_db_full {
  _reset
  _seed
  _success "Cedar DB is reset and seeded"
}

function restart_channels {
  docker-compose exec cedar-worker-channels bash -c "supervisorctl restart channels-worker"
  docker-compose exec cedar-worker-celery bash -c "supervisorctl restart celery-worker"
}

function restart_supervisor {
  docker-compose exec cedar-api bash -c "supervisorctl restart all"
}

function restart {
  restart_channels
  restart_supervisor
  _success "Cedar app is done restarting"
}

function _success {
  osascript -e "display notification \"$1\" with title \"Done\" sound name \"Hero\""
}

function cedar_exports {
  export CEDAR_SERVICES_ACTIVE=true
  export HOSTNAME=`hostname`
  export AWS_CREDENTIAL_HOME=~
}

function makemessages {
  django-admin makemessages -l=es
  _success "makemessages command complete"
}

function makemessagesjs {
  django-admin makemessages -d djangojs -l=es
  _success "makemessages command complete"
}

function compilemessages {
  django-admin compilemessages
  _success "compilemessages command complete"
}

function _reset {
  _nukedb
  _migrate
  _fixtures
}

function _seed {
  docker-compose run cedar-api ./manage.py loaddata automated_ui_tests.json
  # docker-compose run cedar-api ./manage.py shell < /usr/local/cedar/api/api_app/scripts/create-automated-ui-test-patients.py
}

function _nukedb {
  docker-compose run cedar-api ./manage.py nukedb
}

function _migrate {
  docker-compose run cedar-api ./manage.py migrate
}

function _fixtures {
  docker-compose run cedar-api ./manage.py loaddata api_app/fixtures/initial.json
}
