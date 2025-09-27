---
title: Global rescue_from error in Rails application_controller
date: 2019-04-28
author: Martin Brennan
layout: post
permalink: /rails-global-rescue-from-error-application-controller/
---

{% include deprecated.html message="Updated this article in 2025 with fresh information." cssclass="info" %}

In our (Webbernet at time of writing) rails application, we needed a way to raise security access violations based on the user profile and bubble them all the way up to the application controller. We looked into it and found you can use `rescue_from` in your application controller, which allows you to specify an error class and a method inside the controller to call when that error is encountered inside controller actions and filters. For example:

```ruby
class ApplicationController < ActionController::Base
  rescue_from Errors::SomeCustomErrorClass, with: :handle_error_method

  def handle_error_method(error)
    # Do some error handling
    redirect_to root_path, alert: error.message
  end
end
```

It’s probably not really a good idea to handle the normal ruby `StandardError` in this way, as that may get you into trouble, but it is perfect for custom errors raised deliberately from within your application! I really like this pattern of nesting an error definition class inside the class that is the one to raise that error. For example, in the result of a security check:

```ruby
class SecurityCheckResult
  class AuthorizationError < StandardError
  end

  def run
    raise AuthorizationError, "User is not authorized" if check_invalid?
  end
end
```

Then in application controller I could just `rescue_from SecurityCheckResult::AuthorizationError` to catch this anywhere in my app, and do something like a redirect or a flash. If you need to use this pattern in regular ruby code you can include the `ActiveSupport::Rescuable` module. [This article](https://simonecarletti.com/blog/2009/12/inside-ruby-on-rails-rescuable-and-rescue_from/) has a great example of using the module in regular ruby code (scroll down to the part that mentions RoboDomain).

Alternatively, you can look at the rails documentation for [Rescuable](https://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html)
