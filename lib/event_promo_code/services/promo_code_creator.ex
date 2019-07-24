defmodule EventPromoCode.Services.PromoCodeCreator do
  alias EventPromoCode.PromoCode
  alias EventPromoCode.Repo

  def create(params) do
    changeset = PromoCode.changeset(%PromoCode{}, params)

    case Repo.insert(changeset) do
      {:ok, promo_code} ->
        promo_code = promo_code |> Repo.preload([:event])
        {:ok, promo_code}
      {:error, changeset} -> {:error, changeset}
    end
  end
end
