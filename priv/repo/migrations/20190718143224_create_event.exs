defmodule EventPromoCode.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false

      timestamps()
    end
  end
end
