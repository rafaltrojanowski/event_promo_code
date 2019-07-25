defmodule EventPromoCode.Api.PromoCodeValidationView do
  use EventPromoCode.Web, :view

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, EventPromoCode.Api.PromoCodeView, "promo_code.json")}
  end

  def render("error.json", %{message: message}) do
    %{errors: %{promo_code: message}}
  end
end
