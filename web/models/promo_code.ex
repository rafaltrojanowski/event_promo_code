defmodule EventPromoCode.PromoCode do
  use EventPromoCode.Web, :model

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
  end
end
