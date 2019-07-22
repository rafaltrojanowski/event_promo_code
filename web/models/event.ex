defmodule EventPromoCode.Event do
  use EventPromoCode.Web, :model

  @derive {Jason.Encoder, except: [:__meta__, :promo_codes]}

  schema "events" do
    field :title, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float
    field :start_at, :utc_datetime, null: false
    field :end_at, :utc_datetime, null: false
    has_many :promo_codes, EventPromoCode.PromoCode

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :latitude, :longitude, :start_at, :end_at])
    |> validate_required([:title, :description, :latitude, :longitude, :start_at, :end_at])
  end
end
