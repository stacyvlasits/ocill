# http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml
# 4.5 Cookies serializer
# Applications created before Rails 4.1 uses Marshal to serialize cookie values into the signed and
# encrypted cookie jars. If you want to use the new JSON-based format in your application, you can
# add an initializer file with the following content:

Rails.application.config.action_dispatch.cookies_serializer = :hybrid