defmodule EventPromoCode.Repo.Migrations.AddCodeToPromoCodes do
  use Ecto.Migration

  def up do
    alter table(:promo_codes) do
      add :code, :string, null: false
    end
    create unique_index(:promo_codes, :code)
  end

  def down do
    drop unique_index(:promo_codes, :code)
    alter table(:promo_codes) do
      remove :code
    end
  end
end
