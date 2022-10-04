defmodule PaymentsExample.BillingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PaymentsExample.Billing` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        number: 42,
        value: 42
      })
      |> PaymentsExample.Billing.create_invoice()

    invoice
  end
end
