defmodule EventPromoCode.Services.PromoCodeValidator do
  alias EventPromoCode.PromoCode
  alias EventPromoCode.Repo

  @error_msg "Promo code is not valid"

  def call(params) do
    # TODO: validate all params
    # %{code: '1a2s', destination: "xsq1", origin: "Bangkok"}

    promo_code = Repo.get_by(PromoCode, code: params.code)

    case promo_code do
      promo_code ->
        case promo_code do
          nil ->
            {:error, @error_msg}
          _ ->
            valid = Date.compare(promo_code.expires_at, DateTime.utc_now) == :gt
            case promo_code.is_active && valid do
              true ->
                {:ok, promo_code}
              false ->
                # Promo code is not active or has already expired
                {:error, @error_msg}
            end
        end
    end
  end
end
