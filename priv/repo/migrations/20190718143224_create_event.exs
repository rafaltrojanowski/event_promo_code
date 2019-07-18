defmodule EventPromoCode.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :text
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end
  end
end
