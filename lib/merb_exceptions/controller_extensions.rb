module MerbExceptions
  module ControllerExtensions
    
    def self.included(mod)
      mod.class_eval do
        def internal_server_error
          self.render_and_notify :layout=>false
        end
      end
    end
    

    def render_and_notify(opts={})
      self.render_then_call(render(opts)) { notify_of_exceptions }
    end

    def notify_of_exceptions
      request = self.request

      details = {}
      details['exceptions']      = request.exceptions
      details['params']          = params
      details['environment']     = request.env.merge( 'process' => $$ )
      details['url']             = "#{request.protocol}#{request.env["HTTP_HOST"]}#{request.uri}"
      MerbExceptions::Notification.new(details).deliver!
    end
  end
end