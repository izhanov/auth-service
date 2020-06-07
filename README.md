# auth-service

Микросервис Auth для курса Ruby Microservices.

# Зависимости

- Ruby `2.7.1`
- Bundler `2.1.4`
- Roda `3.32`
- Sequel `5.32.0`
- Puma `4.3+`
- PostgreSQL `9.3+`

# Установка и запуск приложения

1. Склонируйте репозиторий:

```
git clone git@github.com:izhanov/auth-service.git && cd auth-service
```

2. Установите зависимости и создайте базу данных:

```
bundle install

createdb -h localhost -U postgres auth_development
bin/rake db:migrate

createdb -h localhost -U postgres auth_test
RACK_ENV=test bin/rake db:migrate
```

3. Заполнение базы данных:

```
rake db:seed
```

4. Запуск приложения:

```
bin/puma
```

# Запуск консоли приложения

```
bin/console
```

# Запуск тестов

```
bin/rspec
```
