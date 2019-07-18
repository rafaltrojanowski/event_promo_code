use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :event_promo_code, EventPromoCode.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :event_promo_code, EventPromoCode.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "event_promo_code_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
