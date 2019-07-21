defmodule EventPromoCode.EventControllerTest do
  use EventPromoCode.ConnCase

  alias EventPromoCode.Event
  @valid_attrs %{
    title: "some title",
    description: "some description",
    latitude: 120.5,
    longitude: 120.5,
    start_at: "2010-04-17 14:00:00.000000Z",
    end_at: "2010-04-17 14:00:00.000000Z"
  }
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing events"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, event_path(conn, :new)
    assert html_response(conn, 200) =~ "New event"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @valid_attrs
    event = Repo.get_by!(Event, @valid_attrs)
    assert redirected_to(conn) == event_path(conn, :show, event.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert html_response(conn, 200) =~ "New event"
  end

  test "shows chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = get conn, event_path(conn, :show, event)
    assert html_response(conn, 200) =~ "Show event"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = get conn, event_path(conn, :edit, event)
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = put conn, event_path(conn, :update, event), event: @valid_attrs
    assert redirected_to(conn) == event_path(conn, :show, event)
    assert Repo.get_by(Event, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit event"
  end

  test "deletes chosen resource", %{conn: conn} do
    event = Repo.insert! %Event{
      start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
      end_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC")
    }
    conn = delete conn, event_path(conn, :delete, event)
    assert redirected_to(conn) == event_path(conn, :index)
    refute Repo.get(Event, event.id)
  end
end
