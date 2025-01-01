# docker-learn

## 8 - Laravel dockerized app

1. Create laravel project from template by using php composer utils container `docker-compose run --rm composer create-project --prefer-dist laravel/laravel .`. This will help to create template laravel files in `/app` directory in composer container which is bind mount to the local `/src` folder
2. Build the images with `docker-compose build`
3. Up all the container with `docker-compose up -d nginx php mysql`
4. Running migration DB with `docker-compose run --rm artisan migrate`
5. Access to `localhost:8000` to view the verify laravel app
