defmodule EventPromoCode.Api.PromoCodeValidationController do
  use EventPromoCode.Web, :controller

  alias EventPromoCode.PromoCode
  alias EventPromoCode.Services.PromoCodeValidator

  def create(conn, %{"promo_code_validation" => params}) do
    changeset = changeset(params)

    if changeset.valid? do
      case PromoCodeValidator.call(changeset.changes) do
        {:ok, promo_code, directions} ->
          conn
          |> put_status(:created)
          |> render("show.json", promo_code: promo_code, directions: directions)
        {:error, message} ->
          conn
          |> put_status(422)
          |> render(EventPromoCode.Api.PromoCodeValidationView, "error.json", message: message)
      end
    else
      conn
      |> put_status(422)
      |> render(EventPromoCode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp changeset(params) do
    data = %{}
    types = %{code: :string, origin: :string, destination: :string}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:code, :origin, :destination])
  end
end
