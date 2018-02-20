function reset-db() {
  docker-compose run cedar-api ./manage.py nukedb
  docker-compose run cedar-api ./manage.py migrate
  docker-compose run cedar-api ./manage.py loaddata api_app/fixtures/initial.json
  osascript -e 'display notification "Cedar DB is ready" with title "Done"'
}

function seed-tests() {
  docker-compose run cedar-api ./manage.py loaddata automated_ui_tests.json 
  docker-compose run cedar-api ./manage.py shell < /usr/local/cedar/api/api_app/scripts/create-automated-ui-test-patients.py
  osascript -e 'display notification "Cedar DB is fully seeded" with title "Done"'
}

function reset-db-full() {
  reset-db
  seed-tests
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
  osascript -e 'display notification "Cedar app is done restarting" with title "Done"'
}
