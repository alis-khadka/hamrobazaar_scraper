## Hamro Bazar Scraper

### Technology stack

- Rails 6.0.3.4
- Ruby 2.6.5
- SQlite
- Angular cli 11.0.2
- node v10.19.0

### Local development setup

```
git clone https://github.com/alis-khadka/hamrobazaar_scraper.git
cd hamrobazaar_scraper
bundle install
rails db:create
rails db:migrate db:seed
cd client
npm install
```

##### Running frontend, backend 

- Frontend (from client folder): `ng serve`
- API: `rails s`

Go to URL: http://localhost:4200
