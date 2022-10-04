defmodule PaymentsExample.Repo.Migrations.AddUniqueIndexToInvoiceNumber do
  use Ecto.Migration

  def change do
    create unique_index(:invoices, [:number])
  end
end
