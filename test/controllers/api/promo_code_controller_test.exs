defmodule EventPromoCode.Api.PromoCodeControllerTest do
  use EventPromoCode.ConnCase

  alias EventPromoCode.PromoCode
  alias EventPromoCode.Event

  test "/index returns a list of promo codes" do
    datetime = DateTime.utc_now()
    event = %Event{start_at: datetime, end_at: datetime, latitude: 11.39, longitude: 10.324}
    |> Repo.insert!
    promo_code = %PromoCode{code: "4x2i", amount: 30.00, event_id: event.id, expires_at: datetime}
    |> Repo.insert!

    conn = build_conn()
    conn = get conn, api_promo_code_path(conn, :index)

    assert json_response(conn, 200) == %{
      "data" => [%{
        "code" => promo_code.code,
        "amount" => promo_code.amount,
        "event" => %{
          "id" => event.id,
          "title" => nil,
          "description" => nil,
          "start_at" => DateTime.to_iso8601(event.start_at),
          "end_at" => DateTime.to_iso8601(event.end_at)
        },
        "expires_at" => DateTime.to_iso8601(promo_code.expires_at),
        "id" => promo_code.id,
        "is_active" => true,
        "radius" => nil
      }]
    }
  end

  test "#show renders a single promo code" do
    datetime = DateTime.utc_now()
    event = %Event{start_at: datetime, end_at: datetime, latitude: 11.39, longitude: 10.324}
    |> Repo.insert!
    promo_code = %PromoCode{code: "4x2i", amount: 30.00, event_id: event.id, expires_at: datetime}
    |> Repo.insert!

    conn = build_conn()
    conn = get conn, api_promo_code_path(conn, :show, promo_code)

    assert json_response(conn, 200) == %{
      "data" => %{
        "code" => promo_code.code,
        "amount" => promo_code.amount,
        "event" => %{
          "id" => event.id,
          "title" => nil,
          "description" => nil,
          "start_at" => DateTime.to_iso8601(event.start_at),
          "end_at" => DateTime.to_iso8601(event.end_at)
        },
        "expires_at" => DateTime.to_iso8601(promo_code.expires_at),
        "id" => promo_code.id,
        "is_active" => true,
        "radius" => nil
      }
    }
  end
end
