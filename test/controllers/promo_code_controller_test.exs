defmodule EventPromoCode.PromoCodeControllerTest do
  use EventPromoCode.ConnCase

  alias EventPromoCode.PromoCode
  alias EventPromoCode.Event
  @valid_attrs %{
    amount: 120.5,
    expires_at: "2010-04-17 14:00:00.000000Z",
    is_active: true,
    radius: 120.5,
    code: "1ca9"
  }
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
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = post conn, promo_code_path(conn, :create),
      promo_code: Map.merge(@valid_attrs, %{event_id: event.id})

    promo_code = Repo.get_by!(PromoCode, @valid_attrs)
    assert redirected_to(conn) == promo_code_path(conn, :show, promo_code.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, promo_code_path(conn, :create), promo_code: @invalid_attrs
    assert html_response(conn, 200) =~ "New promo code"
  end

  test "shows chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    promo_code = Repo.insert! %PromoCode{event_id: event.id, code: "a1cx"}
    conn = get conn, promo_code_path(conn, :show, promo_code)
    assert html_response(conn, 200) =~ "Show promo code"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, promo_code_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    promo_code = Repo.insert! %PromoCode{event_id: event.id, code: "a1cx"}
    conn = get conn, promo_code_path(conn, :edit, promo_code)
    assert html_response(conn, 200) =~ "Edit promo code"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    promo_code = Repo.insert! %PromoCode{event_id: event.id, code: "a1cx"}
    conn = put conn, promo_code_path(conn, :update, promo_code), promo_code: @valid_attrs
    assert redirected_to(conn) == promo_code_path(conn, :show, promo_code)
    assert Repo.get_by(PromoCode, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    promo_code = Repo.insert! %PromoCode{event_id: event.id, code: "a1cx"}
    conn = put conn, promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit promo code"
  end

  test "deletes chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    promo_code = Repo.insert! %PromoCode{event_id: event.id, code: "a1cx"}
    conn = delete conn, promo_code_path(conn, :delete, promo_code)
    assert redirected_to(conn) == promo_code_path(conn, :index)
    refute Repo.get(PromoCode, promo_code.id)
  end
end
