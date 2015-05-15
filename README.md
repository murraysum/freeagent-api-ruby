Description
-----------
The official [FreeAgent](http://www.freeagent.com/) Ruby Client Library provides a simple Ruby interface for the [FreeAgent API 2.0](https://dev.freeagent.com/)

So what does this library have? Well the library wraps the API into a lovely little package providing rails-esque querying which makes it trivial to talk to FreeAgent.

Want all your draft invoices? Simple:
    `Invoice.draft`

Want to find all your contacts with open invoices?
    `Contact.open_clients`

Want to find your recurring expenses? Come on you’re not even making this hard anymore:
    `Expense.recurring`

Important Notes
---------------
Please note the client is still a work in progress and is considered alpha.

Consequently, at this time it is advisable not to use this library in your development.

![tool](https://dev.freeagent.com/images/interface/masthead/masthead.png)

Usage
-----

Add the following to your `Gemfile`:
```ruby
gem 'freeagent-api-ruby', require: 'freeagent'
```

From your OmniAuth callback method, initialize with:
```ruby
FreeAgent.access_details(
  Rails.application.secrets.freeagent_id,
  Rails.application.secrets.freeagent_secret,
  access_token: @user.access_token
)
```

You may also consider creating an initializer (e.g. in `config/initializers/free_agent.rb`):
```ruby
FreeAgent.environment = Rails.application.secrets.freeagent_env.to_sym # should be either :sandbox or :production
```

Todo
--------------------
* Finish all of the resources exposed by the API.
* Tests
* Documentation
* Associations and nested resources
* Dirty Attributes

Contributors
------------
  * Murray Summers (Author & Maintainer)
