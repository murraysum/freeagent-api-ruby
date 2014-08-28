Description
-----------
This is a Ruby client library that provides a simple interface to the [FreeAgent API](https://dev.freeagent.com/). This
is not an official FreeAgent project. It was created as a side project by one of our developers.

So what does this library have? Well the library wraps the API into a lovely little package providing rails-esque querying which makes it trivial to talk to FreeAgent.

Want all your draft invoices? Simple:
    `Invoice.draft`

Want to find all your contacts with open invoices?
    `Contact.open_clients`

Want to find your recurring expenses? Come on you’re not even making this hard anymore:
    `Expense.recurring`

Important Notes
---------------
This is a work in progress and is considered alpha. We warmly welcome pull requests from our developer community.

![tool](https://dev.freeagent.com/images/interface/masthead/masthead.png)

Todo
--------------------

- [ ] Finish all of the resources exposed by the API.
- [ ] Tests
- [ ] Documentation
- [ ] Associations and nested resources
- [ ] Dirty Attributes

Contributors
------------
  * Murray Summers (Author & Maintainer)
