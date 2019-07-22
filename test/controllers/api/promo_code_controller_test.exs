defmodule EventPromoCode.Api.PromoCodeControllerTest do
  use EventPromoCode.ConnCase
  import EventPromoCode.Factory

  @create_attrs %{
    code: "5ncv",
    amount: 22.20,
    radius: 500,
    expires_at: DateTime.utc_now,
  }
  @invalid_attrs %{code: nil, amount: nil, radius: nil}

  describe "#create" do
    test "renders promo code when data is valid", %{conn: conn} do
      event = insert(:event)
      conn = post(conn, api_promo_code_path(conn, :create), promo_code: Map.put(@create_attrs, "event_id", event.id))
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, api_promo_code_path(conn, :create), promo_code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  test "#index returns a list of promo codes" do
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
