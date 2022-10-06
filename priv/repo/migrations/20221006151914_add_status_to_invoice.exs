defmodule PaymentsExample.Repo.Migrations.AddStatusToInvoice do
  use Ecto.Migration

  def change do
    alter table(:invoices) do
      add :status, :text, default: "created", null: false
      modify :value, :integer, null: false
      modify :number, :integer, null: false
    end
  end
end
