#FIXME middleware monkeypatch
# нужно для того, что бы ошибки при json запросах рендерились json форматом

module ActionDispatch
  class ShowExceptions
    def call(env)
      @app.call(env)
    rescue Exception => exception
      if env["REQUEST_PATH"] =~ /[^\&]+(\.json)&?/
        env["action_dispatch.request.formats"] = [Mime::JSON]
      end
      if env['action_dispatch.show_exceptions'] == false
        raise exception
      else
        render_exception(env, exception)
      end
    end
  end
end
