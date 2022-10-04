defmodule PaymentsExample.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :value, :integer
      add :number, :integer

      timestamps()
    end
  end
end
