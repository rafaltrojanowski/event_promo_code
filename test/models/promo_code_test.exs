defmodule EventPromoCode.PromoCodeTest do
  use EventPromoCode.ModelCase

  alias EventPromoCode.PromoCode

  @valid_attrs %{
    amount: 120.5,
    event_id: 42,
    expires_at: "2010-04-17 14:00:00.000000Z",
    is_active: true,
    radius: 120.5,
    code: "1cxa"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PromoCode.changeset(%PromoCode{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PromoCode.changeset(%PromoCode{}, @invalid_attrs)
    refute changeset.valid?
  end
end
