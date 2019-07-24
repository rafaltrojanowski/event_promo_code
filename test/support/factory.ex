defmodule EventPromoCode.Factory do
  use ExMachina.Ecto, repo: EventPromoCode.Repo

  def event_factory do
    title = sequence(:title, &"Event (#{&1})")
    description = sequence(:description, &"Event description (#{&1})")

    %EventPromoCode.Event{
      title: title,
      description: description,
      latitude: 13.767814,
      longitude: 100.4317543,
      start_at: DateTime.utc_now,
      end_at: DateTime.utc_now,
    }
  end

  def promo_code_factory do
    code = sequence(:code, &"ax4#{&1})")
    amount = 10.00

    %EventPromoCode.PromoCode{
      code: code,
      amount: amount,
      radius: 100.00, # km
      expires_at: DateTime.utc_now,
      event: build(:event)
    }
  end
end
