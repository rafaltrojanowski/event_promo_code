defmodule EventPromoCode.Services.PromoCodeValidatorTest do
  use EventPromoCode.ChannelCase, async: true
  import EventPromoCode.Factory

  alias EventPromoCode.Services.PromoCodeValidator

  @origin "Bangkok"
  @destination "Chiang Mai"
  @code "1a2s"

  describe "#call" do
    test "returns true if code is valid" do
      insert(:promo_code,
        code: @code,
        is_active: true,
        expires_at: DateTime.from_naive!(~N[2030-12-12 00:00:00], "Etc/UTC")
      )

      action = PromoCodeValidator.call(%{
        origin: @origin,
        destination: @destination,
        code: @code
      })

      {:ok, promo_code, directions} = action
      assert promo_code.id == promo_code.id
      assert directions != %{}
    end

    test "returns error if code is valid but not within radius" do
      insert(:promo_code,
        code: @code,
        is_active: true,
        expires_at: DateTime.from_naive!(~N[2030-12-12 00:00:00], "Etc/UTC")
      )

      action = PromoCodeValidator.call(%{
        origin: "Barcelona",
        destination: "Toronto",
        code: @code
      })

      {:error, message} = action
      assert message == "Promo code is not valid"
    end

    test "returns error when code does not exist" do
      action = PromoCodeValidator.call(%{
        origin: @origin,
        destination: @destination,
        code: "not-existing-code"
      })

      {:error, message} = action
      assert message == "Promo code is not valid"
    end

    test "returns error when code is not active" do
      insert(:promo_code, code: @code, is_active: false)

      action = PromoCodeValidator.call(%{
        origin: @origin,
        destination: @destination,
        code: @code
      })

      {:error, message} = action
      assert message == "Promo code is not valid"
    end

    test "returns error when code has expired" do
      insert(:promo_code,
        code: @code,
        is_active: true,
        expires_at: DateTime.from_naive!(~N[2010-12-12 00:00:00], "Etc/UTC")
      )

      action = PromoCodeValidator.call(%{
        origin: @origin,
        destination: @destination,
        code: @code
      })

      {:error, message} = action
      assert message == "Promo code is not valid"
    end
  end
end
