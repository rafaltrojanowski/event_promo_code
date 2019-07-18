defmodule EventPromoCode.PromoCodeControllerTest do
  use EventPromoCode.ConnCase

  alias EventPromoCode.PromoCode
  @valid_attrs %{amount: 120.5, event_id: 42, expires_at: "2010-04-17 14:00:00.000000Z", is_active: true, radius: 120.5}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, promo_code_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing promo codes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, promo_code_path(conn, :new)
    assert html_response(conn, 200) =~ "New promo code"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, promo_code_path(conn, :create), promo_code: @valid_attrs
    promo_code = Repo.get_by!(PromoCode, @valid_attrs)
    assert redirected_to(conn) == promo_code_path(conn, :show, promo_code.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, promo_code_path(conn, :create), promo_code: @invalid_attrs
    assert html_response(conn, 200) =~ "New promo code"
  end

  test "shows chosen resource", %{conn: conn} do
    promo_code = Repo.insert! %PromoCode{}
    conn = get conn, promo_code_path(conn, :show, promo_code)
    assert html_response(conn, 200) =~ "Show promo code"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, promo_code_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    promo_code = Repo.insert! %PromoCode{}
    conn = get conn, promo_code_path(conn, :edit, promo_code)
    assert html_response(conn, 200) =~ "Edit promo code"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    promo_code = Repo.insert! %PromoCode{}
    conn = put conn, promo_code_path(conn, :update, promo_code), promo_code: @valid_attrs
    assert redirected_to(conn) == promo_code_path(conn, :show, promo_code)
    assert Repo.get_by(PromoCode, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    promo_code = Repo.insert! %PromoCode{}
    conn = put conn, promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit promo code"
  end

  test "deletes chosen resource", %{conn: conn} do
    promo_code = Repo.insert! %PromoCode{}
    conn = delete conn, promo_code_path(conn, :delete, promo_code)
    assert redirected_to(conn) == promo_code_path(conn, :index)
    refute Repo.get(PromoCode, promo_code.id)
  end
end
