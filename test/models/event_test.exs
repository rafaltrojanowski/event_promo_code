defmodule EventPromoCode.EventTest do
  use EventPromoCode.ModelCase

  alias EventPromoCode.Event

  @valid_attrs %{description: "some description", latitude: 120.5, longitude: 120.5, title: "some title"}
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
