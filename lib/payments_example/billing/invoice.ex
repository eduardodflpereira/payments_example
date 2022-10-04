defmodule PaymentsExample.Billing.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :number, :integer
    field :value, :integer

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:value, :number])
    |> validate_required([:value, :number])
  end
end
