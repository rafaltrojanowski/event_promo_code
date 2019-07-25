defmodule EventPromoCode.Api.PromoCodeValidationView do
  use EventPromoCode.Web, :view

  def render("promo_code.json", %{promo_code: promo_code, directions: directions}) do
    %{id: promo_code.id,
      code: promo_code.code,
      amount: promo_code.amount,
      is_active: promo_code.is_active,
      expires_at: promo_code.expires_at,
      radius: promo_code.radius,
      event: render_one(promo_code.event, EventPromoCode.Api.EventView, "event.json"),
      directions: directions
    }
  end

  def render("show.json", %{promo_code: promo_code, directions: directions}) do
    %{data: render_one(
        promo_code,
        EventPromoCode.Api.PromoCodeValidationView,
        "promo_code.json",
        directions: directions,
        as: :promo_code
      )
    }
  end

  def render("error.json", %{message: message}) do
    %{errors: %{promo_code: message}}
  end
end
