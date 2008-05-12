= merb_exceptions

* http://code.new-bamboo.co.uk

A simple Merb plugin to ease exception notifications.

Instead of a messy port of a rails plugin this is a complete rewrite from scratch and so is able to take full advantage of Merb's exception handling functionality.

The notifier currently supports two interfaces, Email Alerts and Web Hooks. Emails are formatted as plain text and sent using your Merb environments mail settings. Web hooks as sent as post requests, see 'Web Hooks' below for more info.

== Getting Going

Once you have the Gem installed you will need to add it as a dependancy in your projects init.rb file
	
	dependancy 'merb_exceptions'
	
If you don't already have a plugins.yml file in your config folder then you will need to create one and then setup some options, here is an example file. most of the options can be supplied as a single item or an array of items as in the example. See 'Settings' below for a full description of all the options and their details.

:exceptions:
  :app_name: My App Name
  :email_from: exceptions@myapp.com
  :web_hooks: 
    - http://www.google.com
    - http://localhost:4000/exceptions
  :email_addresses: 
		- user@myapp.com
		- hello@exceptions.com
  :environments:
		- staging
		- production

It's important to realise that the plugin is completely standalone, it doesn't modify any existing code or do anything else particularly magical. Because of this you will need to explicitly include the functionality in your application. It's very easy, simply add the following to your ExceptionsController just after the class definition.

	include MerbExceptions::ControllerExtensions

By default this will hook into all internal_server_error's and issue a notification, if you want to issue a notification from other exceptions we provide a few helper methods to make this dead simple. We will use 404's in an example below.

	def not_found
    render_and_notify :format=>:html
  end

render_and_notify - passes any provided options directly to Merb's render method and then sends the notification after rendering.
notify_of_exceptions - if you need to handle the render yourself for some reason then you can call this method directly. It sends notifications without any rendering logic. Note though that if you are sending lots of notifications this could delay sending a response back to the user so try to avoid using it where possible.

== SETTINGS:

app_name - used to customise emails, it defaults to "My App"
web_hooks - either a string or an array of strings, each url on the list is sent a post request on an exception. see 'Web Hooks' for more info.
email_addresses - either a string or an array of strings, each email address in the list is sent an exception notification using Merb's built in mailer settings.
environments - either a string or an array of strings, notifications will only be sent for environments in this list, defaults to 'production'

== WEB HOOKS:

Web hooks are a great way of pushing your data beyond your app to the outside world. For each address on your web_hooks list we will send a HTTP:POST request with the following parameters for you to consume.

request_url
request_controller
request_action
request_params
request_status_code
exception_name
exception_message
exception_backtrace
merb_exception_class
original_exception_class
environment

== REQUIREMENTS:

* Edge Merb

== INSTALL:

* rake install_gem

== LICENSE:

(The MIT License)

Copyright (c) 2008 New Bamboo

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.