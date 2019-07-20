defmodule EventPromoCode.Api.PromoCodeView do
  use EventPromoCode.Web, :view

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, EventPromoCode.Api.PromoCodeView, "promo_code.json")}
  end

  def render("promo_code.json", %{promo_code: promo_code}) do
    %{id: promo_code.id,
      code: promo_code.code,
      amount: promo_code.amount,
      is_active: promo_code.is_active,
      expires_at: promo_code.expires_at,
      event_id: promo_code.event_id,
      radius: promo_code.radius
    }
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, EventPromoCode.Api.PromoCodeView, "promo_code.json")}
  end

end
