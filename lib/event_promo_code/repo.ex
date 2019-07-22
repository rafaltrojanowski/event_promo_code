defmodule EventPromoCode.Repo do
  use Ecto.Repo,
    otp_app: :event_promo_code,
    adapter: Ecto.Adapters.Postgres

  alias EventPromoCode.PromoCode
  alias EventPromoCode.Repo

  def promo_code_search(attrs) do
    is_active = get_in(attrs, [:is_active])

    if is_active != nil, do: PromoCode.by_active(is_active), else: Repo.all(PromoCode)
    |> Repo.preload(:event)
  end
end
