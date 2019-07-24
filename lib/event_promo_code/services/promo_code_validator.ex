defmodule EventPromoCode.Services.PromoCodeValidator do
  alias EventPromoCode.PromoCode
  alias EventPromoCode.Repo

  @error_msg "Promo code is not valid"

  def call(params) do
    promo_code = Repo.get_by(PromoCode, code: params.code)
    |> Repo.preload(:event)

    case validate_code(promo_code) do
      {:ok, promo_code} ->
        success = within_radius(promo_code, params.origin, params.destination)
        case success do
          true ->
            {:ok, promo_code}
          false ->
            {:error, @error_msg}
        end
      {:error, error_msg} ->
        {:error, error_msg}
    end
  end

  defp validate_code(promo_code) do
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

  defp within_radius(promo_code, origin, destination) do
    latitude = promo_code.event.latitude
    longitude = promo_code.event.longitude
    radius = promo_code.radius

    origin_coords = EventPromoCode.Geo.encode(origin) |> elem(1)
    destination_coords = EventPromoCode.Geo.encode(destination) |> elem(1)

    origin_distance_in_km = Distance.GreatCircle.distance({origin_coords.lat, origin_coords.lng}, {latitude, longitude}) / 1000
    destination_distance_in_km = Distance.GreatCircle.distance({destination_coords.lat, destination_coords.lng}, {latitude, longitude}) / 1000

    origin_distance_in_km < radius || destination_distance_in_km < radius
  end
end
