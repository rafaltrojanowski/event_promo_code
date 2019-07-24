defmodule EventPromoCode.Geo do

  def encode(address) do
    key = EventPromoCode.Env.get("GOOGLE_API_KEY")

    address = URI.encode(address)

    body = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{key}"
    |> HTTPoison.get!

    body = Jason.decode!(body.body)

    case body["status"] do
      "OK" ->
        %{"lat" => lat, "lng" => lng} = Enum.at(body["results"], 0)["geometry"]["location"]

        {:ok, %{lat: lat, lng: lng}}
      _ ->
        {:error, body}
    end
  end

end
