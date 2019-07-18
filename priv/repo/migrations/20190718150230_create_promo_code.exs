defmodule EventPromoCode.Repo.Migrations.CreatePromoCode do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :event_id, references(:events), null: false
      add :amount, :float
      add :expires_at, :utc_datetime
      add :is_active, :boolean, default: true, null: false
      add :radius, :float

      timestamps()
    end
  end
end
