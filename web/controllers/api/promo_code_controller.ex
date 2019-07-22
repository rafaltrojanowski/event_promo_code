defmodule EventPromoCode.Api.PromoCodeController do
  use EventPromoCode.Web, :controller

  alias EventPromoCode.PromoCode
  alias EventPromoCode.Services.PromoCodeCreator

  def create(conn, %{"promo_code" => params}) do
    case PromoCodeCreator.create(params) do
      {:ok, promo_code} ->
        conn
        |> put_status(:created)
        |> render("show.json", promo_code: promo_code)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(EventPromoCode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, params) do
    changeset = changeset(params)
    promo_codes = Repo.promo_code_search(changeset.changes)

    render(conn, "index.json", promo_codes: promo_codes)
  end

  def show(conn, %{"id" => id}) do
    promo_code = Repo.get!(PromoCode, id)
      |> Repo.preload(:event)
    render(conn, "show.json", promo_code: promo_code)
  end

  defp changeset(params) do
    data = %{}
    types = %{is_active: :boolean}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
  end
end
