defmodule EventPromoCode.Api.PromoCodeControllerTest do
  use EventPromoCode.ConnCase
  import EventPromoCode.Factory

  test "/index returns a list of promo codes" do
    promo_code = insert(:promo_code)

    conn = build_conn()
    conn = get conn, api_promo_code_path(conn, :index)

    assert json_response(conn, 200) == %{
      "data" => [%{
        "code" => promo_code.code,
        "amount" => promo_code.amount,
        "event" => %{
          "id" => promo_code.event.id,
          "title" => promo_code.event.title,
          "description" => promo_code.event.description,
          "start_at" => DateTime.to_iso8601(promo_code.event.start_at),
          "end_at" => DateTime.to_iso8601(promo_code.event.end_at)
        },
        "expires_at" => DateTime.to_iso8601(promo_code.expires_at),
        "id" => promo_code.id,
        "is_active" => promo_code.is_active,
        "radius" => promo_code.radius
      }]
    }
  end

  test "#show renders a single promo code" do
    promo_code = insert(:promo_code)

    conn = build_conn()
    conn = get conn, api_promo_code_path(conn, :show, promo_code)

    assert json_response(conn, 200) == %{
      "data" => %{
        "code" => promo_code.code,
        "amount" => promo_code.amount,
        "event" => %{
          "id" => promo_code.event.id,
          "title" => promo_code.event.title,
          "description" => promo_code.event.description,
          "start_at" => DateTime.to_iso8601(promo_code.event.start_at),
          "end_at" => DateTime.to_iso8601(promo_code.event.end_at)
        },
        "expires_at" => DateTime.to_iso8601(promo_code.expires_at),
        "id" => promo_code.id,
        "is_active" => true,
        "radius" => nil
      }
    }
  end
end
