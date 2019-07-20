defmodule EventPromoCode.Api.PromoCodeController do
  use EventPromoCode.Web, :controller

  alias EventPromoCode.PromoCode

  def index(conn, _params) do
    promo_codes = Repo.all(PromoCode)
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def show(conn, %{"id" => id}) do
    promo_code = Repo.get!(PromoCode, id)
    render(conn, "show.json", promo_code: promo_code)
  end
end
