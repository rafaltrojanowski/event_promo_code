defmodule EventPromoCode.Event do
  use EventPromoCode.Web, :model

  schema "events" do
    field :title, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :latitude, :longitude])
    |> validate_required([:title, :description, :latitude, :longitude])
  end
end
