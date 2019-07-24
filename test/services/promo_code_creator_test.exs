defmodule EventPromoCode.Services.PromoCodeCreatorTest do
  use EventPromoCode.ChannelCase, async: true

  import EventPromoCode.Factory

  alias EventPromoCode.Services.PromoCodeCreator
  alias EventPromoCode.PromoCode

  describe "#create" do
    test "creates a promo code when valid" do
      event = insert(:event)

      PromoCodeCreator.create(%{
        event_id: event.id,
        code: "xsq1",
        amount: 100.00,
        radius: 1000.00,
        expires_at: DateTime.utc_now
      })

      promo_code = Repo.one!(PromoCode)

      assert promo_code.event_id == event.id
      assert promo_code.code == "xsq1"
    end

    test "retruns errors when not valid" do
      event = insert(:event)

      action = PromoCodeCreator.create(%{
        event_id: event.id,
        code: "xsq1"
      })

      {:error, data } = action
      assert data.errors == [
        amount: {"can't be blank", [validation: :required]},
        expires_at: {"can't be blank", [validation: :required]},
        radius: {"can't be blank", [validation: :required]}
      ]
    end
  end
end
