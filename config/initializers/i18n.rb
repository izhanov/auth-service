root = File.expand_path("../..", __dir__)

I18n.load_path += Dir[File.join(root, '/config/locales/**/*.yml')]
I18n.available_locales = %i[en ru]
I18n.default_locale = :ru
