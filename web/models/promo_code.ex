defmodule EventPromoCode.PromoCode do
  use EventPromoCode.Web, :model

  alias EventPromoCode.Repo
  alias EventPromoCode.PromoCode

  @derive {Jason.Encoder, except: [:__meta__, :event_id]}

  schema "promo_codes" do
    field :amount, :float
    field :expires_at, :utc_datetime
    field :is_active, :boolean, default: true, null: false
    field :radius, :float
    field :code, :string, null: false
    belongs_to :event, EventPromoCode.Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_id, :amount, :expires_at, :is_active, :radius, :code])
    |> validate_required([:event_id, :amount, :expires_at, :is_active, :radius, :code])
    |> unique_constraint(:code)
  end

  def by_active(is_active) do
    query = from PromoCode,
      where: [is_active: ^is_active],
      order_by: [asc: :expires_at],
      select: [:id, :code, :amount, :radius, :expires_at, :event_id, :is_active]

    Repo.all(query)
    |> Repo.preload(:event)
  end
end
