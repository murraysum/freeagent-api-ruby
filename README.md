# Description

The official [FreeAgent](http://www.freeagent.com/) Ruby Client Library provides a simple Ruby interface for the [FreeAgent API 2.0](https://dev.freeagent.com/)

So what does this library have? Well the library wraps the API into a lovely little package providing rails-esque querying which makes it trivial to talk to FreeAgent.

Want all your draft invoices? Simple:
    `Invoice.draft`

Want to find all your contacts with open invoices?
    `Contact.open_clients`

Want to find your recurring expenses? Come on you’re not even making this hard anymore:
    `Expense.recurring`

# Important Notes

Please note the client is still a work in progress and is considered alpha.

Consequently, at this time it is advisable not to use this library in your development.

![tool](https://dev.freeagent.com/images/interface/masthead/masthead.png)

# Installation

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


# Usage


The following classes are available:
* FreeAgent::Attachment
* FreeAgent::BankAccount
* FreeAgent::BankTransaction
* FreeAgent::BankTransactionExplanation
* FreeAgent::Bill
* FreeAgent::Company
* FreeAgent::Contact
* FreeAgent::Estimate
* FreeAgent::Expense
* FreeAgent::Invoice
* FreeAgent::Note
* FreeAgent::Project
* FreeAgent::RecurringInvoice
* FreeAgent::Task
* FreeAgent::TimelineItem
* FreeAgent::Timeslip
* FreeAgent::User

## List all items

To list all bank accounts, for exemple, you can use `#all`:
```ruby
FreeAgent::BankAccount.all
```

## Filter items

You can retrieve only a subset of items (e.g. only *active* contacts) by using `#filter`:
```ruby
FreeAgent::Contact.filter(view: :active)
```

Some filters are required, like:
```ruby
FreeAgent::BankTransactionExplanation.filter(bank_account: 1234)
```

See the [API reference](https://dev.freeagent.com/docs) for list and definition of available and required filters.

## Find an item by id

You can retrieve a given item with `#find`:
```ruby
FreeAgent::Invoice.find(123)
```

# Todo

* Finish all of the resources exposed by the API.
* Tests
* Documentation
* Associations and nested resources
* Dirty Attributes

# Contributors

  * Murray Summers (Author & Maintainer)
  * [Yann Vaillant](https://github.com/vayan)
  * [Michael Baudino](https://github.com/michaelbaudino)
