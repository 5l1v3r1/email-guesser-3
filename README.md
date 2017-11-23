# Email Guesser

## Initial Instructions
Clone the repository and enter
```bash
git clone git@github.com:jozr/email-guesser.git
cd email-guesser
```

## Backend

### Setup
Bundle packages
```bash
bundle install
```

Set up the databases
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:test:prepare
```

### Tests
```bash
bundle exec rspec
```

### Running
Set up
```bash
bundle exec rake db:seed # or add sample data via cURL
bundle exec rackup -p 3000
```

Manually test the email address finder
`http://localhost:3000/email_address?Your+Name&company_domain=babbel.com`

## Frontend

I've set up the basics of an SPA using React.js.
```bash
npm start
```

I would love to complete the challenge, but 2 days was just not enough for me to do so thouroughly.
