# README

Требования:
* Ruby 3.0.0
* Yarn
* Postgres

Установка зависимостей:
* bundle
* yarn install

Подготовка базы данных:
* rails db:create
````
CREATE USER db_cache_edit_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE db_cache_edit_development to db_cache_edit_user;
````
* rails db:migrate
* rails db:seed

Запуск:
* foreman start
