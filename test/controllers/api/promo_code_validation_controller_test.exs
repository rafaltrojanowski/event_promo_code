defmodule EventPromoCode.Api.PromoCodeValidationControllerTest do
  use EventPromoCode.ConnCase
  import EventPromoCode.Factory

  @create_attrs %{
    code: "5ncv",
    origin: "Bangkok",
    destination: "Chiang Mai"
  }
  @invalid_attrs %{code: "not-existing-code", origin: "Bangkok", destination: "Chiang Mai"}
  @blank_attrs %{code: nil, origin: nil, destination: nil}

  describe "#create" do
    test "renders promo code and directions when code is valid", %{conn: conn} do
      insert(:promo_code,
        code: @create_attrs.code,
        is_active: true,
        expires_at: DateTime.from_naive!(~N[2030-12-12 00:00:00], "Etc/UTC")
      )

      conn = post(conn, api_promo_code_validation_path(conn, :create), promo_code_validation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert json_response(conn, 201)["data"]["directions"] != %{}
    end

    test "renders errors when code is invalid", %{conn: conn} do
      conn = post(conn, api_promo_code_validation_path(conn, :create), promo_code_validation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] == %{"promo_code" => "Promo code is not valid"}
    end

    test "renders errors when data is blank", %{conn: conn} do
      conn = post(conn, api_promo_code_validation_path(conn, :create), promo_code_validation: @blank_attrs)
      assert json_response(conn, 422)["errors"] == %{"code" => ["can't be blank"], "destination" => ["can't be blank"], "origin" => ["can't be blank"]}
    end
  end
end
