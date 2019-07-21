defmodule EventPromoCode.EventTest do
  use EventPromoCode.ModelCase

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

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
