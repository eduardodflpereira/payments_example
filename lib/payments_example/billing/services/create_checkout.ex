defmodule PaymentsExample.Billing.Service.CreateCheckout do
  @moduledoc """
  Simple service to create a stripe checkout
  """
  def call(invoice) do
    PaymentsExampleWeb.Endpoint.url()
    |> generate_checkout_data(invoice)
    |> Stripe.Session.create()
  end

  defp generate_checkout_data(base_url, invoice) do
    %{line_items:
      [%{price_data: %{currency: "eur", product_data: %{name: "Invoice #{invoice.number}"}, unit_amount: invoice.value}, quantity: 1}],
        mode: "payment",
        success_url: base_url <> "/stripe-success",
        cancel_url: base_url <> "/stripe-cancel",
        metadata: %{invoice_id: invoice.id}
    }
  end
end
