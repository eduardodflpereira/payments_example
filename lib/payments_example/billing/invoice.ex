defmodule PaymentsExample.Billing.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :number, :integer
    field :value, :integer
    field :status, :string, default: "created"

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:value, :number, :status])
    |> validate_required([:value, :number, :status])
    |> unique_constraint([:number])
  end
end
