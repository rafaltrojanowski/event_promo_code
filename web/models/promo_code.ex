defmodule EventPromoCode.PromoCode do
  use EventPromoCode.Web, :model

  schema "promo_codes" do
    field :event_id, :integer, null: false
    field :amount, :float
    field :expires_at, :utc_datetime
    field :is_active, :boolean, default: true, null: false
    field :radius, :float
    field :code, :string, null: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_id, :amount, :expires_at, :is_active, :radius])
    |> validate_required([:event_id, :amount, :expires_at, :is_active, :radius])
  end
end
