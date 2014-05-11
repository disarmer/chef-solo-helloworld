chef-solo-helloworld
====================

Рецепты chef-solo для автоматического деплоймента окружения rails/postgresql/unicorn/nginx.
Для использования требуют наличия стандартных кукбуков unicorn,database,nginx,ntp (https://github.com/opscode-cookbooks/) в директории cookbooks.

Данный рецепт выполняет конфигурирование инстанса ролью helloworld-srv, который настраивает окружение и пустое rails-приложение кукбуком helloworld-app. Конфигурация включает создание пользователя rails в postgresql, создание пустой базы данных rails, настройку unicorn и nginx и запуск всех компонентов связки. Протестирована работа на ubuntu precise.

Типичный деплоймент выглядит так(из директории с рецептами): knife solo cook user@host. Пример стандартного вывода: http://disarmer.ru/ln/?mA
