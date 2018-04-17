function _nukedb() {
  docker-compose run cedar-api ./manage.py nukedb
}

function _migrate() {
  docker-compose run cedar-api ./manage.py migrate
}

function _fixtures() {
  docker-compose run cedar-api ./manage.py loaddata api_app/fixtures/initial.json
}

function _reset() {
  _nukedb
  _migrate
  _fixtures
}

function reset-db() {
  _reset
  osascript -e 'display notification "Cedar DB is ready" with title "Done" sound name "Hero"'
}

function _seed() {
  docker-compose run cedar-api ./manage.py loaddata automated_ui_tests.json
  # docker-compose run cedar-api ./manage.py shell < /usr/local/cedar/api/api_app/scripts/create-automated-ui-test-patients.py
}


function seed-tests() {
  _seed
  osascript -e 'display notification "Cedar DB is fully seeded" with title "Done" sound name "Hero"'
}

function reset-db-full() {
  _reset
  _seed
  osascript -e 'display notification "Cedar DB is reset and seeded" with title "Done" sound name "Hero"'
}

function restart-channels() {
  docker-compose exec cedar-worker-channels bash -c "supervisorctl restart channels-worker"
  docker-compose exec cedar-worker-celery bash -c "supervisorctl restart celery-worker"
}

function restart-supervisor() {
  docker-compose exec cedar-api bash -c "supervisorctl restart all"
}

function restart() {
  restart-channels
  restart-supervisor
  osascript -e 'display notification "Cedar app is done restarting" with title "Done" sound name "Hero"'
}

function cedar-exports() {
  export CEDAR_SERVICES_ACTIVE=true
  export HOSTNAME=`hostname`
  export AWS_CREDENTIAL_HOME=~
}

function makemessages() {
  django-admin makemessages -l=es
  osascript -e 'display notification "makemessages command complete" with title "Done" sound name "Hero"'
}

function compilemessages() {
  django-admin compilemessages
  osascript -e 'display notification "compilemessages command complete" with title "Done" sound name "Hero"'
}
