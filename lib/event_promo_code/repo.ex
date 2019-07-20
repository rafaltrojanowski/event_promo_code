defmodule EventPromoCode.Repo do
  use Ecto.Repo,
    otp_app: :event_promo_code,
    adapter: Ecto.Adapters.Postgres
end
