# EventPromoCode

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Environment variables

Add to `.env`:

```
export GOOGLE_API_KEY="your_api_key"
```

and run:

```
source .env
```

## Running tests

```
source .env && mix test # first command loads env variables before running tests
```

## Todo
- [x] Generation of new promo codes for events
- [x] The promo code is worth a specific amount of ride
- [x] The promo code can expire
- [x] Can be deactivated
- [x] Return active promo codes
- [x] Return all promo codes
- [x] Only valid when user’s pickup or destination is within x radius of the event venue
- [x] The promo code radius should be configurable
- [x] To test the validity of the promo code, expose an endpoint that accept origin, destination,
the promo code. The api should return the promo code details and a polyline using the destination and origin if promo code is valid and an error otherwise.

## Improvements to consider:
- [ ] - Most likely successful validation of promo code should set is_active to false
- [ ] - Return active promo codes - endpoint currently returns all active promo codes (including expired), most likely it should filter out expired promo codes

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
