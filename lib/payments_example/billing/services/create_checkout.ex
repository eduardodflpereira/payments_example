defmodule PaymentsExample.Billing.Service.CreateCheckout do
  @moduledoc """
  Simple service to create a stripe payment intent and checkout
  """
  def call(invoice) do
    base_url = PaymentsExampleWeb.Endpoint.url()

    checkout_data =
      %{line_items:
        [%{price_data: %{currency: "eur", product_data: %{name: "Invoice #{invoice.number}"}, unit_amount: invoice.value}, quantity: 1}],
         mode: "payment",
         success_url: base_url <> "/stripe-success",
         cancel_url: base_url <> "/stripe-cancel"
    }

    Stripe.Session.create(checkout_data)
  end
end
