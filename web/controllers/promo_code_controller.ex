defmodule EventPromoCode.PromoCodeController do
  use EventPromoCode.Web, :controller

  alias EventPromoCode.PromoCode

  def index(conn, _params) do
    promo_codes = Repo.all(PromoCode)
    render(conn, "index.html", promo_codes: promo_codes)
  end

  def new(conn, _params) do
    changeset = PromoCode.changeset(%PromoCode{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"promo_code" => promo_code_params}) do
    changeset = PromoCode.changeset(%PromoCode{}, promo_code_params)

    case Repo.insert(changeset) do
      {:ok, promo_code} ->
        conn
        |> put_flash(:info, "Promo code created successfully.")
        |> redirect(to: promo_code_path(conn, :show, promo_code))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    promo_code = Repo.get!(PromoCode, id)
    render(conn, "show.html", promo_code: promo_code)
  end

  def edit(conn, %{"id" => id}) do
    promo_code = Repo.get!(PromoCode, id)
    changeset = PromoCode.changeset(promo_code)
    render(conn, "edit.html", promo_code: promo_code, changeset: changeset)
  end

  def update(conn, %{"id" => id, "promo_code" => promo_code_params}) do
    promo_code = Repo.get!(PromoCode, id)
    changeset = PromoCode.changeset(promo_code, promo_code_params)

    case Repo.update(changeset) do
      {:ok, promo_code} ->
        conn
        |> put_flash(:info, "Promo code updated successfully.")
        |> redirect(to: promo_code_path(conn, :show, promo_code))
      {:error, changeset} ->
        render(conn, "edit.html", promo_code: promo_code, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    promo_code = Repo.get!(PromoCode, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(promo_code)

    conn
    |> put_flash(:info, "Promo code deleted successfully.")
    |> redirect(to: promo_code_path(conn, :index))
  end
end
