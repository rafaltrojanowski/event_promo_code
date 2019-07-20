defmodule EventPromoCode.Repo.Migrations.AddStartAtAndEndAtToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :start_at, :utc_datetime, null: false
      add :end_at, :utc_datetime, null: false
    end
  end
end
