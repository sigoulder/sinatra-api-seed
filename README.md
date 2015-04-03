# Sinatra REST API Seed

## Setup
- create local `.env` file in root directory and add `AUTH_TOKEN_SECRET=somesecret`
- global search and replace `MyApp` to Your own app name
- change development and test db names in `config/database.yml`

## Start server
Goto home directory and run: `rackup`

## Access console
Goto home directory and run: `irb -r './app'`

## Run tests
`rake test:all`

## Existing Routes
- `POST /users` with `email, password` to create a new user
- `POST /auth` with `email, password` to get auth token
- `GET /users/:id` with auth token to retrieve user info
